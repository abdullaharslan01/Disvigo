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
    @State private var showMinSelectionAlert = false
    @State private var showLimitAlert = false
    @State private var previousSelectionCount = 0
    @State private var isViewAppeared = false
    @State private var rotations: [Location.ID: Double] = [:]

    @Environment(GemineViewStateController.self) private var gemine
    @Environment(Router.self) var router

    private let maxSelectionLimit = 50
    private let minSelectionLimit = 2

    var body: some View {
        ZStack {
            Color.appTextSecondary.opacity(0.4).ignoresSafeArea()

            VStack(spacing: 25) {
                contentView
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(String(localized: "Cancel")) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    router.navigateBack()
                }
                .foregroundColor(.appTextLight)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(String(localized: "Create a route")) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    createRouteAction()
                }
                .foregroundColor(!selectedItems.isEmpty ? .appGreenPrimary : .gray)
                .disabled(selectedItems.isEmpty)
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
        .onChange(of: selectedItems) { oldValue, newSelection in
            handleSelectionChange(oldValue: oldValue, newSelection: newSelection)
        }
        .onAppear {
            gemine.isVisible = .hidden
            setupInitialState()
        }
        .onDisappear {
            isViewAppeared = false
        }
    }

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
                    .padding(.bottom, 50)
                    .padding(.horizontal)
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
        DSelectAllButton(isAllSelected: isAllSelected) {
            toggleAllSelection()
        }
    }

    private var selectionCounterView: some View {
        HStack(spacing: 2) {
            Text("\(selectedItems.count)")
                .frame(width: 30)
                .contentTransition(.numericText(countsDown: selectedItems.count < previousSelectionCount))
                .animation(.easeInOut(duration: 0.3), value: selectedItems.count)

            Text("/")

            Text("\(maxSelectionLimit)")
                .frame(width: 30)
        }
        .foregroundColor(.secondary)
        .font(.poppins(.medium, size: .body))
    }

    private var locationsList: some View {
        List(locations, id: \.id) { location in
            LocationRowWithCheckbox(
                location: location,
                isSelected: selectedItems.contains(location.id),
                rotation: rotations[location.id] ?? 0
            ) {
                toggleSelection(for: location.id)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    router.navigate(to: .locationDetail(location))
                } label: {
                    Label(String(localized: "Detail"), systemImage: AppIcons.locationDetail)
                }.tint(.blue)
            }
            .contextMenu {
                DLabelButtonView(systemImage: AppIcons.locationDetail, title: String(localized: "Go to Detail")) {
                    router.navigate(to: .locationDetail(location))
                }
            }
        }
        .listStyle(.plain)
        .background(.clear)
        .scrollContentBackground(.hidden)
        .onAppear {
            for location in locations {
                if rotations[location.id] == nil {
                    rotations[location.id] = 0
                }
            }
        }
    }

    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.walkingPerson,
            title: "Unable to create route",
            buttonTitle: "Explore Now",
            message: "You need at least two cities to generate a route. You can do this by adding at least two cities to your favorites.",
            textColor: .appTextLight,
            buttonBackground: .appGreenPrimary,
            buttonForeground: .appTextLight
        ) {
            router.navigateBack()
        }
    }

    private var isAllSelected: Bool {
        !selectedItems.isEmpty && selectedItems.count == min(locations.count, maxSelectionLimit)
    }

    private func setupInitialState() {
        isViewAppeared = true
        previousSelectionCount = selectedItems.count

        // Initialize rotations
        for location in locations {
            rotations[location.id] = 0
        }
    }

    private func handleSelectionChange(oldValue: Set<Location.ID>, newSelection: Set<Location.ID>) {
        // Update previous count for countdown animation
        previousSelectionCount = oldValue.count

        if newSelection.count > maxSelectionLimit {
            let limitedSelection = Set(Array(newSelection).prefix(maxSelectionLimit))
            selectedItems = limitedSelection
            showLimitAlert = true
        }

        if newSelection.count != oldValue.count {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }

    private func toggleSelection(for locationId: Location.ID) {
        withAnimation(.easeInOut(duration: 0.5)) {
            if selectedItems.contains(locationId) {
                selectedItems.remove(locationId)
            } else {
                if selectedItems.count < maxSelectionLimit {
                    selectedItems.insert(locationId)
                } else {
                    showLimitAlert = true
                    return
                }
            }

            rotations[locationId] = (rotations[locationId] ?? 0) + 360
        }

        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    private func toggleAllSelection() {
        withAnimation(.easeInOut(duration: 0.3)) {
            if isAllSelected {
                selectedItems.removeAll()
            } else {
                let selectableLocations = locations.prefix(maxSelectionLimit)
                selectedItems = Set(selectableLocations.map(\.id))

                for location in selectableLocations {
                    rotations[location.id] = (rotations[location.id] ?? 0) + 360
                }
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
}

#Preview {
    NavigationStack {
        RotationSelectionView(locations: DeveloperPreview.shared.locations)
            .environment(Router())
            .environment(GemineViewStateController())
    }
}
