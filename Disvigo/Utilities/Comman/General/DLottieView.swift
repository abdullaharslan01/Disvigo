//
//  DLottieView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI
import Lottie

struct DLottieView: View {
    var animationName: String
    var loopMode: LottieLoopMode = .loop

    var body: some View {
        LottieView(animation: .named(animationName))
            .playing(loopMode: loopMode)
    }
}

#Preview {
    DLottieView(animationName: AppImages.Lottie.splashLoading)
}
