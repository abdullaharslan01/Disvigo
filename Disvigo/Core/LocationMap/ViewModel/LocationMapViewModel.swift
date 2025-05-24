//
//  LocationMapViewModel.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import Foundation

@Observable
class LocationMapViewModel {
    let location: Location
    
    var showMapSelectionSheet = false

    var permissionAlertStatus = false

    var focusOnUserState = false

    private var locationService = LocationManager()

    init(location: Location) {
        self.location = location
        locationService.delegate = self
    }

    func focusOnUser() {
        locationService.focusOnUser()
    }

    func getUserLocation() -> Coordinates? {
        if let userLocation = locationService.lastKnownLocation {
            return Coordinates(latitude: userLocation.latitude, longitude: userLocation.longitude)
        }
        return nil
    }

    func openMapsForPermission() {
        locationService.openSettingsForLocationPermission()
    }
}

extension LocationMapViewModel: LocationManagerDelegate {
    func permissionAlert() {
        permissionAlertStatus.toggle()
    }

    func focustOnUserStatus() {
        focusOnUserState.toggle()
    }
}
