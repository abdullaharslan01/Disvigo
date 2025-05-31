//
//  VisitedView.swift
//  Disvigo
//
//  Created by abdullah on 31.05.2025.
//

import SwiftData
import SwiftUI

struct VisitedView: View {
    @State private var createListState = false
    @Environment(VisitedManager.self) private var visitedManager
    @Environment(Router.self) private var router

//    @State private var items: [VisitedList] = [
//        .init(name: "İstanbul Hatırası", symbolName: "sailboat", color: .red),
//        .init(name: "Ege Turu", symbolName: "beach.umbrella", color: .blue),
//        .init(name: "Kapadokya", symbolName: "airplane.departure", color: .green),
//        .init(name: "Karadeniz Yaylaları", symbolName: "leaf.fill", color: .purple),
//        .init(name: "Akdeniz Plajları", symbolName: "sun.max.fill", color: .orange)
//    ]

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            if !visitedManager.visitedLists.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(visitedManager.visitedLists) { item in

                            VisitedRowView(item: item) {
                                router.navigate(to: .visitedDetail(item))
                            }
                        }
                    }.padding(.horizontal)
                        .padding(.top, 40)
                }.safeAreaInset(edge: .bottom) {
                    Button {
                        createListState.toggle()
                    } label: {
                        Text("Add New List")
                            .font(.poppins(.medium, size: .headline))
                            .foregroundStyle(.appTextLight)
                            .padding()
                            .padding(.horizontal)
                            .background(
                                Color.appGreenPrimary, in: RoundedRectangle(cornerRadius: 16)
                            )
                    }.padding(.bottom)
                }
            } else {
                contentUnavailableView
                    .padding(.bottom, 50)
            }

        }.preferredColorScheme(.dark)
            .navigationTitle(String(localized: "My Travel Lists"))
            .fullScreenCover(isPresented: $createListState) {
                AddListView(isUpdate: false)
            }
    }

    var contentUnavailableView: some View {
        DLottieEmtyView(lottieName: AppImages.Lottie.historical,
                        title: String(localized: "Your Travel Lists Await"),
                        buttonTitle: String(localized: "Create First List"),
                        message: String(localized: "Organize your adventures! Create lists for different trips, add locations you've visited or want to explore, and track your travel memories all in one place."), textColor: .appTextLight, buttonBackground: .appGreenPrimary, buttonForeground: .appTextLight)
        {
            createListState.toggle()
        }
    }
}

struct VisitedRowView: View {
    let item: VisitedList
    let onTapGesture: () -> ()

    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            onTapGesture()
        } label: {
            HStack(spacing: 15) {
                Image(systemName: item.symbolName)
                    .font(.system(size: 25))
                    .foregroundStyle(item.color)

                Text(item.name)
                    .font(.poppins(.medium, size: .headline))
                    .lineLimit(1)

                Spacer()
                Image(systemName: AppIcons.chevronRight)
                    .font(.system(size: 25))

            }.foregroundStyle(.black)
                .padding()
                .background(
                    Color.appGreenExtraLight, in: RoundedRectangle(cornerRadius: 16)
                )
        }
    }
}

#Preview {
    VisitedView()
        .environment(VisitedManager())
        .environment(Router())
}
