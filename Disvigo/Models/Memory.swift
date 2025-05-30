//
//  Memory.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import Foundation
import SwiftData

struct Memory: Codable, Equatable, Hashable, Identifiable {
    let id: String
    let title: String
    let description: String
    let images: [String]
    
    static func ==(lhs: Memory, rhs: Memory) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Model
final class SavedMemory {
    @Attribute(.unique) var id: String
    var title: String
    var memoryDescription: String 
    var images: [String]
    var dateSaved: Date
    
    init(from memory: Memory) {
        self.id = memory.id
        self.title = memory.title
        self.memoryDescription = memory.description
        self.images = memory.images
        self.dateSaved = Date()
    }
    
    var memory: Memory {
        Memory(
            id: id,
            title: title,
            description: memoryDescription,
            images: images
        )
    }
}
