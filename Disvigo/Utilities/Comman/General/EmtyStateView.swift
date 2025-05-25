//
//  EmptyStateView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import SwiftUI

enum EmptyStateType {
    case searchNotFound(title:String)
    case imageNotFound
    case custom(title: String, description: String, buttonText: String?, icon: String)
    
    var content: (title: String, description: String, buttonText: String?, icon: String) {
        switch self {
        case .searchNotFound(let title):
            return (
               title, 
                String(localized: "Try searching with a different keyword"),
                String(localized: "Clear"),
                AppIcons.search
            )
        case .imageNotFound:
            return (
                String(localized: "Image not found"),
                String(localized: "The image will be available soon."),
               nil,
                AppIcons.photo
            )
        case .custom(let title, let description, let buttonText, let icon):
            return (title, description, buttonText, icon)
        }
    }
}

struct DEmptyStateView: View {
    let type: EmptyStateType
    let onTapGesture: (() -> Void)?
    
    
    init(type: EmptyStateType = .searchNotFound(title: String(localized: "No cities found")), onTapGesture: (() -> Void)? = nil) {
        self.type = type
        self.onTapGesture = onTapGesture
    }
    
    private var content: (title: String, description: String, buttonText: String?, icon: String) {
        type.content
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: content.icon)
                .font(.poppins(.semiBold, size: .custom(60)))
                .foregroundColor(.secondary)
                .symbolEffect(.pulse.byLayer, options: .repeating, isActive: true)
            
            VStack(spacing: 10) {
                Text(content.title)
                    .font(.poppins(.regular, size: .title2))
                    .fontWeight(.semibold)
                
                Text(content.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                if let buttonText = content.buttonText {
                    Button {
                        onTapGesture?()
                    } label: {
                        Text(buttonText)
                            .font(.poppins(.regular, size: .body))
                            .foregroundStyle(.appTextLight)
                            .padding(10)
                            .padding(.horizontal, 25)
                            .background(
                                Color.appGreenMedium,
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.appBackgroundDark.ignoresSafeArea()
        
        VStack {
            DEmptyStateView(type: .searchNotFound(title: String(localized: "No cities found")))
            DEmptyStateView(type: .imageNotFound) {
                print("Button tapped")
            }
        }
    }
    .preferredColorScheme(.dark)
}
