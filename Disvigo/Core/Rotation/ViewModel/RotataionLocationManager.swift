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
    
    var userLocationReady: Bool = false

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
}
