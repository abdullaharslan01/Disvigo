//
//  FoodDetailViewModel.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import Foundation

@Observable
class FoodDetailViewModel {
    let food: Food
    
    init(food: Food) {
        self.food = food
    }
    
    var isFavorite: Bool {
        return false
    }

    var showSafari = false
    
    var url: URL? {
        let query = food.title
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined(separator: "+")
        return URL(string: "https://www.nefisyemektarifleri.com/ara/?s=\(query)")
    }
}
