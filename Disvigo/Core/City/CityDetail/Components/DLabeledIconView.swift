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
    let iconFont: Font
    let textFont: Font

    init(
        title: String,
        symbolName: String,
        foregroundStyle: Color = .secondary,
        iconFont: Font = .poppins(.medium, size:.custom(25)),
        textFont: Font = .poppins(.light, size:.headline)
    ) {
        self.title = title
        self.symbolName = symbolName
        self.foregroundStyle = foregroundStyle
        self.iconFont = iconFont
        self.textFont = textFont
    }

    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .font(iconFont)

            Text(title)
                .font(textFont)
                .lineLimit(1)
                .textSelection(.enabled)
        }
        .foregroundStyle(foregroundStyle)
    }
}


#Preview {
    DLabeledIconView(title: "Open in Web Browser", symbolName: AppIcons.search, foregroundStyle: .accentColor)
}
