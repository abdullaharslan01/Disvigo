//
//  Endpoint.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation

enum EndpointPath {
    case cities
    case cityDetail(Int)

    var stringValue: String {
        switch self {
        case .cities:
            return "/turkiye_iller.json"
        case .cityDetail(let id):
            return "/\(id).json"
        }
    }
}

struct Endpoint {
    static let baseURL = "https://abdullaharslan.com.tr/disvigo"

    let path: EndpointPath

    var url: URL? {
        return URL(string: Endpoint.baseURL + path.stringValue)
    }
}
