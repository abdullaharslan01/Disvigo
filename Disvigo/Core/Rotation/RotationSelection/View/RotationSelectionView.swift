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
    @State private var isViewAppeared = false // View lifecycle tracking

    @Environment(Router.self) var router

    // MARK: - Constants

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
        .refreshable {
            // Force refresh selection state
            await refreshSelectionState()
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

    private var selectionBinding: Binding<Set<Location.ID>> {
        Binding(
            get: {
                selectedItems
            },
            set: { newValue in
                // Selection güncellenmesini optimize et
                if newValue.count <= maxSelectionLimit {
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            selectedItems = newValue
                        }
                    }
                } else {
                    // Limit aşıldığında eski selection'ı koru ve alert göster
                    DispatchQueue.main.async {
                        showLimitAlert = true
                    }
                }
            }
        )
    }

    private func setupInitialState() {
        editMode = .active
        isViewAppeared = true
        
        // Eğer selection state problemi devam ederse bu kısmı aktif et
        if !selectedItems.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let currentSelection = selectedItems
                withAnimation(.none) {
                    selectedItems = Set<Location.ID>()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedItems = currentSelection
                    }
                }
            }
        }
    }

    private func handleSelectionChange(_ newSelection: Set<Location.ID>) {
        if newSelection.count > maxSelectionLimit {
            let limitedSelection = Set(Array(newSelection).prefix(maxSelectionLimit))
            
            DispatchQueue.main.async {
                selectedItems = limitedSelection
            }
            showLimitAlert = true
        }

        if newSelection.count != previousSelectionCount {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            previousSelectionCount = newSelection.count
        }
    }

    private func updateSelection(_ newValue: Set<Location.ID>) {
        if newValue.count <= maxSelectionLimit {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedItems = newValue
            }
        } else {
            showLimitAlert = true
        }
    }

    private func toggleAllSelection() {
        withAnimation(.easeInOut(duration: 0.3)) {
            if isAllSelected {
                selectedItems.removeAll()
            } else {
                let selectableLocations = locations.prefix(maxSelectionLimit)
                selectedItems = Set(selectableLocations.map(\.id))
            }
        }
        
        // Force UI refresh
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            editMode = .inactive
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                editMode = .active
            }
        }
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
    private func refreshSelectionState() async {
        let currentSelection = selectedItems
        
        withAnimation(.none) {
            selectedItems = Set<Location.ID>()
        }
        
        try? await Task.sleep(nanoseconds: 50_000_000) // 0.05 seconds
        
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedItems = currentSelection
        }
    }
}

#Preview {
    RotationSelectionView(locations: tempLocations)
        .environment(Router())
}

// MARK: - Preview Data

private var tempLocations: [Location] {
    Array(0 ..< 60).map { index in
        Location(
            title: "Location \(index + 1)",
            description: "Test description \(index + 1)",
            images: [],
            coordinates: .init(
                latitude: 37.0 + Double(index) * 0.001,
                longitude: 35.0 + Double(index) * 0.001
            )
        )
    }
}
