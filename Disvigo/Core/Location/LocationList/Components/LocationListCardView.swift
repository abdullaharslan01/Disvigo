//
//  LocationDetailCardView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI

struct LocationListCardView: View {
    let location: Location
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
            .frame(height: height)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 10)
            .contextMenu(menuItems: {
                DLabelButtonView(systemImage: AppIcons.locationDetail, title: String(localized: "Go to Detail")) {
                    onTapGesture()
                }
            })
            .onAppear { isAppear = true }
            .onDisappear { isAppear = false }
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
        Group {
            if let image = location.images.first {
                DImageLoaderView(
                    url: image,
                    contentMode: .fill
                )
                .transition(.opacity.animation(.easeInOut(duration: 0.3)))
            } else {
                contentUnavaliableView
            }
        }
    }

    private var contentUnavaliableView: some View {
        VStack {
            Image(systemName: AppIcons.photo)
                .font(.poppins(.semiBold, size: .custom(50)))
                .foregroundColor(.appGreenMedium)
                .symbolEffect(.pulse.byLayer, options: .repeating, isActive: true)

            Text(String(localized: "Image not found"))
                .font(.poppins(.italic, size: .callout))
                .foregroundStyle(.appTextSecondary)
        }
    }

    private var gradientOverlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black.opacity(0.3), .black.opacity(0.4)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var title: some View {
        Text(location.title)
            .font(.poppins(.semiBold, size: .title3))
            .foregroundStyle(.appTextLight)
            .lineLimit(4)
            .padding()
    }
}

#Preview {
    HStack {
        LocationListCardView(location: .init(id: "2", title: "Taş Köprü", description: "", images: [], coordinates: .init(latitude: 0, longitude: 0))) {}
        LocationListCardView(location: DeveloperPreview.shared.location) {}
    }
}
