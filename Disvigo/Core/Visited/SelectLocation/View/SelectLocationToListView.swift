//
//  SelectLocationToListView.swift
//  Disvigo
//
//  Created by abdullah on 02.06.2025.
//

import SwiftUI

struct SelectLocationToListView: View {
    var locations: [Location]
    var onLocationsAdded: ((Bool) -> Void)?

    @State private var selectedItems = Set<Location.ID>()
    @State private var showAddLocationSheet = false
    @State private var rotations: [Location.ID: Double] = [:]

    @Environment(GemineViewStateController.self) private var gemine
    @Environment(Router.self) var router
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackgroundDark.ignoresSafeArea()

                VStack(spacing: 20) {
                    if !locations.isEmpty {
                        selectionControlView
                        locationsList
                    } else {
                        emptyStateView
                            .padding(.bottom, 50)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Select Locations")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(String(localized: "Cancel")) {
                        dismiss()
                    }
                    .foregroundColor(.appTextLight)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(String(localized: "Add to List")) {
                        showAddLocationSheet = true
                    }
                    .foregroundColor(!selectedItems.isEmpty ? .appGreenPrimary : .gray)
                    .disabled(selectedItems.isEmpty)
                }
            }
            .onAppear {
                gemine.isVisible = .hidden
                for location in locations {
                    rotations[location.id] = 0
                }
            }
            .sheet(isPresented: $showAddLocationSheet) {
                AddLocationListView(locations: getSelectedLocations()) { allAdded, notAddedLocationIds in
                    if allAdded {
                        onLocationsAdded?(true)
                        dismiss()
                    } else {
                        selectedItems = notAddedLocationIds

                        for locationId in notAddedLocationIds {
                            rotations[locationId] = (rotations[locationId] ?? 0) + 360
                        }
                    }
                }
                .presentationDragIndicator(.visible)
            }
        }
    }

    private var selectionControlView: some View {
        HStack(spacing: 16) {
            selectAllButton
            selectionCounterView
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }

    private var selectAllButton: some View {
        DSelectAllButton(isAllSelected: isAllSelected) {
            toggleAllSelection()
        }
    }

    private var selectionCounterView: some View {
        HStack(spacing: 4) {
            Text("\(selectedItems.count)")
                .frame(width: 30)
                .contentTransition(.numericText())
            Text("/")
            Text("\(locations.count)")
                .frame(width: 30)
            Text("selected")
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
        }
        .listStyle(.plain)
        .background(.clear)
        .scrollContentBackground(.hidden)
    }

    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.walkingPerson,
            title: "No Locations Available",
            buttonTitle: "Go Back",
            message: "There are no locations to select from. Please add some locations first.",
            textColor: .appTextLight,
            buttonBackground: .appGreenPrimary,
            buttonForeground: .appTextLight
        ) {
            dismiss()
        }
    }

    private var isAllSelected: Bool {
        !selectedItems.isEmpty && selectedItems.count == locations.count
    }

    private func toggleSelection(for locationId: Location.ID) {
        withAnimation(.easeInOut(duration: 0.5)) {
            if selectedItems.contains(locationId) {
                selectedItems.remove(locationId)
            } else {
                selectedItems.insert(locationId)
            }
            // Update rotation for animation
            rotations[locationId] = (rotations[locationId] ?? 0) + 360
        }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    private func toggleAllSelection() {
        withAnimation(.easeInOut(duration: 0.3)) {
            if isAllSelected {
                selectedItems.removeAll()
            } else {
                selectedItems = Set(locations.map(\.id))
                // Update rotations for all items
                for location in locations {
                    rotations[location.id] = (rotations[location.id] ?? 0) + 360
                }
            }
        }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    private func getSelectedLocations() -> [Location] {
        return locations.filter { location in
            selectedItems.contains(location.id)
        }
    }
}

#Preview {
    SelectLocationToListView(locations: DeveloperPreview.shared.locations)
        .environment(Router())
        .environment(GemineViewStateController())
}
