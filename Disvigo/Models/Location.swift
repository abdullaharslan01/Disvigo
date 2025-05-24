//
//  Location.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation

struct Location: Codable, Equatable, Hashable, Identifiable {
    let id: UUID  // Otomatik UUID üretecek
    let title: String
    let description: String
    let images: [String]
    let coordinates: Coordinates
    
    init(title: String, description: String, images: [String], coordinates: Coordinates, id: UUID? = nil) {
        self.id = id ?? UUID()
        self.title = title
        self.description = description
        self.images = images
        self.coordinates = coordinates
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id  // Artık ID'ye göre karşılaştırma yapıyoruz
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
