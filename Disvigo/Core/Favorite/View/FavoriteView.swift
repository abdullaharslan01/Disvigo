//
//  FavoriteView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

enum FavoriSection: CaseIterable {
    case city
    case location
    case memory
    case food

    var title: String {
        switch self {
        case .city: return "Cities"
        case .location: return "Locations"
        case .memory: return "Memories"
        case .food: return "Foods"
        }
    }

    var icon: String {
        switch self {
        case .city: return AppIcons.cityDetail
        case .location: return AppIcons.location
        case .memory: return AppIcons.fossil
        case .food: return AppIcons.food
        }
    }
}

struct FavoriteView: View {
    @Binding var selectedTab: DTabModel

    @Environment(FavoriteManager.self) var favoriteManager
    @Environment(Router.self) var router
    @Environment(GemineViewStateController.self) private var gemine

    let sectionCellWidth: CGFloat = 200
    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            if isEmpty {
                emptyStateView
                    .padding(.bottom)
            } else {
                favoritesContent
            }
        }
        .onAppear(perform: {
            gemine.gemineViewState = .turkey

        })

        .navigationTitle(String(localized: "Favorites"))
        .preferredColorScheme(.dark)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.navigate(to: .rotationSelection(converSavedLocationsToLocation()))

                } label: {
                    Image(systemName: AppIcons.map)
                        .foregroundStyle(.cyan)
                }

                .contextMenu {
                    Button {
                        router.navigate(to: .rotationSelection(converSavedLocationsToLocation()))

                    } label: {
                        Label(String(localized: "Create route from selected locations."), systemImage: AppIcons.map)
                    }
                }
            }
        })
    }

    private func converSavedLocationsToLocation() -> [Location] {
        return favoriteManager.savedLocations.map { $0.location }
    }
}

extension FavoriteView {
    private var isEmpty: Bool {
        favoriteManager.savedFood.isEmpty &&
            favoriteManager.savedCities.isEmpty &&
            favoriteManager.savedMemories.isEmpty &&
            favoriteManager.savedLocations.isEmpty
    }

    private func sectionHeader(section: FavoriSection) -> some View {
        HStack {
            Image(systemName: section.icon)
            Text(section.title)
                .font(.poppins(.regular, size: .title3))
                .foregroundStyle(.appTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    private var favoritesContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(FavoriSection.allCases, id: \.self) { section in
                    if hasData(for: section) {
                        VStack(alignment: .leading, spacing: 12) {
                            sectionHeader(section: section)
                            content(section: section)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }

    private func hasData(for section: FavoriSection) -> Bool {
        switch section {
        case .city:
            return !favoriteManager.savedCities.isEmpty
        case .location:
            return !favoriteManager.savedLocations.isEmpty
        case .memory:
            return !favoriteManager.savedMemories.isEmpty
        case .food:
            return !favoriteManager.savedFood.isEmpty
        }
    }

    @ViewBuilder
    func content(section: FavoriSection) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                switch section {
                case .city:
                    ForEach(favoriteManager.savedCities) { city in
                        FavoriteCellView(
                            favoriteCellInfo: .init(
                                imageURL: city.imageUrl,
                                title: city.name,
                                description: city.cityDescription,
                                iconType: .city
                            )
                        ) {
                            router.navigate(to: .cityDetail(city.city))
                        } onFavoriteTapGesture: {
                            withAnimation {
                                favoriteManager.removeSavedCity(city)
                            }
                        }
                        .frame(width: 180)
                    }

                case .location:
                    ForEach(favoriteManager.savedLocations) { location in
                        FavoriteCellView(
                            favoriteCellInfo: .init(
                                imageURL: location.images.first ?? "",
                                title: location.title, description: location.descriptionText,
                                iconType: .location
                            )
                        ) {
                            router.navigate(to: .locationDetail(location.location))
                        } onFavoriteTapGesture: {
                            withAnimation {
                                favoriteManager.removeSavedLocation(location)
                            }
                        }
                        .frame(width: 180)
                    }

                case .memory:
                    ForEach(favoriteManager.savedMemories) { memory in
                        FavoriteCellView(
                            favoriteCellInfo: .init(
                                imageURL: memory.images.first ?? "",
                                title: memory.title, description: memory.memoryDescription,
                                iconType: .memory
                            )
                        ) {
                            router.navigate(to: .memoryDetail(memory.memory))
                        } onFavoriteTapGesture: {
                            withAnimation {
                                favoriteManager.removeSavedMemory(memory)
                            }
                        }
                        .frame(width: 180)
                    }

                case .food:
                    ForEach(favoriteManager.savedFood) { food in
                        FavoriteCellView(
                            favoriteCellInfo: .init(
                                imageURL: food.images.first ?? "",
                                title: food.title, description: food.foodDescription,
                                iconType: .food
                            )
                        ) {
                            router.navigate(to: .foodDetail(food.food))
                        } onFavoriteTapGesture: {
                            withAnimation {
                                favoriteManager.removeSavedFood(food)
                            }
                        }
                        .frame(width: 180)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

extension FavoriteView {
    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.walkingPeople,
            title: String(localized: "Your Favorites"),
            buttonTitle: String(localized: "Explore Now"),
            message: String(localized: "It looks like you haven't saved any favorites yet.\nExplore places and tap the heart icon to add them here."),
            textColor: .appTextLight
        ) {
            selectedTab = .home
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView(selectedTab: .constant(.favorites))
            .environment(FavoriteManager())
            .environment(Router())
            .environment(GemineViewStateController())
    }
}
