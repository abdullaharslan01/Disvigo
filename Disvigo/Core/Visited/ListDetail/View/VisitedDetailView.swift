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
            
            if visitedList.visitedItems.isEmpty {
                emptyStateView
            } else {
                mainContentView
            }
        }
        .onAppear {
              setupDeveloperPreview()
        }
        .navigationTitle(visitedList.name)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if !visitedList.visitedItems.isEmpty {
                    Button {
                        router.navigate(to: .rotationSelection(converSavedLocationsToLocation()))

                    } label: {
                        Image(systemName: AppIcons.map)
                            .foregroundStyle(.cyan)
                    }

                    .contextMenu {
                        Button {
                            router.navigate(to: .rotationSelection(converSavedLocationsToLocation()))

                        } label: {
                            Label(String(localized: "Create route from selected locations."), systemImage: AppIcons.map)
                        }
                    }
                }
                
                Button(String(localized: "Edit")) {
                    hapticFeedback()
                    editListState.toggle()
                }.contextMenu {
                    Button {
                        hapticFeedback()
                        editListState.toggle()

                    } label: {
                        Label(String(localized: "Edit list"), systemImage: AppIcons.map)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $editListState) {
            AddListView(isUpdate: true, visitedList: visitedList)
        }
    }
    
    private var mainContentView: some View {
        VStack(spacing: 0) {
            selectionControlView
                .padding(.horizontal)
                .padding(.vertical, 16)
            
            List {
                ForEach(visitedList.visitedItems) { visitedListItem in
                    VisitedDetailRowView(visitedListItem: visitedListItem)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 5)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            swipeActionButtons(for: visitedListItem)
                        }
                        .contextMenu {
                            contextMenuButtons(for: visitedListItem)
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(.clear)
            .refreshable {
                visitedManager.fetchVisitedList()
            }
        }
    }
}

extension VisitedDetailView {
    private func converSavedLocationsToLocation() -> [Location] {
        return visitedList.visitedItems.map { $0.location }
    }
    
    private var visitedItemsCount: Int {
        visitedList.visitedItems.filter(\.isVisited).count
    }
    
    private var totalItemsCount: Int {
        visitedList.visitedItems.count
    }
    
    private var isAllVisited: Bool {
        !visitedList.visitedItems.isEmpty && visitedList.visitedItems.allSatisfy(\.isVisited)
    }
    
    private var isNoneVisited: Bool {
        visitedList.visitedItems.allSatisfy { !$0.isVisited }
    }
}

extension VisitedDetailView {
    private var selectAllButton: some View {
        DIconButtonView(
            iconButtonType: .custom(isAllVisited ? AppIcons.checkedAllList : AppIcons.unCheckedAllList),
            fontSize: .body
        ) {
            hapticFeedback(.heavy)
            toggleAllSelection()
        }
    }
    
    private var selectionCounterView: some View {
        HStack(spacing: 2) {
            Text("\(visitedItemsCount)")
                .frame(width: 30)
                .contentTransition(.numericText())
            
            Text("/")
            
            Text("\(totalItemsCount)")
                .frame(width: 30)
        }
        .foregroundColor(.secondary)
        .font(.poppins(.medium, size: .body))
        .animation(.default, value: visitedItemsCount)
    }
    
    private var selectionControlView: some View {
        HStack(spacing: 16) {
            selectAllButton
            selectionCounterView
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func swipeActionButtons(for item: VisitedListItem) -> some View {
        Button(role: .destructive) {
            removeItem(item)
        } label: {
            Label(String(localized: "Remove"), systemImage: AppIcons.trash)
        }.tint(.red)
        
        Button {
            toggleVisited(item)
        } label: {
            Label(
                String(localized: item.isVisited ? "Uncheck" : "Check"),
                systemImage: item.isVisited ? AppIcons.checkMarkCircleFill : AppIcons.checkMarkCircle
            )
            .tint(.accent)
        }
        
        Button {
            navigateToDetail(item)
        } label: {
            Label(String(localized: "Go to Detail"), systemImage: AppIcons.locationDetail)
        }
        .tint(.blue)
    }
    
    @ViewBuilder
    private func contextMenuButtons(for item: VisitedListItem) -> some View {
        Button {
            toggleVisited(item)
        } label: {
            Label(
                String(localized: item.isVisited ? "Uncheck" : "Check"),
                systemImage: item.isVisited ? AppIcons.checkMarkCircleFill : AppIcons.checkMarkCircle
            )
        }
        
        Button {
            navigateToDetail(item)
        } label: {
            Label(String(localized: "Detail"), systemImage: AppIcons.locationDetail)
        }
        
        Button(role: .destructive) {
            removeItem(item)
        } label: {
            Label(String(localized: "Remove"), systemImage: AppIcons.trash)
        }.tint(.red)
    }
    
    // MARK: - Empty State View

    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.walkingPerson,
            title: String(localized: "No Locations Added Yet"),
            buttonTitle: String(localized: "Browse Cities"),
            message: String(localized: "You haven't added any locations to this list yet. Visit the Cities page to discover and add your favorite destinations to your travel list."),
            textColor: .appTextLight,
            buttonBackground: .appGreenPrimary,
            buttonForeground: .appTextLight
        ) {
            router.navigateToRoot()
        }
        .padding(.bottom, 50)
        .padding(.horizontal)
    }
}

// MARK: - Actions

extension VisitedDetailView {
    private func toggleAllSelection() {
        withAnimation(.easeInOut(duration: 0.3)) {
            let newState = !isAllVisited
            for item in visitedList.visitedItems {
                item.isVisited = newState
            }
        }
    }
    
    private func toggleVisited(_ item: VisitedListItem) {
        hapticFeedback()
        withAnimation {
            item.isVisited.toggle()
        }
    }
    
    private func removeItem(_ item: VisitedListItem) {
        hapticFeedback()
        withAnimation {
            visitedManager.removeVisitedItem(visitedList: visitedList, visitedListItem: item)
        }
    }
    
    private func navigateToDetail(_ item: VisitedListItem) {
        hapticFeedback()
        router.navigate(to: .locationDetail(item.location))
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                visitedList.visitedItems.remove(at: index)
            }
        }
    }
    
    private func setupDeveloperPreview() {
        if let firstList = visitedManager.visitedLists.first, firstList.visitedItems.isEmpty {
            for location in DeveloperPreview.shared.locations {
                firstList.visitedItems.append(.init(location: location))
            }
        }
    }
    
    private func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        VisitedDetailView(visitedList: .init(name: "İstanbul"))
            .environment(FavoriteManager())
            .environment(Router())
    }
}

// MARK: - VisitedDetailRowView

struct VisitedDetailRowView: View {
    let visitedListItem: VisitedListItem
    @State private var rotation: Double = 0
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                visitedListItem.isVisited.toggle()
                rotation += 360
            }
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } label: {
            HStack(spacing: 10) {
                checkmarkIcon
                LocationSelectionRowView(location: visitedListItem.location)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var checkmarkIcon: some View {
        Image(systemName: visitedListItem.isVisited ? AppIcons.checkMarkCircleFill : AppIcons.checkMarkCircle)
            .font(.system(size: 30))
            .foregroundStyle(visitedListItem.isVisited ? .appGreenPrimary : .gray)
            .rotationEffect(.degrees(rotation))
            .animation(.easeInOut(duration: 0.5), value: rotation)
    }
}
