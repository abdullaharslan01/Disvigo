//
//  LocationDetailViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class LocationDetailViewModel {
    let location: Location

    init(location: Location) {
        self.location = location
    }

    var rotationTimer: Timer?
    var showFullDescription = false
    var rotationAngle: Double = 0

    var isFavorite: Bool {
        return false
    }
}
