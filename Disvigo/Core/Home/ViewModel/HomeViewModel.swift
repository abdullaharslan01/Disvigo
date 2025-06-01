//
//  HomeViewModel.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation

@Observable
class HomeViewModel {
    var citySearchText: String = "" {
        didSet {
            filterCities()
        }
    }

    var allCities: [City] = []
    var filteredCities: [City] = []

    var isAllContentWasLoad = false
    var splashScreenAnimationTime = 3

    @MainActor
    func fetchAllCities() {
        guard !isAllContentWasLoad else { return }

        Task {
            do {
                allCities = try await NetworkManager.shared.fetchData(path: .cities)
                filteredCities = allCities
                try? await Task.sleep(for: .seconds(splashScreenAnimationTime))

                isAllContentWasLoad = true

            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func refreshCities() async {
        do {
            allCities = try await NetworkManager.shared.fetchData(path: .cities)
            filteredCities = allCities
            
        
            
        } catch {
            print(error.localizedDescription)
        }
    }

    private func filterCities() {
        let searchText = citySearchText.trimmingCharacters(in: .whitespacesAndNewlines)

        filteredCities = searchText.isEmpty
            ? allCities
            : allCities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
