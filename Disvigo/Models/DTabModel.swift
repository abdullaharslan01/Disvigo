//
//  DTabModel.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation


enum DTabModel: Hashable, Codable {
    case home
    case favorites

    var title: String {
        switch self {
        case .home:
            return String(localized: "Home")
        case .favorites:
            return String(localized: "Favorites")
        }
    }

    var icon: String {
        switch self {
        case .home:
            return AppIcons.home
        case .favorites:
            return AppIcons.heart
        }
    }

}
