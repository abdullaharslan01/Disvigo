//
//  LoadingPhaseCircle.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import SwiftUI

struct LoadingPhaseCircle: Identifiable, Equatable {
    var id: Int
    var color: Color

    static let all: [LoadingPhaseCircle] = [
        .init(id: 0, color: Color.chatPrimary),
        .init(id: 1, color: Color.chatSecondary),
        .init(id: 2, color: Color.chatPrimary.opacity(0.8)),
        .init(id: 3, color: Color.chatSecondary.opacity(0.8)),
        .init(id: 4, color: Color.chatPrimary.opacity(0.6))
    ]
}

struct LoadingBubbleView: View {
    @State private var currentItemIndex = 0
    @State private var animationTimer: Timer?
    @State private var pulseScale: CGFloat = 1.0

    var body: some View {
        HStack(spacing: 8) {
            ForEach(LoadingPhaseCircle.all) { phase in
                circle(phase)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.chatSurface.opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.2), Color.clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .scaleEffect(pulseScale)
        .onAppear {
            startAnimation()
            startPulseAnimation()
        }
        .onDisappear {
            stopAnimation()
        }
    }

    @ViewBuilder
    func circle(_ phase: LoadingPhaseCircle) -> some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [phase.color, phase.color.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 8, height: 8)
            .scaleEffect(currentItemIndex == phase.id ? 1.3 : 0.8)
            .opacity(currentItemIndex == phase.id ? 1.0 : 0.6)
            .animation(.easeInOut(duration: 0.4), value: currentItemIndex)
    }

    private func startAnimation() {
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.4)) {
                currentItemIndex = (currentItemIndex + 1) % LoadingPhaseCircle.all.count
            }
        }
    }
    
    private func startPulseAnimation() {
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            pulseScale = 1.05
        }
    }

    private func stopAnimation() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
}
#Preview {
    LoadingBubbleView()
}
