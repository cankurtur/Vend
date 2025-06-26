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
    private let photoListService: PhotoListServiceable

    init(photoListService: PhotoListServiceable = PhotoListService()) {
        self.photoListService = photoListService
    }
    
    @MainActor
    func getItems() async {
        let response = await photoListService.getPhotos()
        
        switch response {
        case .success(let photos):
            let newItems: [PhotoListDisplayItem] = photos.map { photo in
                let model = PhotoCellModel(
                    title: photo.title,
                    photoURL: photo.url,
                    thumbnailURL: photo.thumbnailUrl
                )
                return .content(model)
            }
            
            items.append(contentsOf: newItems)
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
