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

    var permissionAlertStatus: PermissionAlertType?

    var focusOnUserState = false

    private var locationService = LocationManager()

    init(location: Location) {
        self.location = location
        locationService.delegate = self
    }

    func requestForFocusOnUser() {
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
    func permissionAlert(alert: PermissionAlertType) {
        
            permissionAlertStatus = alert
        
    }

    func sortLocations() {}

    func focustOnUser() {
        focusOnUserState.toggle()
    }
}
