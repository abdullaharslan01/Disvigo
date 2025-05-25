//
//  LocationListView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI

struct LocationListView: View {
 
    init(locations: [Location], cityTitle: String) {
        self._vm = State(wrappedValue: LocationListViewModel(locations: locations, cityTitle: cityTitle))
       
    }
    
    @State var vm: LocationListViewModel
   

    @Environment(Router.self) var router
 

    let columns: [GridItem] = [.init(.flexible()), .init(.flexible())]

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            ScrollView {
                if vm.filteredLocations.isEmpty && !vm.searchText.isEmpty {
                    VStack {
                        Spacer()
                        DEmptyStateView(type: .searchNotFound(title: String(localized: "No locations found in \(vm.cityTitle)"))) {
                            vm.searchText = ""
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity.combined(with: .scale))
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(vm.filteredLocations) { location in
                            LocationListCardView(location: location) {
                                router.navigate(to: .locationDetail(location))
                            }
                            .transition(.scale.combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.3), value: vm.searchText)
                            .scrollTransition { view, phase in
                                view
                                    .scaleEffect(phase.isIdentity ? 1 : 0.7)
                                    .rotationEffect(.degrees(phase.isIdentity ? 0 :-20))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }

        .searchable(text: $vm.searchText, prompt: String(localized: "Search by location within \(vm.cityTitle)..."))
        .navigationTitle(String(localized: "Explore \(vm.cityTitle)"))
        .onChange(of: vm.filteredLocations.count) { oldValue, newValue in
            if oldValue != newValue && !vm.searchText.isEmpty {
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            }
            vm.previousResultCount = newValue
        }
        .animation(.easeInOut(duration: 0.3), value: vm.filteredLocations.isEmpty)
    }
}

#Preview {
    LocationListView(locations: DeveloperPreview.shared.locations, cityTitle: "Adana")
        .environment(Router())
}
