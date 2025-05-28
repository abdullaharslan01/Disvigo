//
//  Location.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation

struct Location: Codable, Equatable, Hashable, Identifiable {
    let id: String
    let title: String
    let description: String
    let images: [String]
    let coordinates: Coordinates

    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
