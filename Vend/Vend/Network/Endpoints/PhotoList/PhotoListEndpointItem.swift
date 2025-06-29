//
//  PhotoListEndpointItem.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import GlobalNetworking

enum PhotoListEndpointItem: Endpoint {
    case getPhotos(start:Int, limit: Int)
    
    var path: String {
        switch self {
        case .getPhotos(let start, let limit):
            return "/photos?_start=\(start)&_limit=\(limit)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
}
