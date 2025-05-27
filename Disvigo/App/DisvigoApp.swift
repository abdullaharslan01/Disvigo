//
//  DisvigoApp.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

@main
struct DisvigoApp: App {
    @State var router = Router()
    @State var gemineManager = GemineViewStateController()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(router)
                .environment(gemineManager)
        }
    }
}
