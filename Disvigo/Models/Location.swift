//
//  Location.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation

struct Location: Codable, Equatable, Hashable, Identifiable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.title == rhs.title
    }

    let title: String
    let description: String
    let images: [String]
    let coordinates: Coordinates

    var id: String {
        return title
    }
}
