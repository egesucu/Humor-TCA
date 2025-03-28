//
//  APIErrors.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import Foundation

enum APIErrors: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case emptySearchQuery
}

extension APIErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "The given URL is invalid"
        case .invalidResponse:
            "The response is not valid."
        case .decodingFailed:
            "Decoding has failed."
        case .emptySearchQuery:
            "The search query is empty."
        }
    }
}
