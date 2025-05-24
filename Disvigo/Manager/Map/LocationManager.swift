//
//  LocationManager.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import CoreLocation
import Foundation
import MapKit

enum PermissionAlertType: Identifiable {
    case focusOnUser
    case sortLocations

    var id: PermissionAlertType { self }
}

protocol LocationManagerDelegate: AnyObject {
    func permissionAlert(alert: PermissionAlertType)
    func focustOnUser()
    func sortLocations()
}

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    var lastKnownLocation: CLLocationCoordinate2D?
    weak var delegate: LocationManagerDelegate?

    private var permissinoAlertType: PermissionAlertType = .sortLocations

    private var isSortedWorked: Bool = false

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

    private func checkLocationAuthorizationAndFocus() {
        permissinoAlertType = .focusOnUser
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            delegate?.focustOnUser()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            delegate?.permissionAlert(alert: .focusOnUser)
        @unknown default:
            break
        }
    }

    private func checkLocationAuthorizationForSortingLocation() {
        permissinoAlertType = .sortLocations

        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            delegate?.sortLocations()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            delegate?.permissionAlert(alert: .sortLocations)
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

    func sortLocations() {
        checkLocationAuthorizationForSortingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last?.coordinate
        if !isSortedWorked {
            delegate?.sortLocations()
            isSortedWorked = true
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            switch permissinoAlertType {
            case .focusOnUser:
                manager.startUpdatingLocation()
                delegate?.focustOnUser()
            case .sortLocations:
                manager.startUpdatingLocation()
                delegate?.sortLocations()
            }
        case .denied, .restricted, .notDetermined:
            break
        @unknown default:
            break
        }
    }
}
