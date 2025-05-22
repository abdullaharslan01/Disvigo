//
//  Category.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import Foundation

enum Category: CaseIterable {
    case discoveryPoints

    case journeyMemories
    case localCuisine

    var id: String {
        return self.name
    }

    var name: String {
        switch self {
        case .discoveryPoints:
            return String(localized: "Discovery Points")
        case .journeyMemories:
            return String(localized: "Journey Memories")
        case .localCuisine:
            return String(localized: "Local Cuisine")
        }
    }

    var imageName: String {
        switch self {
        case .discoveryPoints:
            return AppImages.Category.discoveryPoints
        case .journeyMemories:
            return AppImages.Category.journeyMemories
        case .localCuisine:
            return AppImages.Category.localCuisine
        }
    }
}
