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
    @State private var willDeleteItem: VisitedList?
    @State private var warningDialog = false
    @State private var resultAlert = false
    
    @Environment(FavoriteManager.self) private var visitedManager
    @Environment(Router.self) private var router
    @Binding var tabbarHeight: CGFloat

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            
            if visitedManager.visitedLists.isEmpty {
                emptyStateView
                    .padding(.bottom, tabbarHeight + 50)
            } else {
                mainContentView
            }
        }
        .preferredColorScheme(.dark)
        .navigationTitle(String(localized: "My Travel Lists"))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(String(localized: "New List")) {
                    createListState.toggle()
                }
            }
        })
        .sheet(isPresented: $createListState) {
            AddListView(isUpdate: false)
                .presentationDragIndicator(.visible)
        }
        .confirmationDialog(
            String(localized: "Delete List?"),
            isPresented: $warningDialog,
            titleVisibility: .visible
        ) {
            deleteConfirmationButtons
        } message: {
            Text(String(localized: "All locations in this list will be deleted. This action cannot be undone."))
        }
        .alert(
            String(localized: "List Deleted"),
            isPresented: $resultAlert
        ) {
            Button(String(localized: "OK"), role: .cancel) {}
        } message: {
            Text(String(localized: "The list was successfully deleted."))
        }
    }
    
    private var mainContentView: some View {
        List {
            ForEach(visitedManager.visitedLists) { item in
                
                VisitedRowView(item: item) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    router.navigate(to: .visitedDetail(item))
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .contextMenu {
                    deleteButton(for: item)
                    detailButton(for: item)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    deleteButton(for: item, showText: false)
                    detailButton(for: item, showText: false)
                }
            }
               
            Color.clear.frame(height: tabbarHeight)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)


        }.scrollContentBackground(.hidden)
            .background(.clear)
            .refreshable {
                visitedManager.fetchVisitedList()
            }
            .padding(.top, 40)
            .listStyle(.plain)
    }
    
    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.astronot,
            title: String(localized: "Your Travel Lists Await"),
            buttonTitle: String(localized: "Create First List"),
            message: String(localized: "Organize your adventures! Create lists for different trips, add locations you've visited or want to explore, and track your travel memories all in one place."),
            textColor: .appTextLight,
            buttonBackground: .appGreenPrimary,
            buttonForeground: .appTextLight
        ) {
            createListState = true
        }
    }
    
    private var addNewListButton: some View {
        Button {
            createListState = true
        } label: {
            Text(String(localized: "Add New List"))
                .font(.poppins(.medium, size: .headline))
                .foregroundStyle(.appTextLight)
                .padding()
                .padding(.horizontal)
                .background(
                    Color.appGreenPrimary,
                    in: RoundedRectangle(cornerRadius: 16)
                )
        }
        .padding(.bottom, 30)
    }
    
    private func deleteButton(for item: VisitedList, showText: Bool = true) -> some View {
        Button(role: .destructive) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

            willDeleteItem = item
            warningDialog = true

        } label: {
            Label {
                if showText {
                    Text(String(localized: "Delete the \(item.name) list"))
                }
            } icon: {
                Image(systemName: AppIcons.trash)
            }
        }
        .tint(.red)
    }
    
    private func detailButton(for item: VisitedList, showText: Bool = true) -> some View {
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

            router.navigate(to: .visitedDetail(item))

        } label: {
            Label {
                if showText {
                    Text(String(localized: "Detail"))
                }
            } icon: {
                Image(systemName: AppIcons.cityDetail)
            }
        }
        .tint(.blue)
    }
    
    private var deleteConfirmationButtons: some View {
        Group {
            Button(String(localized: "Delete"), role: .destructive) {
                performDeletion()
            }
            Button(String(localized: "Cancel"), role: .cancel) {}
        }
    }
    
    private func performDeletion() {
        guard let itemToDelete = willDeleteItem else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            let success = visitedManager.deleteList(itemToDelete)
            if success {
                resultAlert = true
            }
        }
        
        willDeleteItem = nil
    }
}

struct VisitedRowView: View {
    let item: VisitedList
    var showDetailIcon: Bool = true
    let onTapGesture: () -> Void

    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: 15) {
                itemIcon
                itemTitle
                Spacer()
                
                if showDetailIcon {
                    chevronIcon
                }
            }
            .foregroundStyle(.black)
            .padding()
            .background(
                Color.appGreenExtraLight,
                in: RoundedRectangle(cornerRadius: 16)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private var itemIcon: some View {
        Image(systemName: item.symbolName)
            .font(.system(size: 25))
            .foregroundStyle(item.color)
    }
    
    private var itemTitle: some View {
        Text(item.name)
            .font(.poppins(.medium, size: .headline))
            .lineLimit(1)
            .multilineTextAlignment(.leading)
    }
    
    private var chevronIcon: some View {
        Image(systemName: AppIcons.chevronRight)
            .font(.system(size: 25))
    }
    
    private func handleTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        onTapGesture()
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    NavigationView {
        VisitedView(tabbarHeight: .constant(100))
            .environment(FavoriteManager())
            .environment(Router())
    }
}
