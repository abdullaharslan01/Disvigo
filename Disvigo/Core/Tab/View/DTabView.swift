//
//  DTabView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct DTabView: View {
    
    @State var selectedTab: DTabModel = .home
    @Environment(Router.self) var router

    @Namespace var animation
    
    var body: some View {
        @Bindable var router = router
        TabView(selection: $selectedTab) {
            Tab(DTabModel.home.title, systemImage: DTabModel.home.icon, value: .home) {
                NavigationStack(path: $router.homePath) {
                    HomeView(namespace: animation)
                        .navigationDestination(namespace: animation)
                }
            }

            Tab(DTabModel.favorites.title, systemImage: DTabModel.favorites.icon, value: .favorites) {
                NavigationStack {
                    FavoriteView()
                }
            }

        }.tint(.appGreenPrimary)
            .preferredColorScheme(.dark)
    }
}

#Preview {
    DTabView()
}
