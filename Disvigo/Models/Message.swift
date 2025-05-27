//
//  Message.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let content: String
    let isFromUser: Bool
    var isLoading: Bool = false
}
