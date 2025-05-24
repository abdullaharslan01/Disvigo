//
//  DLabelButtonView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import SwiftUI

struct DLabelButtonView: View {
    let systemImage: String
    let title: String
    let symbolFont: Font
    let textFont: Font
    let onTap: () -> Void

    init(
        systemImage: String = AppIcons.locationSquare,
        title: String,
        symbolFont: Font = .poppins(.medium, size: .title3),
        textFont: Font = .poppins(.medium, size: .headline),
        onTap: @escaping () -> Void = {}
    ) {
        self.systemImage = systemImage
        self.title = title
        self.symbolFont = symbolFont
        self.textFont = textFont
        self.onTap = onTap
    }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(symbolFont)
                Text(title)
                    .font(textFont)
            }
            .foregroundStyle(.appTextLight)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DLabelButtonView(title: "View on Map")
}
