//
//  PhotoListService.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import GlobalNetworking

/// Represents a set of services for fetching and managing photo list data.
protocol PhotoListServiceable {
    func getPhotos(start: Int, limit: Int) async ->  Result<[PhotoResponse], APIClientError>
}

/// Concrete service conforming to `PhotoListServiceable`, responsible for fetching and managing photo list data.
actor PhotoListService: PhotoListServiceable {
    private let networkManager = NetworkManager<PhotoListEndpointItem>(clientErrorType: ClientError.self)
    
    /// Fetches a list of photos.
    ///
    /// - Returns: A result object containing `[PhotoResponse]` on success or `APIClientError` on failure.
    func getPhotos(start: Int, limit: Int) async ->  Result<[PhotoResponse], APIClientError> {
        do {
            let response = try await networkManager.request(endpoint: .getPhotos(start: start, limit: limit), responseType: [PhotoResponse].self)
            return .success(response)
        } catch let error as APIClientError {
            return .failure(error)
        } catch {
            return .failure(.networkError)
        }
    }
}
