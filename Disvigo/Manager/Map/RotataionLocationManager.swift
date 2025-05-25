//
//  RotataionLocationManager.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import CoreLocation
import Foundation
import MapKit

@Observable
class RotationLocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?

    weak var delegate: RotataionLocationManagerDelegate?
    var userLocationReady: Bool = false
    var settingsWarningState = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last?.coordinate
        userLocationReady = true
    }

     func checkLocationAuthorization() {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            delegate?.focusOnUser()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            settingsWarningState = true
        @unknown default:
            break
        }
    }

    func openSettingsForLocationPermission() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}

protocol RotataionLocationManagerDelegate: AnyObject {
    func focusOnUser()
}
