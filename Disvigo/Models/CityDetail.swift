//
//  CityDetail.swift
//  Disvigo
//
//  Created by abdullah on 28.05.2025.
//

import Foundation

struct CityDetail: Codable,Identifiable,Hashable {
    let id: Int
    let cityName: String
    let locations:[Location]
    let foods:[Food]
    let memories: [Memory]

    enum CodingKeys: String, CodingKey {
        case id
        case cityName = "city_name"
        case locations, foods, memories
    }
}
