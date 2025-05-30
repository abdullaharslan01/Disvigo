//
//  RotationSelectionView.swift
//  Disvigo
//
//  Created by abdullah on 26.05.2025.
//

import SwiftUI

struct RotationSelectionView: View {
    var locations: [Location]

    @State private var selectedItems = Set<Location.ID>()
    @State private var editMode: EditMode = .active
    @State private var showMinSelectionAlert = false
    @State private var showLimitAlert = false
    @State private var previousSelectionCount = 0
    @State private var isViewAppeared = false
    @Environment(GemineViewStateController.self) private var gemine

    @Environment(Router.self) var router

    private let maxSelectionLimit = 50
    private let minSelectionLimit = 2

    var body: some View {
        ZStack {
            Color.appTextSecondary.opacity(0.4).ignoresSafeArea()

            VStack(spacing: 25) {
                headerView
                contentView
            }
        }
        .preferredColorScheme(.dark)
        .alert("No Locations Selected", isPresented: $showMinSelectionAlert) {
            Button("OK") {}
        } message: {
            Text("Please select at least \(minSelectionLimit) locations to create a route")
        }
        .alert("Selection Limit", isPresented: $showLimitAlert) {
            Button("OK") {}
        } message: {
            Text("You can select up to \(maxSelectionLimit) locations only.")
        }
        .onChange(of: selectedItems) { _, newSelection in
            handleSelectionChange(newSelection)
        }
        .onAppear {
            gemine.isVisible = .hidden

            setupInitialState()
        }
        .onDisappear {
            isViewAppeared = false
        }
    }

    // MARK: - Header View

    private var headerView: some View {
        HStack {
            closeButton
            Spacer()
            createRouteButton
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }

    private var closeButton: some View {
        DIconButtonView(
            iconButtonType: .custom(AppIcons.xmark),
            iconColor: .appTextLight,
            bgColor: .red
        ) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            router.navigateBack()
        }
    }

    private var createRouteButton: some View {
        Button(action: createRouteAction) {
            Label("Create a route", systemImage: AppIcons.personWalking)
                .padding()
                .symbolEffect(.pulse, isActive: !locations.isEmpty && selectedItems.count >= minSelectionLimit)
                .background(buttonBackgroundColor, in: RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(.appTextLight)
                .font(.poppins(.medium, size: .callout))
        }
        .disabled(locations.isEmpty)
    }

    private var buttonBackgroundColor: Color {
        if locations.isEmpty {
            return .appGreenPrimary.opacity(0.7)
        }
        return selectedItems.count >= minSelectionLimit ? .appGreenPrimary : .appGreenPrimary.opacity(0.7)
    }

    // MARK: - Content View

    private var contentView: some View {
        Group {
            if !locations.isEmpty {
                VStack(spacing: 20) {
                    infoView
                    selectionControlView
                    locationsList
                }
            } else {
                emptyStateView
            }
        }
    }

    private var infoView: some View {
        HStack {
            Image(systemName: AppIcons.infoCircle)
                .font(.title3)
                .foregroundStyle(.blue)

            Text("You can select up to \(maxSelectionLimit) locations to create a route. Please select the locations you want to include.")
                .font(.poppins(.regular, size: .callout))
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }

    private var selectionControlView: some View {
        HStack(spacing: 16) {
            selectAllButton
            selectionCounterView
            Spacer()
        }
        .padding(.horizontal, 30)
    }

    private var selectAllButton: some View {
        DIconButtonView(
            iconButtonType: .custom(isAllSelected ? AppIcons.unCheckedAllList : AppIcons.checkedAllList),
            fontSize: .body
        ) {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            toggleAllSelection()
        }
    }

    private var selectionCounterView: some View {
        HStack(spacing: 2) {
            Text("\(selectedItems.count)")
                .frame(width: 30)
                .contentTransition(.numericText(countsDown: selectedItems.count < previousSelectionCount))

            Text("/")

            Text("\(maxSelectionLimit)")
                .frame(width: 30)
        }
        .foregroundColor(.secondary)
        .font(.poppins(.medium, size: .body))
    }

    private var locationsList: some View {
        List(locations, id: \.id, selection: selectionBinding) { location in
            RotationSelectionRowView(location: location)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .environment(\.editMode, $editMode)
        .listStyle(.plain)
        .background(.clear)
        .scrollContentBackground(.hidden)
        .onAppear {
            refreshSelectionState()
        }
    }

    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.walkingPerson,
            title: "Unable to create route",
            buttonTitle: "Explore Now",
            message: "You need at least two cities to generate a route. You can do this by adding at least two cities to your favorites."
        ) {
            router.navigateBack()
        }
    }

    private var isAllSelected: Bool {
        !selectedItems.isEmpty && selectedItems.count == min(locations.count, maxSelectionLimit)
    }

    // MARK: - Düzeltilmiş Selection Binding

    private var selectionBinding: Binding<Set<Location.ID>> {
        Binding(
            get: {
                selectedItems
            },
            set: { newValue in
                if newValue.count <= maxSelectionLimit {
                    selectedItems = newValue
                } else {
                    showLimitAlert = true
                }
            }
        )
    }

    // MARK: - Düzeltilmiş Setup

    private func setupInitialState() {
        editMode = .active
        isViewAppeared = true
    }

    private func handleSelectionChange(_ newSelection: Set<Location.ID>) {
        if newSelection.count > maxSelectionLimit {
            let limitedSelection = Set(Array(newSelection).prefix(maxSelectionLimit))
            selectedItems = limitedSelection
            showLimitAlert = true
        }

        if newSelection.count != previousSelectionCount {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            previousSelectionCount = newSelection.count
        }
    }

    // MARK: - Düzeltilmiş Toggle All Selection

    private func toggleAllSelection() {
        withAnimation(.easeInOut(duration: 0.3)) {
            if isAllSelected {
                selectedItems.removeAll()
            } else {
                let selectableLocations = locations.prefix(maxSelectionLimit)
                selectedItems = Set(selectableLocations.map(\.id))
            }
        }

        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    private func createRouteAction() {
        guard selectedItems.count >= minSelectionLimit else {
            showMinSelectionAlert = true
            return
        }

        let selectedLocationList = locations.filter { location in
            selectedItems.contains(location.id)
        }

        router.navigate(to: .rotationDetail(selectedLocationList))
    }

    // MARK: - Selection State Helpers

    @MainActor
    private func refreshSelectionState() {
        let currentSelection = selectedItems

        selectedItems = Set<Location.ID>()

        selectedItems = currentSelection
    }
}

#Preview {
    RotationSelectionView(locations: DeveloperPreview.shared.locations)
        .environment(Router())
        .environment(GemineViewStateController())
}
