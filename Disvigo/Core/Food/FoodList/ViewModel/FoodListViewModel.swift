//
//  FoodListViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class FoodListViewModel {
    let foods: [Food]
    
    var cityName:String = ""
    var previousResultCount = 0

    var searchText = ""

    var filteredFoods: [Food] {
        if searchText.isEmpty {
            return foods
        } else {
            return foods.filter { food in
                food.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init(foods: [Food],cityName:String) {
        self.foods = foods
        self.previousResultCount = foods.count
        self.cityName = cityName
    }
}
