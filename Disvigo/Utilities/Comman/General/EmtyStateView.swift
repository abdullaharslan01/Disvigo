//
//  EmtyStateView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//
import SwiftUI

struct EmptyStateView: View {
    let title: String
    let subtitle: String
    let iconName: String
    let buttonText: String?
    let onTapGesture: (() -> Void)?
    
    init(
        title: String = String(localized: "No cities found"),
        subtitle: String = String(localized: "Try searching with a different keyword"),
        iconName: String = AppIcons.search,
        buttonText: String? = nil,
        onTapGesture: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.iconName = iconName
        self.buttonText = buttonText
        self.onTapGesture = onTapGesture
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: iconName)
                .font(.poppins(.semiBold, size: .custom(60)))
                .foregroundColor(.secondary)
                .symbolEffect(.pulse.byLayer, options: .repeating, isActive: true)
            
            VStack(spacing: 10) {
                Text(title)
                    .font(.poppins(.regular, size: .title2))
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                if let buttonText = buttonText {
                    Button {
                        onTapGesture?()
                    } label: {
                        Text(buttonText)
                            .font(.poppins(.regular, size: .body))
                            .foregroundStyle(.appTextLight)
                            .padding(10)
                            .padding(.horizontal,25)
                            .background(
                                Color.appGreenMedium, in: RoundedRectangle(cornerRadius: 16)
                            )
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(minHeight: 200)
    }
}

#Preview {
    ZStack {
        Color.appBackgroundDark.ignoresSafeArea()
        
        EmptyStateView(
            title: "No cities found",
            subtitle: "Try searching with a different keyword",
            buttonText: "Clear"
        )
    }.preferredColorScheme(.dark)
}
