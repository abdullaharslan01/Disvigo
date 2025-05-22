//
//  SplashView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var gradientOffset: CGFloat = -200

    var body: some View {
        ZStack {
            Color.appBackgroundDeep.ignoresSafeArea()
            
            VStack {
                DLottieView(animationName: AppImages.Lottie.splashLoading)
                    .offset(y: -50)
                    
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        Text("DISVIG")
                            .font(.poppins(.semiBold, size: .custom(70)))
                            .foregroundStyle(.appTextSecondary)
                        
                        Image("logoTransparent")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 86)
                            .offset(x: -6)
                          
                    }
                    
                    Text(String(localized: "Discover Navigate Go", comment: "Splash screen motto text"))
                        .font(.poppins(.light, size: .custom(24)))
                        .foregroundStyle(.appGreenMedium)
                        .mask(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .white, .appBackgroundGray, .clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 250, height: 50)
                            .offset(x: gradientOffset)
                            .onAppear {
                                withAnimation(
                                    .linear(duration: 3.0)
                                        .repeatForever(autoreverses: true)
                                ) {
                                    gradientOffset = 200
                                }
                            }
                        )
                }
                .offset(y: -50)
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    SplashView()
}
