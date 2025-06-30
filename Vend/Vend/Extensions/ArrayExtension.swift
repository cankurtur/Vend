//
//  ArrayExtension.swift
//  Vend
//
//  Created by Can Kurtur on 2025-07-01.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
