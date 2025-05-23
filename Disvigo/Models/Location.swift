//
//  Location.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation

struct Location: Codable {
    let title: String
    let description: String
    let images: [String]
    let coordinates: Coordinates
}
