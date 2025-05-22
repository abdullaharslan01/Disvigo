//
//  City.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import CoreLocation
import Foundation

struct City: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let coordinates: Coordinates
    let description: String
    let region: String
    let imageUrl: String
}

struct Coordinates: Codable, Hashable {
    let latitude: Double
    let longitude: Double
}

extension Coordinates {
    var clLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
