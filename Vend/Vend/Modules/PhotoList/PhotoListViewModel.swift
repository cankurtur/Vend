//
//  PhotoListViewModel.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-25.
//

import Foundation

// MARK: - PhotoListViewModel

final class PhotoListViewModel: ObservableObject {
    @Published var items: [PhotoListDisplayItem] = []
    @Published var isLoading = false
    
    private let photoListService: PhotoListServiceable
    private var pageStartIndex: Int = 0
    private let limit = Config.shared.apiFetchLimit

    init(photoListService: PhotoListServiceable = PhotoListService()) {
        self.photoListService = photoListService
        AdManager.shared.preloadBannerAds(count: 3)
    }
    
    func getItems() async {
        guard !isLoading else { return }
        await MainActor.run {
            isLoading = true
        }
        
        let response = await photoListService.getPhotos(start: pageStartIndex, limit: limit)
        
        switch response {
        case .success(let photos):
            handleSuccessResponse(photos: photos)
            pageStartIndex += limit
            await MainActor.run {
                isLoading = false
            }
        case .failure(let error):
            handleFailureResponse(error: error)
            await MainActor.run {
                isLoading = false
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
        var latextIndex = items.count
        
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
            let mod = latextIndex  % 10
            if mod == 4 || mod == 6 || mod == 7,
               let firstBanner = AdManager.shared.getNextBanner() {
                result.append(.ad(firstBanner))
                AdManager.shared.preloadBannerAds(count: 1) // After adding ad, refetch one more ad in to the pool.
            } else {
                result.append(newPhotoItems.removeFirst())
            }
            latextIndex += 1
        }
        
        // Append latest result to the list display items
        DispatchQueue.main.async {
            self.items.append(contentsOf: result)
        }
    }
    
    func handleFailureResponse(error: APIClientError) {
        
    }
}
