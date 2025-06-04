//
//  DTabView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct DTabView: View {
    init() { UITabBar.appearance().isHidden = true }

    @Environment(GemineViewStateController.self) var gemineManager

    @State var currentTab: TabType = .home
    @State var tabBarVisibility: Bool = false
    @Environment(Router.self) var router
    @Namespace var animation
    @State var isAllContentWasLoad = false
    @State var gemineChatStatus = false

    @State var tabbarHeight: CGFloat = 50

    var body: some View {
        @Bindable var router = router

        @Bindable var gemineManager = gemineManager
        ZStack {
            TabView(selection: self.$currentTab) {
                Tab(TabType.home.title, systemImage: TabType.home.iconFill, value: .home) {
                    NavigationStack(path: $router.homePath) {
                        HomeView(namespace: self.animation, isAllContentWasLoad: self.$isAllContentWasLoad, tabBarVisibility: $tabBarVisibility, tabbarHeight: $tabbarHeight)
                            .navigationDestination(namespace: self.animation, router: router, gemine: gemineManager)
                    }
                }

                Tab(TabType.favorites.title, systemImage: TabType.favorites.iconFill, value: .favorites) {
                    NavigationStack(path: $router.homePath) {
                        FavoriteView(currentTab: self.$currentTab,tabbarHeight: $tabbarHeight)
                            .navigationDestination(namespace: self.animation, router: router, gemine: gemineManager)
                    }
                }

                Tab(TabType.visited.title, systemImage: TabType.visited.iconFill, value: .visited) {
                    NavigationStack(path: $router.homePath) {
                        VisitedView(tabbarHeight: $tabbarHeight)
                            .navigationDestination(namespace: self.animation, router: router, gemine: gemineManager)
                    }
                }
            }.overlay(alignment: .bottom, content: {
                DTabBarMenuView(currentTab: self.$currentTab, isVisible: self.$tabBarVisibility)
                    .readAndBindHeight(to: $tabbarHeight)
            })
            .overlay(alignment: .bottomTrailing) {
                if gemineManager.isVisible == .visible {
                    DGemineChatButtonView(gemineViewState: $gemineManager.gemineViewState, showChat: self.$gemineChatStatus)
                        .padding(.bottom, tabbarHeight == 0 ? getSafeArea().bottom : tabbarHeight)
                }
            }
            .onChange(of: router.homePath.count) { _, newValue in
                if newValue == 0 {
                    tabBarVisibility = true
                } else {
                    tabBarVisibility = false
                }
            }
            .onChange(of: gemineChatStatus) { _, newValue in
                if router.homePath.count == 0 && newValue {
                    tabBarVisibility = false
                } else if router.homePath.count != 0  {
                    tabBarVisibility = false
                }
                else {
                    tabBarVisibility = true
                }
            }

            .tint(.appGreenPrimary)
            .preferredColorScheme(.dark)
            .ignoresSafeArea(edges: [.bottom])

            if !self.isAllContentWasLoad {
                SplashView()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    DTabView()
        .environment(Router())
        .environment(GemineViewStateController())
}
