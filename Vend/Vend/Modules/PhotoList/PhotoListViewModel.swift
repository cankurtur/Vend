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
            AdManager.shared.preloadBannerAds(count: 3)
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
        let banners: [BannerAdViewModel] = AdManager.shared.getNextBanners(count: 3)
        var result: [PhotoListDisplayItem] = []
        
        let newPhotoItems: [PhotoListDisplayItem] = photos.map { photo in
            let model = PhotoCellModel(
                title: photo.title,
                photoURL: photo.url,
                thumbnailURL: photo.thumbnailUrl
            )
            return .content(model)
        }
        
        result.append(contentsOf: newPhotoItems)
        
        let insertIndices = [4,6,7]
        for (i, index) in insertIndices.enumerated() {
            guard index <= result.count, i < banners.count else { continue }
            let adItem = PhotoListDisplayItem.ad(banners[i])
            result.insert(adItem, at: index)
        }
        
        DispatchQueue.main.async {
            self.items.append(contentsOf: result)
        }
        
    }
    
    func handleFailureResponse(error: APIClientError) {
        
    }
}
