//
//  DCategoryCardView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import SwiftUI

struct DCategoryCardView: View {
    
    let category:Category
    let size: CGSize
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Image(category.imageName)
                    .resizable()
                    .scaledToFill()

                Color.black.opacity(0.3)

                Text(category.name)
                    .font(.poppins(.semiBold, size: .title2))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(width: size.width, height: size.height)
            .cornerRadius(16)
            .shadow(
                color: .black.opacity(0.4),
                radius: 3,
                x: 0,
                y: 2
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack {
            ForEach(0 ..< 3) { _ in
              
                
                
            }
        }.padding(.horizontal)
    }.scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
}

