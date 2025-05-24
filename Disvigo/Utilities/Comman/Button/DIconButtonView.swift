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
        case .location:
            return AppIcons.focusOnLocation
        case .user:
            return AppIcons.personCircle
        case .favorite(let favoriteState):
            return favoriteState ? AppIcons.heart : AppIcons.heartFill
        case .custom(let symbolName):
            return symbolName
        }
    }
}

struct DIconButtonView: View {
    let iconButtonType: DIconButtonType
    var fontSize: Font = .poppins(.regular, size: .title)
    var iconColor: Color = .red
    var bgColor: Color = .white
    var cornerRadius: CGFloat = 16
    var shadowRadius: CGFloat = 5
    var padding: CGFloat = 12
    var bgMaterial: Material? = nil
    let action: (() -> ())?

    var body: some View {
        Group {
            if action != nil {
                Button {
                    action?()
                } label: {
                    iconContent
                }
            } else {
                iconContent
            }
        }
    }

    private var iconContent: some View {
        Image(systemName: iconButtonType.systemName)
            .font(fontSize)
            .foregroundStyle(iconColor)
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
    }
}

#Preview {
    DIconButtonView(iconButtonType: .favorite(true)) {}
}
