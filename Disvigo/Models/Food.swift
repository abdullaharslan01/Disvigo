//
//  Food.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation

struct Food: Codable, Equatable, Hashable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let images: [String]
    
    init(title: String, description: String, images: [String], id: UUID? = nil) {
        self.id = id ?? UUID()
        self.title = title
        self.description = description
        self.images = images
    }
    
    static func ==(lhs: Food, rhs: Food) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
