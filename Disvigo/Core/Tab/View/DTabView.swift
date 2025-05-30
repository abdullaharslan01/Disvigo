//
//  DTabView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct DTabView: View {
    @Environment(GemineViewStateController.self) var gemineManager
    @State var selectedTab: DTabModel = .home

    @Environment(Router.self) var router
    @Namespace var animation
    @State var isAllContentWasLoad = false
    @State var gemineChatStatus = false

    @State var mainTabBarVisibility: Visibility = .visible

    var body: some View {
        @Bindable var router = router

        @Bindable var gemineManager = gemineManager
        ZStack {
            TabView(selection: $selectedTab) {
                Tab(DTabModel.home.title, systemImage: DTabModel.home.icon, value: .home) {
                    NavigationStack(path: $router.homePath) {
                        HomeView(namespace: animation, isAllContentWasLoad: $isAllContentWasLoad)
                            .navigationDestination(namespace: animation, router: router, gemine: gemineManager)
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if gemineManager.isVisible == .visible {
                            DGemineChatButtonView(gemineViewState: $gemineManager.gemineViewState, showChat: $gemineChatStatus)
                        }
                    }.toolbarVisibility(mainTabBarVisibility, for: .tabBar)
                }

                Tab(DTabModel.favorites.title, systemImage: DTabModel.favorites.icon, value: .favorites) {
                    NavigationStack(path: $router.homePath) {
                        FavoriteView(selectedTab: $selectedTab)
                            .navigationDestination(namespace: animation, router: router, gemine: gemineManager)
                    }
                    .overlay(alignment: .bottomTrailing, content: {
                        if gemineManager.isVisible == .visible {
                            DGemineChatButtonView(gemineViewState: $gemineManager.gemineViewState, showChat: $gemineChatStatus)
                        }

                    }).toolbarVisibility(mainTabBarVisibility, for: .tabBar)
                }
            }
            .onChange(of: router.homePath.count) { _, newValue in
                withAnimation {
                    DispatchQueue.main.async {
                        if newValue == 0 {
                            mainTabBarVisibility = .visible
                        } else {
                            mainTabBarVisibility = .hidden
                        }
                    }
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
        .environment(GemineViewStateController())
}
