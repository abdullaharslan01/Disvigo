//
//  Location.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation
import SwiftData

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

@Model
final class SavedLocation {
    var id: String
    var title: String
    var descriptionText: String
    var images: [String]
    var latitude: Double
    var longitude: Double
    var dateSaved: Date

    init(from location: Location) {
        self.id = location.id
        self.title = location.title
        self.descriptionText = location.description
        self.images = location.images
        self.latitude = location.coordinates.latitude
        self.longitude = location.coordinates.longitude
        self.dateSaved = Date()
    }

    var location: Location {
        Location(
            id: id,
            title: title,
            description: descriptionText,
            images: images,
            coordinates: Coordinates(latitude: latitude, longitude: longitude)
        )
    }
}
