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
    var body: some View {
        @Bindable var router = router

        @Bindable var gemineManager = gemineManager
        ZStack {
            TabView(selection: $selectedTab) {
                Tab(DTabModel.home.title, systemImage: DTabModel.home.icon, value: .home) {
                    NavigationStack(path: $router.homePath) {
                        HomeView(namespace: animation, isAllContentWasLoad: $isAllContentWasLoad)
                            .navigationDestination(namespace: animation, router: router, gemine: gemineManager)
                    }.toolbarVisibility(router.toolbarVisibility, for: .tabBar)
                        .overlay(alignment: .bottomTrailing, content: {
                            if gemineManager.isVisible == .visible {
                                DGemineChatButtonView(gemineViewState: $gemineManager.gemineViewState, showChat: $gemineChatStatus)
                            }

                        }).onChange(of: gemineChatStatus) { _, newValue in
                            router.toolbarVisibility = newValue ? .hidden : .visible
                        }
                        .animation(.default, value: gemineManager.isVisible)
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
        .environment(GemineViewStateController())
}
