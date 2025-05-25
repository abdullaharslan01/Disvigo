//
//  MemoryDetailViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class MemoryDetailViewModel {
    let memory: Memory

    init(memory: Memory) {
        self.memory = memory
    }

    var isFavorite: Bool {
        return false
    }
}
