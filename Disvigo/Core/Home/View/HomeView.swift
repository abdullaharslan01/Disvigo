//
//  HomeView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct HomeView: View {
    @State var vm = HomeViewModel()
    let namespace: Namespace.ID
    @FocusState private var isSearchFocused: Bool

    @Environment(Router.self) private var router

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            contentView

            if !vm.isAllContentWasLoad {
                SplashView()
                    .transition(.move(edge: .top).combined(with: .opacity))
            }

        }.navigationTitle(String(localized: "Explore Cities"))
            .preferredColorScheme(.dark)
            .task {
                vm.fetchAllCities()
            }
            .toolbarVisibility(vm.isAllContentWasLoad ? .visible : .hidden, for: .tabBar)
            .toolbarVisibility(vm.isAllContentWasLoad ? .visible : .hidden, for: .navigationBar)
    }

    var contentView: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                if vm.filteredCities.isEmpty && !vm.citySearchText.isEmpty {
                    EmptyStateView(buttonText: "Clear", onTapGesture: {
                        vm.citySearchText = ""
                    })
                    .transition(.scale.combined(with: .opacity))
                } else {
                    ForEach(vm.filteredCities) { city in

                        CityRowView(city: city, onTapGesture: {
                            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                            impactFeedback.impactOccurred()
                            router.navigate(to: .cityDetail(city))
                        })
                        .matchedGeometryEffect(id: city.id, in: namespace)
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                        .scrollTransition { view, phase in
                            view
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                .opacity(phase.isIdentity ? 1 : 0.7)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .animation(.easeInOut(duration: 0.5), value: vm.filteredCities.count)
        }
        .refreshable {
            await vm.refreshCities()
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }
        .searchable(text: $vm.citySearchText, prompt: String(localized: "Search by city..."))
        .focused($isSearchFocused)
        .scaleEffect(isSearchFocused ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSearchFocused)
        .onChange(of: vm.filteredCities.count) { oldValue, newValue in
            if oldValue != newValue {
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            }
        }
    }
}
