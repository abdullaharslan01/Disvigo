//
//  VisitedList.swift
//  Disvigo
//
//  Created by abdullah on 31.05.2025.
//

import SwiftData
import SwiftUI

@Model
final class VisitedList {
    @Attribute(.unique) var id: UUID
    var name: String
    var symbolName: String
    var colorHex: String

    var addedDate: Date
    @Relationship(deleteRule: .cascade)
    var visitedItems: [VisitedListItem] = []

    init(
        name: String,
        symbolName: String = "checkmark.circle",
        color: Color = .appGreenPrimary,
        addedDate: Date = .now
    ) {
        self.id = UUID()
        self.name = name
        self.symbolName = symbolName
        self.colorHex = color.toHex() ?? "#0000FF"
        self.addedDate = addedDate
    }

    var color: Color {
        Color(hex: colorHex)
    }
}

@Model
final class VisitedListItem {
    var locationId: String
    var locationTitle: String
    var locationDescriptionText: String
    var locationImages: [String]
    var locationLatitude: Double
    var locationLongitude: Double
    var visitedDate: Date
    var list: VisitedList?

    init(location: Location, visitedDate: Date, list: VisitedList) {
        self.locationId = location.id
        self.locationTitle = location.title
        self.locationDescriptionText = location.description
        self.locationImages = location.images
        self.locationLatitude = location.coordinates.latitude
        self.locationLongitude = location.coordinates.longitude
        self.visitedDate = visitedDate
        self.list = list
    }

    var location: Location {
        Location(
            id: locationId,
            title: locationTitle,
            description: locationDescriptionText,
            images: locationImages,
            coordinates: Coordinates(latitude: locationLatitude, longitude: locationLongitude)
        )
    }
}
