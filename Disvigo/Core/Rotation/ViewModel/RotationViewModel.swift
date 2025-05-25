//
//  RotationViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class RotationViewModel {
    var locationManager = RotationLocationManager()
    
    var focusOnUserStatus:Bool = false
    
    init() {
        locationManager.delegate = self
    }
}


extension RotationViewModel: RotataionLocationManagerDelegate {
    func focusOnUser() {
        
        print("Focus on user worked")
        focusOnUserStatus.toggle()
    }
    
    
}
