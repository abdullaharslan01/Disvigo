//
//  DIconButtonView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import SwiftUI

enum DIconButtonType {
    case location
    case user
    case favorite(Bool)
    case custom(String)

    var systemName: String {
        switch self {
        case .location: return AppIcons.focusOnLocation
        case .user: return AppIcons.personCircle
        case .favorite(let isFilled):
            return isFilled ? AppIcons.heartFill : AppIcons.heart
        case .custom(let symbolName): return symbolName
        }
    }

    // Varsayılan boyutlar
    var defaultSize: CGFloat { 44 } // Apple HIG standartı
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
    var width: CGFloat? = nil // Dışarıdan opsiyonel genişlik
    var height: CGFloat? = nil // Dışarıdan opsiyonel yükseklik
    let action: (() -> Void)?

    // Gerçek kullanılacak boyutlar
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
            iconContent
        }
        .frame(width: resolvedWidth, height: resolvedHeight)
    }

    private var iconContent: some View {
        Image(systemName: iconButtonType.systemName)
            .font(fontSize)
            .foregroundStyle(iconColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(padding)
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
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        DIconButtonView(iconButtonType: .location, action: {})
        DIconButtonView(iconButtonType: .favorite(false), action: {})
    }
    .padding()
}
