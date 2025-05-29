//
//  CityRowView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct CityRowView: View {
    let city: City
    let onTapGesture: () -> ()
    let height: CGFloat = 180
    @State private var isAppear: Bool = false

    var body: some View {
        Button {
            onTapGesture()
        } label: {
            ZStack {
                backgroundView

                title
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 10)
            .onAppear { isAppear = true }
            .onDisappear { isAppear = false }
        }.contextMenu {
            Button {
                onTapGesture()

            } label: {
                Label(String(localized: "Discover \(city.name)"), systemImage: AppIcons.cityDetail)
            }
        }
    }

    private var backgroundView: some View {
        ZStack {
            Color.gray.opacity(0.3)

            if isAppear {
                imageView
                gradientOverlay
            }
        }
    }

    private var imageView: some View {
        DImageLoaderView(
            url: city.imageUrl,
            contentMode: .fill
        )
        .transition(.opacity.animation(.easeInOut(duration: 0.3)))
    }

    private var gradientOverlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black.opacity(0.3), .black.opacity(0.4)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var title: some View {
        Text(city.name)
            .font(.poppins(.semiBold, size: .largeTitle))
            .foregroundStyle(.appTextLight)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .padding(.horizontal, 16)
    }
}

#Preview {
    CityRowView(city: DeveloperPreview.shared.city) {}
        .padding(.horizontal)
}
