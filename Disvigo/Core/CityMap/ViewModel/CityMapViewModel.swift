//
//  CityMapViewModel.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import Foundation

@Observable
class CityMapViewModel {
    let locations: [Location]
    let city: City

    var permissionAlertStatus = false

    var focusOnUserState = false

    let locationService = LocationManager()

    init(city: City, locations: [Location]) {
        self.city = city
        self.locations = locations
        locationService.delegate = self
    }
    
    func openMapsForPermission() {
        locationService.openSettingsForLocationPermission()
    }
}

extension CityMapViewModel: LocationManagerDelegate {
    func permissionAlert() {
        permissionAlertStatus.toggle()
    }

    func focustOnUserStatus() {
        focusOnUserState.toggle()
    }
    
    func getUserLocation() -> Coordinates? {
        if let userLocation = locationService.lastKnownLocation {
            return Coordinates(latitude: userLocation.latitude, longitude: userLocation.longitude)
        }
        return nil
    }
}
