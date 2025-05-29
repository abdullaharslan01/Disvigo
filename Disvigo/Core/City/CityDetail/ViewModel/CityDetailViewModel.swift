//
//  CityDetailViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

struct DAlertItem {
    var title: String
    var message: String
}

@Observable
class CityDetailViewModel {
    var showFullDescription = false
    var showSafari = false

    var locations: [Location] = []
    var foods: [Food] = []
    var memories: [Memory] = []
    var isLoading: Bool = false

    var alert: DAlertItem = .init(title: "", message: "")

    var errorAlert: Bool = false

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

    func fecthCity() {
        isLoading = true

        print(city.id)
        Task {
            do {
                let result: CityDetail = try await NetworkManager.shared.fetchData(path: .cityDetail(city.id))

                await MainActor.run {
                    locations = result.locations
                    foods = result.foods
                    memories = result.memories
                }

                
                let url = Endpoint(path: .cityDetail(city.id))
                
                
                print(url.url ?? "")
                
                
                
                print("Locations: \(result.locations.count)")
                print("Food: \(result.foods.count)")
                print("Memory: \(result.memories.count)")
                isLoading = false
            } catch {
                alert.message = error.localizedDescription
                alert.title = String(localized: "Network Error")
                errorAlert.toggle()
            }
        }
    }
}
