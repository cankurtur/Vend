//
//  PhotoListDisplayItem.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import Foundation

// MARK: - PhotoListDisplayItem

enum PhotoListDisplayItem: Identifiable {
    case content(PhotoCellModel)
    case ad
    
    var id: UUID {
        switch self {
        case .ad, .content:
            return UUID()
        }
    }
}
