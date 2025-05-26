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

    @State var alertState: Bool = false

    @Environment(Router.self) var router

    var body: some View {
        ZStack {
            Color.appTextSecondary.opacity(0.4).ignoresSafeArea()

            VStack(spacing: 25) {
                headerView

                contentView
            }
        }
        .alert(isPresented: $alertState) {
            Alert(
                title: Text(String(localized: "No Locations Selected")),
                message: Text(String(localized: "Please select at least two locations to create a route"))
            )
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
                Label(String("Create a route"), systemImage: AppIcons.personWalking)
                    .padding()
                    .background(.appGreenPrimary, in: RoundedRectangle(cornerRadius: 16))
                    .foregroundStyle(.appTextLight)
                    .font(.poppins(.medium, size: .callout))
                    .opacity(locations.isEmpty ? 0.7 : 1)
            }.disabled(locations.isEmpty)
        }
        .padding(.horizontal,30)
        .padding(.top, 30)
    }

    private var contentView: some View {
        ZStack {
            if !locations.isEmpty {
                VStack(spacing: 20) {
                    infoView
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

            Text(String(localized: "Please select the locations you want to add to your route"))
                .font(.poppins(.regular, size: .callout))
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }

    private var locationsList: some View {
        List(locations, id: \.id, selection: $selectedItems) { location in
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
        locations: DeveloperPreview.shared.locations,
    )
    .environment(Router())
}
