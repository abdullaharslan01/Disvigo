//
//  Font+Ext.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

enum Poppins: String {
    case bold = "Poppins-Bold"
    case extraBold = "Poppins-ExtraBold"
    case italic = "Poppins-Italic"
    case light = "Poppins-Light"
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
    case semiBold = "Poppins-SemiBold"
    case thin = "Poppins-Thin"

    var fontName: String {
        return self.rawValue
    }
}

enum FontSize {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case body
    case callout
    case subheadline
    case footnote
    case caption
    case custom(CGFloat)

    var value: CGFloat {
        switch self {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .body: return 16
        case .callout: return 15
        case .subheadline: return 14
        case .footnote: return 13
        case .caption: return 12
        case .custom(let size): return size
        }
    }
}

extension Font {
    static func poppins(_ type: Poppins, size: FontSize) -> Font {
        return .custom(type.fontName, size: size.value)
    }
}
