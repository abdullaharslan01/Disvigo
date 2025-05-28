//
//  Category.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import Foundation

enum Category: CaseIterable {
    case location
    case food
    case memory

    var id: String {
        return self.name
    }

    var name: String {
        switch self {
        case .location:
            return String(localized: "Discovery Points")
        case .memory:
            return String(localized: "Journey Memories")
        case .food:
            return String(localized: "Local Cuisine")
        }
    }

    var imageName: String {
        switch self {
        case .location:
            return AppImages.Category.discoveryPoints
        case .memory:
            return AppImages.Category.journeyMemories
        case .food:
            return AppImages.Category.localCuisine
        }
    }
    
    var systemImageName:String {
        switch self {
        case .location:
            return AppIcons.locationDetail
        case .food:
            return AppIcons.food
        case .memory:
            return AppIcons.fossil
        }
    }
}
