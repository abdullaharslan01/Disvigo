//
//  ExpandableTextView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import SwiftUI

struct ExpandableTextView: View {
    let text: String
    let font: Poppins
    let fontSize: FontSize
    let lineLimit: Int
    let horizontalPadding: CGFloat

    @State private var isExpanded = false
    @State private var shouldTruncate = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(text)
                .textSelection(.enabled)
                .font(.poppins(font, size: fontSize))
                .lineLimit(isExpanded ? nil : lineLimit)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onAppear {
                    DispatchQueue.main.async {
                        shouldTruncate = text.isTruncated(
                            font: font,
                            fontSize: fontSize,
                            lineLimit: lineLimit,
                            horizontalPadding: horizontalPadding
                        )
                    }
                }

            if shouldTruncate {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? String(localized: "Show Less") : String(localized: "Read More"))
                        .font(.poppins(.medium, size: fontSize))
                        .foregroundColor(.accent)
                }
                .padding(.top, 4)
            }
        }
    }
}

#Preview {
    ExpandableTextView(text: "", font: .light, fontSize: .body, lineLimit: 3, horizontalPadding: 16)
}
