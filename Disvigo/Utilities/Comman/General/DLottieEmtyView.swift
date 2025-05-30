//
//  DLottieEmtyView.swift
//  Disvigo
//
//  Created by abdullah on 26.05.2025.
//

import Lottie
import SwiftUI

struct DLottieEmtyView: View {
    let lottieName: String
    let title: String
    let buttonTitle: String
    let message: String

    var textColor: Color = .appBackgroundDark
    var buttonBackground: Color = .pink
    var buttonForeground: Color = .appTextLight
    var exploreAction: (() -> Void)?

    var body: some View {
        VStack {
            animationView
            textContent
            exploreButton
        }
        .transition(.opacity)
        .foregroundColor(textColor)
    }

    private var animationView: some View {
        LottieView(animation: .named(lottieName))
            .playing(loopMode: .loop)
    }

    private var textContent: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.poppins(.bold, size: .title2))

            Text(message)
                .font(.poppins(.regular, size: .body))
                .multilineTextAlignment(.center)
                .opacity(0.5)
        }
        .foregroundStyle(textColor)
    }

    private var exploreButton: some View {
        Button(action: {
            exploreAction?()
        }) {
            Text(buttonTitle)
                .font(.poppins(.medium, size: .headline))
                .padding()
                .padding(.horizontal)
                .background(buttonBackground)
                .foregroundColor(buttonForeground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.top, 20)
    }
}

#Preview {
    ZStack {
        Color.appTextSecondary.opacity(0.4).ignoresSafeArea()
        DLottieEmtyView(lottieName: AppImages.Lottie.walkingPeople, title: "Unable to create route", buttonTitle: "Explore Now", message: "You need at least two cities to generate a route. You can do this by adding at least two cities to your favorites.")
    }
}
