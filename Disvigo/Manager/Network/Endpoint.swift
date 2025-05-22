//
//  Endpoint.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation

enum EndpointPath: String {
    case cities = "/turkiye_iller.json"
}


struct Endpoint {
    static let baseURL = "https://abdullaharslan.com.tr/disvigo"

    let path: EndpointPath

    var url: URL? {
        URL(string: Endpoint.baseURL + path.rawValue)
    }
}
