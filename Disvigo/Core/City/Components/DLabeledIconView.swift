//
//  DLabeledIconView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import SwiftUI

struct DLabeledIconView: View {
    let title: String
    let symbolName: String
    let foregroundStyle: Color

    init(title: String, symbolName: String, foregroundStyle: Color = .secondary) {
        self.title = title
        self.symbolName = symbolName
        self.foregroundStyle = foregroundStyle
    }

    var body: some View {
        HStack {
            Image(systemName: symbolName)
            Text(title)
                .font(.poppins(.light, size: .body))
                .lineLimit(1)
        }.foregroundStyle(foregroundStyle)
    }
}

