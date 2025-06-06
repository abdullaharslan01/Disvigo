//
//  DisvigoApp.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

@main
struct DisvigoApp: App {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().isHidden = true
    }

    @State var router = Router()
    @State var favoriteManager = FavoriteManager()
    @State var gemineManager = GemineViewStateController()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(router)
                .environment(gemineManager)
                .environment(favoriteManager)
        }
    }
}
