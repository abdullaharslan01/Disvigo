//
//  LocationManager.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import CoreLocation
import Foundation
import MapKit

protocol LocationManagerDelegate: AnyObject {
    func permissionAlert()
    func focustOnUserStatus()
}

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    var lastKnownLocation: CLLocationCoordinate2D?
    weak var delegate: LocationManagerDelegate?

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        setupLocationService()
    }

    private func setupLocationService() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestInitialPermissionIfNeeded()
    }

    private func requestInitialPermissionIfNeeded() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted: break
        @unknown default:
            break
        }
    }

    func checkLocationAuthorizationAndFocus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            delegate?.focustOnUserStatus()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            delegate?.permissionAlert()
        @unknown default:
            break
        }
    }

    func openSettingsForLocationPermission() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }

    func focusOnUser() {
        checkLocationAuthorizationAndFocus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last?.coordinate
    }
}
