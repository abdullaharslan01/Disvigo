//
//  DIconButtonView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import SwiftUI

enum DIconButtonType: Equatable {
    case location
    case user
    case custom(String)

    var systemName: String {
        switch self {
        case .location: return AppIcons.focusOnLocation
        case .user: return AppIcons.personCircle
        case .custom(let symbolName): return symbolName
        }
    }

    var defaultSize: CGFloat { 55 }
}

struct DIconButtonView: View {
    let iconButtonType: DIconButtonType
    var fontSize: Font = .poppins(.regular, size: .title)
    var iconColor: Color = .red
    var bgColor: Color = .white
    var cornerRadius: CGFloat = 16
    var shadowRadius: CGFloat = 0
    var padding: CGFloat = 12
    let impactFeedback: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .medium)
    var bgMaterial: Material? = nil
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    let action: (() -> Void)?

    private var resolvedWidth: CGFloat {
        width ?? iconButtonType.defaultSize
    }

    private var resolvedHeight: CGFloat {
        height ?? iconButtonType.defaultSize
    }

    var body: some View {
        Button {
            impactFeedback?.impactOccurred()
            action?()
        } label: {
            Image(systemName: iconButtonType.systemName)
                .font(fontSize)
                .foregroundStyle(iconColor)
                .frame(width: resolvedWidth - (padding * 2), height: resolvedHeight - (padding * 2))
        }
        .frame(width: resolvedWidth, height: resolvedHeight)
        .background {
            if let material = bgMaterial {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(material)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(bgColor)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(radius: shadowRadius)
    }
}
