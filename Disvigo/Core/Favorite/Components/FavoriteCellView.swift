//
//  FavoriteCellView.swift
//  Disvigo
//
//  Created by abdullah on 30.05.2025.
//

import SwiftUI

struct FavoriteCellInfo {
    var imageURL: String?
    var title: String
    var description: String
    var iconType: IconType
}

enum IconType {
    case food
    case city
    case location
    case memory

    var imageName: String {
        switch self {
        case .food:
            return AppIcons.food
        case .city:
            return AppIcons.cityDetail
        case .location:
            return AppIcons.location
        case .memory:
            return AppIcons.basket
        }
    }
}

struct FavoriteCellView: View {
    let favoriteCellInfo: FavoriteCellInfo
    let onTapGesture: () -> Void
    let onFavoriteTapGesture: () -> Void
    
    @State private var isImageLoaded = false
    
    var body: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            onTapGesture()
        }) {
            VStack(spacing: 0) {
                imageSection
                    .frame(height: 180)
                    .clipped()
                textSection
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .overlay(alignment: .topTrailing) {
            favoriteButton
        }
        .contextMenu {
            contextMenuItems
        }
    }
}

// MARK: - View Components

extension FavoriteCellView {
    private var imageSection: some View {
        ZStack {
            Color.gray.opacity(0.2)
            
            Group {
                if let imageURL = favoriteCellInfo.imageURL, !imageURL.isEmpty {
                    DImageLoaderView(
                        url: imageURL,
                        contentMode: .fill
                    )
                    .onAppear { isImageLoaded = true }
                } else {
                    placeholderView
                }
            }
            
            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.1),
                    .black.opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    private var placeholderView: some View {
        VStack(spacing: 8) {
            Image(systemName: favoriteCellInfo.iconType.imageName)
                .font(.system(size: 40, weight: .regular))
                .foregroundColor(.appGreenMedium)
                .symbolEffect(.pulse.byLayer, options: .repeating)
            
            Text(String(localized: "Image is loading..."))
                .font(.poppins(.medium, size: .caption))
                .foregroundColor(.appTextSecondary)
        }
    }
    
    private var textSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(favoriteCellInfo.title)
                .font(.poppins(.semiBold, size: .subheadline))
                .foregroundColor(.appBackgroundDeep)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Text(favoriteCellInfo.description)
                .font(.poppins(.regular, size: .caption))
                .foregroundColor(.appTextSecondary)
                .lineLimit(3)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var favoriteButton: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            onFavoriteTapGesture()
        }) {
            Image(systemName: AppIcons.heartFill)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.red)
                .frame(width: 32, height: 32)
                .background(
                    Color.white.opacity(0.9),
                    in: Circle()
                )
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding(12)
    }
    
    @ViewBuilder
    private var contextMenuItems: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            onTapGesture()
        }) {
            Label(
                String(localized: "Dive into the details of \(favoriteCellInfo.title)"),
                systemImage: favoriteCellInfo.iconType.imageName
            )
        }
        
        Button(role: .destructive, action: {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            onFavoriteTapGesture()
        }) {
            Label(
                String(localized: "Remove from favorites"),
                systemImage: AppIcons.heart
            )
        }.tint(.red)
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing: 16) {
            // With image
            FavoriteCellView(
                favoriteCellInfo: .init(
                    imageURL: "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190111110947922_THK%20ORHAN%20OZGULBAS%20ADANA%20Seyhan%20Nehri%20Taskopru%20logolu.jpg?format=jpg&quality=50",
                    title: "Adana Taş Köprü",
                    description: "Ancient stone bridge over Seyhan River",
                    iconType: .location
                )
            ) {
                print("Tapped")
            } onFavoriteTapGesture: {
                print("Favorite tapped")
            }
            .frame(width: 200)
            
            // Without image (placeholder)
            FavoriteCellView(
                favoriteCellInfo: .init(
                    imageURL: nil,
                    title: "Sample Food",
                    description: "Traditional Turkish cuisine",
                    iconType: .food
                )
            ) {
                print("Tapped")
            } onFavoriteTapGesture: {
                print("Favorite tapped")
            }
            .frame(width: 200)
        }
        .padding()
    }
}
