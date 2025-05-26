//
//  CityMapViewModel.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import Foundation
import MapKit

enum JumState {
    case forward
    case bakcward
}

@Observable
class CityMapViewModel {
    let locations: [Location]
    var sortedLocations: [Location]
    let city: City
    var permissionAlertType: PermissionAlertType?
    private var locationDistances = [UUID: CLLocationDistance]()
    var focusOnUserState = false
    let locationService = LocationManager()
    var currentPageIndex = 0
    var isSorted: Bool = false
    
    init(city: City, locations: [Location]) {
        self.city = city
        self.locations = locations
        self.sortedLocations = locations
        locationService.delegate = self
    }
    
    var locationCount: Int {
        sortedLocations.count
    }

    func openMapsForPermission() {
        locationService.openSettingsForLocationPermission()
    }
    
    private func updateLocationsWithUserLocation(_ userLocation: CLLocation) {
        for location in locations {
            let distance = userLocation.distance(from: location.coordinates.asCLLocation)
            locationDistances[location.id] = distance
        }
        
        sortedLocations = locations.sorted {
            let distance1 = locationDistances[$0.id] ?? .greatestFiniteMagnitude
            let distance2 = locationDistances[$1.id] ?? .greatestFiniteMagnitude
            return distance1 < distance2
        }
    }
    
    func requestForSortLocations() {
        locationService.sortLocations()
    }
    
    func requestForFocusOnUser() {
        locationService.focusOnUser()
    }
    
    func formattedDistance(for location: Location) -> String {
        guard let distance = locationDistances[location.id] else { return "" }

        if distance < 1000 {
            return String(localized: "\(Int(distance)) m",
                          comment: "Distance in meters")
        } else {
            return String(localized: "\(String(format: "%.1f", distance / 1000)) km",
                          comment: "Distance in kilometers")
        }
    }
    
    func jump(to state: JumState) -> Location? {
        switch state {
        case .forward:
            return sortedLocations.first
        case .bakcward:
            return sortedLocations.last
        }
    }
}

extension CityMapViewModel: LocationManagerDelegate {
    func sortLocations() {
        if !isSorted {
            guard let location = locationService.lastKnownLocation else { return }
            updateLocationsWithUserLocation(.init(latitude: location.latitude, longitude: location.longitude))
            isSorted = true
        }
    }
    
    func permissionAlert(alert: PermissionAlertType) {
        permissionAlertType = alert
    }
    
    func focustOnUser() {
        focusOnUserState.toggle()
    }
    
    func getUserLocation() -> Coordinates? {
        if let userLocation = locationService.lastKnownLocation {
            return Coordinates(latitude: userLocation.latitude, longitude: userLocation.longitude)
        }
        return nil
    }
}
