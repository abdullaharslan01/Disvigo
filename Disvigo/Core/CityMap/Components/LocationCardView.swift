//
//  LocationCardView.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import SwiftUI

import SwiftUI

struct LocationCardView: View {
    let location: Location
    var distance: String?
    let onTapDetail: (() -> Void)?
    
    @State private var isAppear: Bool = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.gray.opacity(0.3)
            
            if isAppear {
                backgroundImage
                gradientOverlay
            }
            
            content
        }.onAppear { isAppear = true }
            .onDisappear { isAppear = false }
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var backgroundImage: some View {
        Group {
            if !location.images.isEmpty {
                DImageLoaderView(url: location.images.randomElement(), contentMode: .fill)
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
            } else {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
            }
        }.overlay(alignment: .topTrailing) {
            distanceBadge
        }
        .overlay(alignment: .center, content: {
            Group {
                if location.images.isEmpty {
                    isContentUnavaliableView
                }
            }
                
        })
    }
    
    private var isContentUnavaliableView: some View {
        VStack {
            Image(systemName: AppIcons.photo)
                .font(.system(size: 100))
                .foregroundStyle(.appBackgroundDark)
                .symbolEffect(.pulse.byLayer, options: .repeating, isActive: true)
            
        }.padding(.horizontal)
    }
    
    private var distanceBadge: some View {
        Group {
            if let distance = distance, !distance.isEmpty {
                Text(distance)
                    .font(.poppins(.semiBold, size: .caption))
                    .padding(5)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(16)
            }
        }
    }
    
    private var gradientOverlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
            startPoint: .top,
            endPoint: .bottom
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var content: some View {
        VStack {
            VStack(alignment: .leading) {
                title
                detailButton
            }
        }.padding(.bottom,35)
            .padding(.horizontal,16)
    }
    
    private var title: some View {
        Text(location.title)
            .font(.poppins(.semiBold, size: .title2))
            .foregroundStyle(.appTextLight)
            .minimumScaleFactor(0.65)
            .lineLimit(4)
            .frame(maxWidth: 250, alignment: .leading)
    }
    
    private var detailButton: some View {
        DLabelButtonView(systemImage: AppIcons.walkIcon, title: String(localized: "Detail"), symbolFont: .callout, textFont: .callout) {
            onTapDetail?()
        }
    }
}

#Preview {
    LocationCardView(
        location: .init(title: "Gaziantep Kalesi", description: "", images: [], coordinates: .init(latitude: 0, longitude: 0)),
        distance: "1km",
        onTapDetail: {}
    ).frame(height: 180).preferredColorScheme(.dark)
}
