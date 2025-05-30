//
//  FavoriteButtonView.swift
//  Disvigo
//
//  Created by abdullah on 30.05.2025.
//

import SwiftUI

struct FavoriteButtonView: View {
    @Binding var isFavorite: Bool
    var onTapGusture: () -> ()

    var body: some View {
        Button {
            
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            
            
          onTapGusture()
        } label: {
            Image(systemName: isFavorite ? AppIcons.heartFill : AppIcons.heart)
                .symbolEffect(.pulse, isActive: !isFavorite)
                .font(.poppins(.medium, size: .title))
                .foregroundStyle(.red)
                .padding()
                .background(
                    .white, in: RoundedRectangle(cornerRadius: 16)
                ).padding()
        }
    }
}

#Preview {
    FavoriteButtonView(isFavorite: .constant(true)) {
        
    }
}
