//
//  ChatTextField.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import SwiftUI

struct ChatTextField: View {
    let title: String
    @Binding var text: String
    @Binding var isDisable: Bool
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(title, text: $text, axis: .vertical)
            .font(.poppins(.regular, size: .body))
            .foregroundColor(.chatText)
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(
                        Color.chatSurface.opacity(0.8)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: isFocused ?
                                        [Color.chatPrimary.opacity(0.8), Color.chatSecondary.opacity(0.6)] :
                                        [Color.white.opacity(0.2), Color.clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: isFocused ? 2 : 1
                            )
                    )
            )
            .autocorrectionDisabled()
            .disabled(isDisable)
            .focused($isFocused)
            .shadow(
                color: isFocused ? Color.chatPrimary.opacity(0.3) : Color.clear,
                radius: isFocused ? 12 : 0,
                x: 0,
                y: isFocused ? 6 : 0
            )
            .animation(.easeInOut(duration: 0.3), value: isFocused)
            .animation(.easeInOut(duration: 0.2), value: isDisable)
    }
}

#Preview {
    ChatTextField(title: "", text: .constant(""), isDisable: .constant(false))
        .padding(.horizontal)
}
