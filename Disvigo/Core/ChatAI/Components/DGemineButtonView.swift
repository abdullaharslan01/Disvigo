//
//  DGemineButtonView.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import SwiftUI

struct DGemineChatButtonView: View {
    @Binding var gemineViewState: GemineViewState
    @Binding var showChat: Bool

    @Namespace private var chatNamespace

    var body: some View {
        ZStack {
            if showChat {
                Color.appBackgroundDark.ignoresSafeArea()
            }

            if showChat {
                ChatAIView(
                    aiViewState: $gemineViewState,
                    namespace: chatNamespace,
                    close: $showChat
                )
                .transition(.identity)
            }

            if !showChat {
                HStack {
                    Button {
                        withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                            showChat = true
                        }
                    } label: {
                        Image(AppImages.Constant.gemini)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(10)
                            .background(
                                .appGreenPrimary,
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                            .matchedGeometryEffect(id: "chatButton", in: chatNamespace)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
            }
        }
    }
}
