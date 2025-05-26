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
    @State private var alertState: Bool = false
    @State private var showLimitAlert: Bool = false
    @State private var allSelected: Bool = false
    
    @State private var previousSelectionCount: Int = 0
    
   

    @Environment(Router.self) var router

    var body: some View {
        ZStack {
            Color.appTextSecondary.opacity(0.4).ignoresSafeArea()

            VStack(spacing: 25) {
                headerView
                contentView
            }
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $alertState) {
            Alert(
                title: Text(String(localized: "No Locations Selected")),
                message: Text(String(localized: "Please select at least two locations to create a route"))
            )
        }
        .alert(isPresented: $showLimitAlert) {
            Alert(
                title: Text(String(localized: "Selection Limit")),
                message: Text(String(localized: "You can select up to 50 locations only."))
            )
        }
        .onChange(of: selectedItems) { _, newSelection in
            if newSelection.count > 50 {
                withAnimation {
                    selectedItems = Set(newSelection.prefix(50))
                    showLimitAlert = true
                }
            }
        }.onChange(of: selectedItems.count) { oldValue, newValue in
            previousSelectionCount = selectedItems.count
        }
    }

    private var headerView: some View {
        HStack {
            DIconButtonView(iconButtonType: .custom(AppIcons.xmark), iconColor: .appTextLight, bgColor: .red) {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                router.navigateBack()
            }

            Spacer()

            Button {
                createRouteAction()
            } label: {
                Label(String(localized: "Create a route"), systemImage: AppIcons.personWalking)
                    .padding()
                    .symbolEffect(.pulse, isActive: true)
                    .background(.appGreenPrimary, in: RoundedRectangle(cornerRadius: 16))
                    .foregroundStyle(.appTextLight)
                    .font(.poppins(.medium, size: .callout))
                    .opacity(locations.isEmpty ? 0.7 : 1)
            }
            .disabled(locations.isEmpty)
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }

    private var contentView: some View {
        ZStack {
            if !locations.isEmpty {
                VStack(spacing: 20) {
                    infoView
                    selectAll
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

            Text(String(localized: "You can select up to 50 locations to create a route. Please select the locations you want to include."))
                .font(.poppins(.regular, size: .callout))
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }

    private var selectAll: some View {
        HStack(spacing: 16) {
            DIconButtonView(iconButtonType: .custom(allSelected ? AppIcons.unCheckedAllList : AppIcons.checkedAllList), fontSize: .body) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                toggleSelection()
            }

            selectionCounterView

            Spacer()
        }
        .padding(.horizontal, 30)
    }

    private var selectionCounterView: some View {
        HStack(spacing: 2) {
            Text("\(selectedItems.count)")
                .frame(width: 30)
                .contentTransition(.numericText(countsDown: selectedItems.count < previousSelectionCount))

            Text("/")

            Text("50")
                .frame(width: 30)
        }
        .foregroundColor(.secondary)
        .font(.poppins(.medium, size: .body))
    }

    private var locationsList: some View {
        List(locations, id: \.id, selection: Binding(
            get: { selectedItems },
            set: { newValue in
                if newValue.count <= 50 {
                    withAnimation {
                        selectedItems = newValue
                    }

                } else {
                    showLimitAlert = true
                }
            }
        )) { location in
            RotationSelectionRowView(location: location)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .environment(\.editMode, $editMode)
        .listStyle(.plain)
        .background(.clear)
        .scrollContentBackground(.hidden)
    }

    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.walkingPerson,
            title: String(localized: "Unable to create route"),
            buttonTitle: String(localized: "Explore Now", comment: "Button to explore places"),
            message: String(localized: "You need at least two cities to generate a route. You can do this by adding at least two cities to your favorites.")
        ) {
            router.navigateBack()
        }
    }

    private func toggleSelection() {
        withAnimation {
            if allSelected {
                selectedItems.removeAll()
                allSelected = false
            } else {
                let first50 = locations.prefix(50)
                selectedItems = Set(first50.map { $0.id })
                allSelected = true
            }
        }
    }

    private func createRouteAction() {
        if selectedItems.count < 2 {
            alertState.toggle()
        } else {
            let selectedLocationList = locations.filter { location in
                selectedItems.contains(location.id)
            }

            router.navigate(to: .rotationDetail(selectedLocationList))
        }
    }
}

#Preview {
    RotationSelectionView(
        locations: temptLocation
    )
    .environment(Router())
}

var temptLocation: [Location] {
    return Array(0 ..< 60).map { index in
        Location(
            title: "Location \(index + 1)",
            description: "Test description \(index + 1)",
            images: [],
            coordinates: .init(latitude: 37.0 + Double(index) * 0.001, longitude: 35.0 + Double(index) * 0.001)
        )
    }
}
