//
//  MapManager.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import MapKit
import SwiftUI

class MapManager {
    static let shared = MapManager()
    
    private init() {}
    
    func openInAppleMaps(coordinate: CLLocationCoordinate2D, name: String) {
        let destinationPlacemark = MKPlacemark(coordinate: coordinate)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        destinationMapItem.name = name
        
        MKMapItem.openMaps(
            with: [destinationMapItem],
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ]
        )
    }
    
    func openInGoogleMaps(coordinate: CLLocationCoordinate2D, name: String) {
        let urlString = "comgooglemaps://?daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving"
        
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encoded),
           UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Web fallback
            let webUrlString = "https://www.google.com/maps/dir/?api=1&destination=\(coordinate.latitude),\(coordinate.longitude)&travelmode=driving"
            if let encoded = webUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: encoded)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func openInYandexMaps(coordinate: CLLocationCoordinate2D, name: String) {
        let urlString = "yandexmaps://build_route_on_map?lat_to=\(coordinate.latitude)&lon_to=\(coordinate.longitude)"
        
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encoded),
           UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openAppleMaps(searchQuery: String) {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "http://maps.apple.com/?q=\(encodedQuery)"
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func openGoogleMaps(searchQuery: String) {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "comgooglemaps://?q=\(encodedQuery)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let webUrlString = "https://www.google.com/maps/search/?api=1&query=\(encodedQuery)"
            if let webUrl = URL(string: webUrlString) {
                UIApplication.shared.open(webUrl)
            }
        }
    }
    
    
    func openRouteInAppleMaps(stops: [Location], mode: TravelMode = .automobile) {
        guard !stops.isEmpty else { return }
        
        let currentLocationItem = MKMapItem.forCurrentLocation()
        currentLocationItem.name = "My Location"
        
        let destinationItems = stops.map { stop -> MKMapItem in
            let placemark = MKPlacemark(coordinate: stop.coordinates.clLocationCoordinate2D)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = stop.title
            return mapItem
        }
        
        let allItems = [currentLocationItem] + destinationItems
        
        MKMapItem.openMaps(
            with: allItems,
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey: mode.appleMapsValue
            ]
        )
    }
    
    func openRouteInGoogleMaps(stops: [Location], mode: TravelMode = .automobile) {
        guard stops.count >= 2 else { return }

        let origin = stops.first!.coordinates
        let destination = stops.last!.coordinates
        let waypoints = stops.dropFirst().dropLast().map {
            "\($0.coordinates.latitude),\($0.coordinates.longitude)"
        }

        var urlString = "https://www.google.com/maps/dir/?api=1"
        urlString += "&origin=\(origin.latitude),\(origin.longitude)"
        urlString += "&destination=\(destination.latitude),\(destination.longitude)"

        if !waypoints.isEmpty {
            let waypointString = waypoints.joined(separator: "|")
            if let encoded = waypointString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                urlString += "&waypoints=\(encoded)"
            }
        }

        urlString += "&travelmode=\(mode.googleMapsValue)"

        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
