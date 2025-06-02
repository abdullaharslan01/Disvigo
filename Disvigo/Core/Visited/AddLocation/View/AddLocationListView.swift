//
//  AddLocationListView.swift
//  Disvigo
//
//  Created by abdullah on 01.06.2025.
//

import SwiftUI

struct AddLocationListView: View {
    var locations: [Location]
    var onCompletion: ((Bool, Set<Location.ID>) -> Void)? 
    
    @Environment(FavoriteManager.self) var visitedManager
    
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var addNewListViewState: Bool = false
    @State private var addedState: Bool = false
    @State private var notAddedLocationIds: Set<Location.ID> = []
    
    init(location: Location, onCompletion: ((Bool, Set<Location.ID>) -> Void)? = nil) {
        self.locations = [location]
        self.onCompletion = onCompletion
    }
    
    init(locations: [Location], onCompletion: ((Bool, Set<Location.ID>) -> Void)? = nil) {
        self.locations = locations
        self.onCompletion = onCompletion
    }
    
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
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(String(localized: "Cancel")) {
                            dismiss()
                        }
                        .foregroundColor(.appTextLight)
                    }
                })
                .preferredColorScheme(.dark)
                .alert(alertTitle, isPresented: $showAlert) {
                    Button(String(localized: "OK"), role: .cancel) {
                        // Alert kapatıldığında completion handler'ı çağır
                        let allAdded = notAddedLocationIds.isEmpty
                        onCompletion?(allAdded, notAddedLocationIds)
                        dismiss()
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
                addLocationsToList(list)
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
    
    func addLocationsToList(_ visitedList: VisitedList) {
        var addedLocations: [String] = []
        var existingLocations: [String] = []
        var existingLocationIds: Set<Location.ID> = []
        
        for location in locations {
            if visitedList.visitedItems.contains(where: { $0.locationId == location.id }) {
                existingLocations.append(location.title)
                existingLocationIds.insert(location.id)
            } else {
                visitedList.visitedItems.append(VisitedListItem(location: location))
                addedLocations.append(location.title)
            }
        }
        
        // Eklenmeyenlerin ID'lerini sakla
        notAddedLocationIds = existingLocationIds
        
        createAlertMessage(addedLocations: addedLocations, existingLocations: existingLocations)
        showAlert = true
    }
    
    private func createAlertMessage(addedLocations: [String], existingLocations: [String]) {
        let hasAdded = !addedLocations.isEmpty
        let hasExisting = !existingLocations.isEmpty
        
        if hasAdded && hasExisting {
            alertTitle = String(localized: "Partially Added")
            
            let addedCount = addedLocations.count
            let addedText = String(localized: "\(addedCount) locations have been added to your list.")
            let existingText = String(localized: "These locations were already in the list and were not added: ") + existingLocations.joined(separator: ", ")
            
            alertMessage = addedText + "\n\n" + existingText
            addedState = true
            
        } else if hasAdded && !hasExisting {
            alertTitle = String(localized: "Success")
            
            if addedLocations.count == 1 {
                alertMessage = String(localized: "Location has been successfully added to your list.")
            } else {
                let addedCount = addedLocations.count
                alertMessage = String(localized: "\(addedCount) locations have been successfully added to your list.")
            }
            addedState = true
            
        } else if !hasAdded && hasExisting {
            alertTitle = String(localized: "Already Exists")
            
            if existingLocations.count == 1 {
                alertMessage = String(localized: "This location already exists in your list.")
            } else {
                let locationNames = existingLocations.joined(separator: ", ")
                alertMessage = String(localized: "These locations already exist in your list and were not added: ") + locationNames
            }
            addedState = false
        }
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
