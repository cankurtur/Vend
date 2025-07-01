//
//  PhotoListViewModel.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-25.
//

import Foundation

// MARK: - Constant

private enum Constant {
    static let limit: Int = Config.shared.apiFetchLimit
    static let defaultAdPreLoadCount: Int = 10
    static let paginationStartingPage: Int = 1
    static let adModValue: Int = 10
}

// MARK: - PhotoListViewModel

final class PhotoListViewModel: ObservableObject {
    @Published private(set) var items: [PhotoListDisplayItem] = []
    @Published private(set) var fetchState: FetchState = .initial
    
    private var currentAPIPage = Constant.paginationStartingPage
    private let photoListService: PhotoListServiceable
    private let limit = Constant.limit
    
    init(photoListService: PhotoListServiceable = PhotoListService()) {
        self.photoListService = photoListService
        AdManager.shared.preloadBannerAds(count: Constant.defaultAdPreLoadCount)
    }
    
    func getItems() async {
        let response = await photoListService.getPhotos(page: currentAPIPage, limit: limit)
        
        switch response {
        case .success(let photos):
            await MainActor.run {
                fetchState = .success
            }
            handleSuccessResponse(photos: photos)
            currentAPIPage.increase()
            
        case .failure(let error):
            await MainActor.run {
                fetchState = .failure(message: error.message)
            }
        }
    }
    
    func paginateIfNeeded(for index: Int ) async {
        if index == items.count - 1 {
            await getItems()
        }
    }
}

// MARK: - Response Handler

extension PhotoListViewModel {
    func handleSuccessResponse(photos: [PhotoResponse]) {
        var result: [PhotoListDisplayItem] = []
        var latestIndex = items.count
        
        // Convert photos to the Content type
        var newPhotoItems: [PhotoListDisplayItem] = photos.map { photo in
            let model = PhotoCellModel(
                title: photo.title,
                photoURL: photo.url,
                thumbnailURL: photo.thumbnailUrl
            )
            return .content(model)
        }
        
        // Add photos to the result array. In the meantime, add new add if the index is 4, 6, 7
        while !newPhotoItems.isEmpty {
            let mod = latestIndex % Constant.adModValue
            if mod == 4 || mod == 6 || mod == 7,
               let firstBanner = AdManager.shared.getNextBanner() {
                result.append(.ad(firstBanner))
                AdManager.shared.loadNewBanner()
            } else {
                result.append(newPhotoItems.removeFirst())
            }
            latestIndex.increase()
        }
        
        // Append latest result to the list display items
        DispatchQueue.main.async {
            self.items.append(contentsOf: result)
        }
    }
}

