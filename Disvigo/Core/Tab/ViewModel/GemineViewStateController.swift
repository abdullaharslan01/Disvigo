//
//  GemineViewStateController.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import Foundation

enum GemineButtonShowingState {
    case visible
    case hidden
}

@Observable
class GemineViewStateController {
    var gemineViewState: GemineViewState = .turkey
    var isVisible: GemineButtonShowingState = .visible
}
