//
//  CityDetailViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class CityDetailViewModel {
    var showFullDescription = false
    var showSafari = false
    var didAppeear = false

    var locations: [Location] = []
    var foods: [Food] = []
    var memories: [Memory] = []

    let city: City

    init(city: City) {
        self.city = city
    }

    var url: URL? {
        let baseURL = "https://tr.wikipedia.org/wiki/"

        var cityName = ""

        switch city.name {
        case "Tokat", "Ordu":
            cityName = city.name + "_(şehir)"
        default:
            cityName = city.name
        }

        return URL(string: baseURL + cityName)
    }

    func fetchLocations() {
        Task {
            try? await Task.sleep(for: .seconds(1))
            locations = DeveloperPreview.shared.locations
            foods = DeveloperPreview.shared.foods
            memories = DeveloperPreview.shared.memories
        }
    }
}
