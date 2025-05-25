//
//  MemoryListViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class MemoryListViewModel {
    let memories: [Memory]
    
    var cityName:String = ""
    var previousResultCount = 0

    var searchText = ""

    var filteredMemories: [Memory] {
        if searchText.isEmpty {
            return memories
        } else {
            return memories.filter { memory in
                memory.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init(memories: [Memory],cityName:String) {
        self.memories = memories
        self.previousResultCount = memories.count
        self.cityName = cityName
    }
}
