//
//  PhotoListEndpointItem.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import GlobalNetworking

enum PhotoListEndpointItem: Endpoint {
    case getPhotos
    
    var path: String {
        switch self {
        case .getPhotos:
            return "/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
}
