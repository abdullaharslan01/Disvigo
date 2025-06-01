//
//  AddLocationListView.swift
//  Disvigo
//
//  Created by abdullah on 01.06.2025.
//

import SwiftUI

struct AddLocationListView: View {
    var location: Location
    @Environment(FavoriteManager.self) var visitedManager
    
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var addNewListViewState: Bool = false
    @State private var addedState: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackgroundDark.ignoresSafeArea()
                
                if visitedManager.visitedLists.isEmpty {
                    emptyStateView
                } else {
                    mainContextView
                }
            }.navigationTitle(String(localized: "Choose a List"))
                .preferredColorScheme(.dark)
                .alert(alertTitle, isPresented: $showAlert) {
                    Button(String(localized: "OK"), role: .cancel) {
                        if addedState {
                            dismiss()
                        }
                    }
                } message: {
                    Text(alertMessage)
                }.sheet(isPresented: $addNewListViewState) {
                    AddListView(isUpdate: false)
                        .presentationDragIndicator(.visible)
                }
        }
    }
    
    var mainContextView: some View {
        List(visitedManager.visitedLists) { list in
            VisitedRowView(item: list, showDetailIcon: false) {
                addLocationToList(list)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.clear)
        .safeAreaInset(edge: .bottom) {
            addNewListButton
        }
    }
    
    private var emptyStateView: some View {
        DLottieEmtyView(
            lottieName: AppImages.Lottie.astronot,
            title: String(localized: "Your list is empty"),
            buttonTitle: String(localized: "Add New List"),
            message: String(localized: "You need to create a list to add locations."),
            textColor: .appTextLight,
            buttonBackground: .appGreenPrimary,
            buttonForeground: .appTextLight
        ) {
            addNewListViewState.toggle()
        }
        .padding(.bottom, 50)
        .padding(.horizontal)
    }
    
    func addLocationToList(_ visitedList: VisitedList) {
        if visitedList.visitedItems.contains(where: { $0.locationId == location.id }) {
            alertTitle = String(localized: "This location already exists")
            alertMessage = String(localized: "This location has already been added to your list. Please add a different location.")
            addedState = false
        
        } else {
            visitedList.visitedItems.append(VisitedListItem(location: location))
            alertTitle = String(localized: "Success")
            alertMessage = String(localized: "Location has been successfully added to your list.")
            addedState = true
        }
        showAlert = true
    }
    
    private var addNewListButton: some View {
        Button {
            addNewListViewState.toggle()

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
        .padding(.bottom)
    }
}

#Preview {
    AddLocationListView(location: DeveloperPreview.shared.location)
        .environment(FavoriteManager())
}
