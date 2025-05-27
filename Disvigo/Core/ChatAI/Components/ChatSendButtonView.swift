//
//  ChatSendButtonView.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import SwiftUI

struct ChatSendButtonView: View {
    @Binding var isLoading: Bool
    @Binding var textInput: String
    var onTapGesture: () -> ()

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                onTapGesture()
            }
        } label: {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.9)
                } else {
                    Image(systemName: AppIcons.paperplaneFill)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .rotationEffect(.degrees(isLoading ? 360 : 0))
                }
            }
            .frame(width: 44, height: 44)
            .background(
                Circle()
                    .fill(
                        LinearGradient(
                            colors: isDisable ?
                                [Color.gray.opacity(0.6), Color.gray.opacity(0.4)] :
                                [Color.chatPrimary, Color.chatSecondary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.3), Color.clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(
                        color: isDisable ? Color.clear : Color.chatPrimary.opacity(0.4),
                        radius: isLoading ? 15 : 8,
                        x: 0,
                        y: isLoading ? 8 : 4
                    )
            )
            .scaleEffect(isLoading ? 1.05 : 1.0)
        }
        .buttonStyle(.plain)
        .disabled(isDisable)
        .animation(.easeInOut(duration: 0.3), value: isLoading)
        .animation(.easeInOut(duration: 0.2), value: isDisable)
    }

    var isDisable: Bool {
        textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading
    }
}

#Preview {
    ChatSendButtonView(isLoading: .constant(false), textInput: .constant("Hello")) {}
}
