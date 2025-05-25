//
//  LocationListViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class LocationListViewModel {
    var searchText = ""
    var locations: [Location]
    let cityTitle: String
    
    var previousResultCount = 0

    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return locations
        } else {
            return locations.filter { location in
                location.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    init(locations: [Location], cityTitle: String) {
        self.locations = locations
        self.cityTitle = cityTitle
        previousResultCount = locations.count
    }
}
