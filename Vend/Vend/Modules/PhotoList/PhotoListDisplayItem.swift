//
//  PhotoListDisplayItem.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import Foundation
import GoogleMobileAds

// MARK: - PhotoListDisplayItem

enum PhotoListDisplayItem: Identifiable {
    case content(PhotoCellModel)
    case ad(BannerAdViewModel)
    
    var id: UUID {
        switch self {
        case .ad(let model):
            return model.id
        case .content(let model):
            return model.id
        }
    }
}
