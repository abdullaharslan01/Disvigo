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
    @State var isAllContentWasLoad = false

    var body: some View {
        @Bindable var router = router

        ZStack {
            TabView(selection: $selectedTab) {
                Tab(DTabModel.home.title, systemImage: DTabModel.home.icon, value: .home) {
                    NavigationStack(path: $router.homePath) {
                        HomeView(namespace: animation, isAllContentWasLoad: $isAllContentWasLoad)
                            .navigationDestination(namespace: animation, router: router)
                    }.toolbarVisibility(router.toolbarVisibility, for: .tabBar)
                }

                Tab(DTabModel.favorites.title, systemImage: DTabModel.favorites.icon, value: .favorites) {
                    NavigationStack {
                        FavoriteView()
                    }.toolbarVisibility(router.toolbarVisibility, for: .tabBar)
                }
            }
            .tint(.appGreenPrimary)
            .preferredColorScheme(.dark)

            if !isAllContentWasLoad {
                SplashView()
                    .ignoresSafeArea()
                    .transition(.move(edge: .top))
            }
        }
    }
}

#Preview {
    DTabView()
        .environment(Router())
}
