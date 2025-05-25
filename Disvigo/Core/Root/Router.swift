//
//  Router.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import SwiftUI

enum Destination: Hashable {
    case cityDetail(City)
    case locationDetail(Location)
    case locationMap(Location)
    case cityMap([Location], City)
    case locationList([Location],String)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .cityDetail(let city):
            hasher.combine("cityDetail")
            hasher.combine(city.id)
        case .locationDetail(let location):
            hasher.combine("locationDetail")
            hasher.combine(location.id)
        case .locationMap(let location):
            hasher.combine("locationMap")
            hasher.combine(location.id)
        case .cityMap(_, let city):
            hasher.combine("cityMap")
            hasher.combine(city.id)
        case .locationList(_, let cityName):
            hasher.combine("locationList")
            hasher.combine(cityName)
        }
    }
}

@Observable
class Router {
    var toolbarVisibility: Visibility = .hidden

    var homePath = NavigationPath()

    func navigate(to destination: Destination) {
        homePath.append(destination)
    }

    func navigateBack() {
        homePath.removeLast()
    }

    func navigateToRoot() {
        homePath.removeLast(homePath.count)
    }

    func pop(to count: Int = 1) {
        guard homePath.count >= count else { return }
        homePath.removeLast(count)
    }
}

extension View {
    func navigationDestination(namespace: Namespace.ID, router: Router) -> some View {
        navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .cityDetail(let city):
                CityDetailView(city: city)
                    .navigationTransition(.zoom(sourceID: city.id, in: namespace))
                    .onAppear {
                        router.toolbarVisibility = .hidden
                    }
            case .locationDetail(let location):
                LocationView(location: location)
                    .toolbarRole(.editor).onAppear {
                        router.toolbarVisibility = .hidden
                    }
            case .locationMap(let location):
                LocationMapView(location: location)
                    .toolbarRole(.editor)
                    .onAppear {
                        router.toolbarVisibility = .hidden
                    }
            case .cityMap(let locations, let city):
                CityMapView(city: city, locations: locations)
                    .onAppear {
                        router.toolbarVisibility = .hidden
                    }
            case .locationList(let locations, let cityName):
                LocationListView(locations: locations, cityTitle:cityName)
                    .onTapGesture {
                        router.toolbarVisibility = .hidden
                    }
            }
        }
    }
}
