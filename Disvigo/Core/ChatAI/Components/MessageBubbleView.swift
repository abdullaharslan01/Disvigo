//
//  MessageBubbleView.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    @State private var showCopiedAlert = false
    @State private var isPressed = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            if message.isFromUser {
                Spacer(minLength: 50)
            }
            
            if message.isLoading {
                LoadingBubbleView()
            } else {
                VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 4) {
                    Text(markdown: message.content)
                        .font(.poppins(.regular, size: .body))
                        .foregroundColor(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(
                                    message.isFromUser ?
                                        LinearGradient(
                                            colors: [Color.chatPrimary, Color.chatSecondary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ) :
                                        LinearGradient(
                                            colors: [Color.chatSurface, Color.chatSurface.opacity(0.8)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                colors: message.isFromUser ?
                                                    [Color.white.opacity(0.3), Color.clear] :
                                                    [Color.white.opacity(0.1), Color.clear],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1
                                        )
                                )
                        )
                        .shadow(
                            color: message.isFromUser ?
                                Color.chatPrimary.opacity(0.3) :
                                Color.black.opacity(0.2),
                            radius: isPressed ? 2 : 8,
                            x: 0,
                            y: isPressed ? 1 : 4
                        )
                        .scaleEffect(isPressed ? 0.98 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isPressed)
                    
                    Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                        .font(.poppins(.regular, size: .caption))
                        .foregroundColor(.chatTextSecondary.opacity(0.7))
                        .padding(.horizontal, 4)
                }
                .contextMenu {
                    Button {
                        UIPasteboard.general.string = message.content
                        showCopiedAlert = true
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    } label: {
                        Label(String(localized: "Copy"), systemImage: "doc.on.doc")
                    }
                    
                    ShareLink(item: message.content) {
                        Label(String(localized: "Share"), systemImage: "square.and.arrow.up")
                    }
                }
                .onLongPressGesture(minimumDuration: 0) { pressing in
                    isPressed = pressing
                } perform: {}
                .alert(String(localized: "Copied to clipboard"), isPresented: $showCopiedAlert) {
                    Button(String(localized: "OK"), role: .cancel) {}
                }
            }
            
            if !message.isFromUser {
                Spacer(minLength: 50)
            }
        }
        .transition(.asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .opacity
        ))
    }
}

extension Message {
    var timestamp: Date {
        Date()
    }
}

#Preview {
    VStack {
        MessageBubbleView(message: .init(content: "Hello World", isFromUser: true))
        MessageBubbleView(message: .init(content: "Hello People", isFromUser: false))
    }.padding(.horizontal)
}
