//
//  PhotoResponse.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

struct PhotoResponse: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
