//
//  DisvigoApp.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

@main
struct DisvigoApp: App {
    
    @State var router  = Router()

    
    var body: some Scene {
        WindowGroup {
            
            CityMapView(city: DeveloperPreview.shared.city, locations: DeveloperPreview.shared.locations)
            
//            RootView()
//                .environment(router)
        }
    }
}
