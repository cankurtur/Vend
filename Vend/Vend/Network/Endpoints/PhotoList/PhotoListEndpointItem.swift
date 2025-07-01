//
//  PhotoListEndpointItem.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import GlobalNetworking

enum PhotoListEndpointItem: Endpoint {
    case getPhotos(page:Int, limit: Int)
    
    var path: String {
        switch self {
        case .getPhotos(let page, let limit):
            return "/photos?_page=\(page)&_limit=\(limit)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
}
