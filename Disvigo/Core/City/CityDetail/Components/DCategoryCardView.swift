//
//  DCategoryCardView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import SwiftUI

struct DCategoryCardView: View {
    let category: Category
    @Binding var isLoading: Bool
    let size: CGSize
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Image(category.imageName)
                    .resizable()
                    .scaledToFill()

                Color.black.opacity(0.3)

                VStack {
                    Text(category.name)
                        .font(.poppins(.semiBold, size: .title2))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(4)

                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    }
                }
            }
            .frame(width: size.width, height: size.height)
            .cornerRadius(16)
            .shadow(
                color: .black.opacity(0.4),
                radius: 3,
                x: 0,
                y: 2
            ).contextMenu {
                Button {
                    action()
                } label: {
                    Label(category.name, systemImage: category.systemImageName)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        DCategoryCardView(category: .food, isLoading: .constant(true), size: .init(width: 200, height: 300)) {}

    }.padding(.horizontal)
}
