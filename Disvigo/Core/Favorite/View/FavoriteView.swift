//
//  FavoriteView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(FavoriteManager.self) var favoriteManager

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            List {
                Section {
                    ForEach(favoriteManager.savedCities) { city in
                        Text(city.name)
                    }
                } header: {
                    Text(String(localized: "Cities"))
                }

            }.scrollContentBackground(.hidden)

        }.navigationTitle(String(localized: "Favorites"))
            .preferredColorScheme(.dark)
    }
}

extension FavoriteView {
    private var emptyStateView: some View {
        DLottieEmtyView(lottieName: AppImages.Lottie.walkingPeople, title: String(
            localized: "Your Favorites"
        ), buttonTitle: String(
            localized: "Explore Now"
        ), message: String(
            localized: "It looks like you haven't saved any favorites yet.\nExplore places and tap the heart icon to add them here."
        ), textColor: .appTextLight) {}
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
            .environment(FavoriteManager())
    }
}
