//
//  ClientError.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

class ClientError: APIError {
    var message: String
    var statusCode: Int?
}
