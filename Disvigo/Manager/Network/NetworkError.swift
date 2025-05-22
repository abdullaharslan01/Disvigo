//
//  NetworkError.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case unknown

    var errorDescription: String? {
        switch self {
        case .badURL:
            return String(localized: "Invalid URL.")
        case .requestFailed:
            return String(localized: "Request failed. Please check your connection.")
        case .invalidResponse:
            return String(localized: "Invalid server response.")
        case .decodingFailed:
            return String(localized: "Failed to decode data.")
        case .unknown:
            return String(localized: "An unknown error occurred.")
        }
    }
}
