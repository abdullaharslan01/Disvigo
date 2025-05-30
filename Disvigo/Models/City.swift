//
//  City.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import CoreLocation
import Foundation
import SwiftData

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

    var asCLLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}


@Model
final class SavedCity {
    @Attribute(.unique) var id: Int
    var name: String
    var cityDescription: String
    var region: String
    var imageUrl: String
    var latitude: Double
    var longitude: Double
    var dateSaved: Date
    
    init(from city: City) {
        self.id = city.id
        self.name = city.name
        self.cityDescription = city.description
        self.region = city.region
        self.imageUrl = city.imageUrl
        self.latitude = city.coordinates.latitude
        self.longitude = city.coordinates.longitude
        self.dateSaved = Date()
    }
    
    var city: City {
        City(
            id: id,
            name: name,
            coordinates: Coordinates(latitude: latitude, longitude: longitude),
            description: cityDescription,
            region: region,
            imageUrl: imageUrl
        )
    }
    
    // CoreLocation convenience properties
    var clLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var asCLLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
