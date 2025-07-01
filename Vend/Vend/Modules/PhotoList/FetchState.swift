//
//  FetchState.swift
//  Vend
//
//  Created by Can Kurtur on 2025-07-01.
//

import Foundation

/// Enum representing the state of a fetch operation
enum FetchState: Equatable {
    /// Initial state before the fetch starts.
    case initial
    /// The loading state.
    case loading
    /// The fetch was successful.
    case success
    ///     /// An error occurred during the fetch, includes an `message` for error details.
    case failure(message: String)
}
