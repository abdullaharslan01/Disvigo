//
//  ChatAIView.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import SwiftUI

struct ChatAIView: View {
    @Binding var aiViewState: GemineViewState
    let namespace: Namespace.ID
    @Binding var close: Bool

    @FocusState var messageFocused: Bool
    
    @State var vm = ChatViewModel()
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                    
                messagesView
                
                inputArea
            }
        }
        .onAppear {
            vm.welcomeMessage(welComeText)
        }
        .animation(.easeInOut(duration: 0.8), value: vm.messages.count)
    }
    
    private var headerView: some View {
        HStack(spacing: 16) {
            closeButton
                .matchedGeometryEffect(id: "chatButton", in: namespace)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.poppins(.semiBold, size: .title2))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color.chatText,
                                Color.chatTextSecondary
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                Text(subtitle)
                    .font(.poppins(.regular, size: .caption))
                    .foregroundColor(.chatTextSecondary.opacity(0.8))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            statusIndicator
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(
            .appBackgroundDark.opacity(0.6)
        )
    }
    
    private var closeButton: some View {
        DIconButtonView(
            iconButtonType: .custom(AppIcons.xmark),
            iconColor: .appTextLight,
            bgColor: .red, padding: 8
        ) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                close.toggle()
            }
        }
    }
    
    private var statusIndicator: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(vm.isLoading ? Color.orange : Color.green)
                .frame(width: 8, height: 8)
                .scaleEffect(vm.isLoading ? 1.2 : 1.0)
                .animation(
                    vm.isLoading ?
                        .easeInOut(duration: 0.3).repeatForever(autoreverses: true) :
                        .easeInOut(duration: 0.3),
                    value: vm.isLoading
                )
            
            Text(vm.isLoading ? String(localized: "Thinking...") : String(localized: "Online"))
                .font(.poppins(.medium, size: .caption))
                .foregroundColor(.chatTextSecondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color.chatSurface.opacity(0.6))
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                )
        )
    }
    
    private var messagesView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(vm.messages) { message in
                        MessageBubbleView(message: message)
                            .id(message.id)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom)
                                    .combined(with: .opacity)
                                    .combined(with: .scale(scale: 0.8)),
                                removal: .opacity.combined(with: .scale(scale: 0.9))
                            ))
                    }
                    
                    if vm.isLoading && !vm.messages.contains(where: { $0.isLoading }) {
                        TypingIndicatorView()
                            .transition(.opacity.combined(with: .scale))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: vm.messages) { _, _ in
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: vm.isLoading) { _, newValue in
                if newValue {
                    scrollToBottom(proxy: proxy)
                }
            }
        }
    }
    
    private var inputArea: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.1), Color.clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 0.5)
            
            HStack(spacing: 16) {
                ChatTextField(
                    title: String(localized: "Ask about \(title)..."),
                    text: $vm.textInput,
                    isDisable: $vm.isLoading
                )
                .focused($messageFocused)
                
                ChatSendButtonView(
                    isLoading: $vm.isLoading,
                    textInput: $vm.textInput
                ) {
                    sendMessage()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                .appBackgroundDark.opacity(0.6)

            )
            .onChange(of: vm.isLoading) { _, newValue in
                if newValue {
                    messageFocused = false
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button {
                        messageFocused = false
                    } label: {
                        Text(String(localized: "Done"))
                            .font(.poppins(.semiBold, size: .body))
                            .foregroundColor(.chatPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
    
    private func sendMessage() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        vm.sendMessageWith(aiViewState: aiViewState)
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let lastMessage = vm.messages.last else { return }
        withAnimation(.easeInOut(duration: 0.6)) {
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
    
    var welComeText: String {
        switch aiViewState {
        case .location(let location):
            return String(localized: "👋 Hello! I'm your personal guide for \(location.title). I can help you discover hidden gems, share fascinating stories, and answer any questions you have. What would you like to explore first?")

        case .turkey:
            return String(localized: "🇹🇷 Merhaba! I'm here to share the wonders of Türkiye with you. From ancient history to modern culture, stunning landscapes to delicious cuisine - what aspect of this beautiful country interests you most?")

        case .city(let city):
            return String(localized: "🏙️ Welcome! I'm your local expert for \(city.name). Whether you're planning a visit or just curious about this amazing city, I'm here to help. What would you like to discover?")
        }
    }
    
    var title: String {
        switch aiViewState {
        case .location(let location):
            return location.title
        case .turkey:
            return "Türkiye"
        case .city(let city):
            return city.name
        }
    }
    
    var subtitle: String {
        switch aiViewState {
        case .location:
            return String(localized: "Location Guide")
        case .turkey:
            return String(localized: "Country Expert")
        case .city:
            return String(localized: "City Assistant")
        }
    }
}


struct AnimatedGradientBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(
            colors: [
                Color.chatBackground,
                Color.chatBackground.opacity(0.8),
                Color.chatSurface.opacity(0.3)
            ],
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

struct TypingIndicatorView: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(0 ..< 3) { index in
                    Circle()
                        .fill(Color.chatTextSecondary.opacity(0.6))
                        .frame(width: 6, height: 6)
                        .offset(y: animationOffset)
                        .animation(
                            .easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                            value: animationOffset
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.chatSurface.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
            
            Spacer()
        }
        .onAppear {
            animationOffset = -4
        }
    }
}

extension Color {
    static let chatPrimary = Color(red: 0.2, green: 0.6, blue: 0.9)
    static let chatSecondary = Color(red: 0.1, green: 0.4, blue: 0.8)
    static let chatBackground = Color(red: 0.05, green: 0.08, blue: 0.15)
    static let chatSurface = Color(red: 0.15, green: 0.18, blue: 0.25)
    static let chatText = Color(red: 0.95, green: 0.96, blue: 0.98)
    static let chatTextSecondary = Color(red: 0.75, green: 0.77, blue: 0.82)
    static let chatAccent = Color(red: 0.9, green: 0.3, blue: 0.3)
}
