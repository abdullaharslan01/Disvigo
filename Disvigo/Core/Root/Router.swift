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
    case locationList([Location], String)
    case foodDetail(Food)
    case foodList([Food], String)
    case memoryDetail(Memory)
    case memoryList([Memory], String)
    case rotationDetail([Location])
    case rotationSelection([Location])
    case visitedDetail(VisitedList)

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
        case .foodDetail(let food):
            hasher.combine("foodDetail")
            hasher.combine(food.id)
        case .foodList(_, let cityName):
            hasher.combine("foodList")
            hasher.combine(cityName)
        case .memoryDetail(let memory):
            hasher.combine("memoryDetail")
            hasher.combine(memory.id)
        case .memoryList(_, let cityName):
            hasher.combine("memoryList")
            hasher.combine(cityName)
        case .rotationDetail:
            hasher.combine("rotationDetail")
        case .rotationSelection:
            hasher.combine("rotationSelection")
        case .visitedDetail(let visitedList):
            hasher.combine(visitedList.id)
            hasher.combine("visitedDetail")
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
    func navigationDestination(namespace: Namespace.ID, router: Router, gemine: GemineViewStateController) -> some View {
        navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .cityDetail(let city):
                CityDetailView(city: city)
                    .toolbarRole(.editor)

            case .locationDetail(let location):
                LocationDetailView(location: location)
                    .toolbarRole(.editor)

            case .locationMap(let location):
                LocationMapView(location: location)
                    .toolbarRole(.editor)

            case .cityMap(let locations, let city):
                CityMapView(city: city, locations: locations)
                    .toolbarRole(.editor)

            case .locationList(let locations, let cityName):
                LocationListView(locations: locations, cityTitle: cityName)
                    .toolbarRole(.editor)

            case .foodDetail(let food):
                FoodDetailView(food: food)
                    .toolbarRole(.editor)

            case .foodList(let foods, let cityName):
                FoodListView(foods: foods, cityName: cityName)
                    .toolbarRole(.editor)

            case .memoryDetail(let memory):
                MemoryDetailView(memory: memory)
                    .toolbarRole(.editor)

            case .memoryList(let memories, let cityName):
                MemoryListView(memories: memories, cityName: cityName)
                    .toolbarRole(.editor)

            case .rotationDetail(let locations):
                RotataionDetailView(stops: locations)
                    .toolbarRole(.editor)

            case .rotationSelection(let locations):
                RotationSelectionView(locations: locations)
                    .navigationBarBackButtonHidden()

            case .visitedDetail(let visitedList):
                VisitedDetailView(visitedList: visitedList)
                    .toolbarRole(.editor)
            }
        }
    }
}
