//
//  VisitedDetailView.swift
//  Disvigo
//
//  Created by abdullah on 31.05.2025.
//

import SwiftUI

struct VisitedDetailView: View {
    let visitedList: VisitedList

    @Environment(FavoriteManager.self) var visitedManager
    @Environment(Router.self) var router
    @State private var editListState: Bool = false

    var body: some View {
        ZStack {
            Color.appTextSecondary.opacity(0.4).ignoresSafeArea()

            List(visitedList.visitedItems) { visitedListItem in

                VisitedDetailRowView(visitedListItem: visitedListItem)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .padding(.horizontal, 5)
            }
            .padding(.top)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(.clear)
            .refreshable {
                visitedManager.fetchVisitedList()
            }.onAppear(perform: {
                let item = visitedManager.visitedLists[0]

                if item.visitedItems.isEmpty {
                    for location in DeveloperPreview.shared.locations {
                        item.visitedItems.append(.init(location: location))
                    }
                }

            })

            .navigationTitle(visitedList.name)
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String(localized: "Edit")) {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        editListState.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $editListState) {
                AddListView(isUpdate: true, visitedList: visitedList)
            }
        }
    }
}

#Preview {
    NavigationStack {
        VisitedDetailView(visitedList: .init(name: "İstanbul"))
            .environment(FavoriteManager())
            .environment(Router())
    }
}

struct VisitedDetailRowView: View {
    var visitedListItem: VisitedListItem

    @State private var rotation: Double = 0

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                visitedListItem.isVisited.toggle()

                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                rotation += 360
            }

        } label: {
            HStack(spacing: 10) {
                checkMarkView
                LocationSelectionRowView(location: visitedListItem.location)
            }
        }
    }

    @ViewBuilder
    var checkMarkView: some View {
        Image(systemName: visitedListItem.isVisited ? AppIcons.checkMarkCircleFill : AppIcons.checkMarkCircle)
            .font(.system(size: 30))
            .foregroundStyle(visitedListItem.isVisited ? .appGreenPrimary : .gray)
            .rotationEffect(.degrees(rotation))
    }
}
