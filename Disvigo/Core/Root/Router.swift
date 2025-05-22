//
//  Router.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import SwiftUI

enum Destination: Hashable {
    case cityDetail(City)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .cityDetail(let city):
            hasher.combine("cityDetail")
            hasher.combine(city.id)
        }
    }
}

@Observable
class Router {
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
    func navigationDestination(namespace: Namespace.ID) -> some View {
        navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .cityDetail(let city):
                CityDetailView(city: city)
                    .toolbarRole(.editor)
                    .navigationTransition(.zoom(sourceID: city.id, in: namespace))
            }
        }
    }
}
