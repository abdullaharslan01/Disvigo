//
//  Food.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation
import SwiftData

struct Food: Codable, Equatable, Hashable, Identifiable {
    let id: String
    let title: String
    let description: String
    let images: [String]

    static func ==(lhs: Food, rhs: Food) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Model
final class SavedFood {
    var id: String
    var title: String
    var foodDescription: String
    var images: [String]
    var dateSaved: Date

    init(from food: Food) {
        self.id = food.id
        self.title = food.title
        self.foodDescription = food.description
        self.images = food.images
        self.dateSaved = Date()
    }

    var food: Food {
        Food(
            id: id,
            title: title,
            description: foodDescription,
            images: images
        )
    }
}
