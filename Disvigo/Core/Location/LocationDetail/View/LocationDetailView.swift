//
//  LocationView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
    @State var vm: LocationDetailViewModel
    
    init(location: Location) {
        self._vm = State(wrappedValue: LocationDetailViewModel(location: location))
    }
    
    @Environment(FavoriteManager.self) var favoriteManager
    @Environment(GemineViewStateController.self) private var gemine

    @Environment(Router.self) var router
    @State private var isFavorite: Bool = false

    @State var mapCameraPosition: MapCameraPosition = .automatic
  
    @State var addToLocationViewState: Bool = false
    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            
            contentView
            
        }.preferredColorScheme(.dark)
            .onAppear {
                gemine.isVisible = .visible
                gemine.gemineViewState = .location(vm.location)
                
                isFavorite = favoriteManager.isLocationFavorite(vm.location)
            }.navigationTitle(vm.location.title)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    var contentView: some View {
        ScrollView {
            VStack {
                imageSection
                detailSection
                    .padding(.horizontal)
                
                mapSection
                    .padding(.bottom, getSafeArea().bottom + 30)
            }
        }.sheet(isPresented: $addToLocationViewState) {
            AddLocationListView(location: vm.location)
                .presentationDragIndicator(.visible)
        }
    }
    
    var imageSection: some View {
        DImageCollageView(images: vm.location.images, height: 350)
            .overlay(alignment: .topTrailing) {
                VStack(spacing: 8) {
                    FavoriteButtonView(isFavorite: $isFavorite) {
                        favoriteManager.toggleLocationFavorite(vm.location)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            let managerState = favoriteManager.isLocationFavorite(vm.location)
                            if isFavorite != managerState {
                                isFavorite = managerState
                            }
                        }
                    }
                    
                    DAddLocationButtonView {
                        addToLocationViewState.toggle()
                    }
                    
                }.padding(.top)
                    .padding(.horizontal)
            }
    }
    
    var detailSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(vm.location.title)
                .font(.poppins(.semiBold, size: .largeTitle))
        
            ExpandableTextView(text: vm.location.description, font: .regular, fontSize: .callout, lineLimit: 10, horizontalPadding: 16)
        
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var mapSection: some View {
        Map(position: $mapCameraPosition) {
            Marker(vm.location.title, coordinate: vm.location.coordinates.clLocationCoordinate2D)
                .tint(.appGreenPrimary)
        }
        .mapStyle(.standard(elevation: .realistic))
        .frame(height: 300)
        .overlay(alignment: .bottom) {
            DLabelButtonView(title: String(localized: "View On Map"), onTap: {
                router.navigate(to: .locationMap(vm.location))
            })
            .padding(.bottom, 20)
        }
        .onAppear(perform: startRotation)
        .onDisappear(perform: stopRotation)
    }
    
    private func startRotation() {
        vm.rotationTimer = Timer.scheduledTimer(
            withTimeInterval: 0.01,
            repeats: true
        ) { _ in

            DispatchQueue.main.async {
                updateCameraPosition()
            }
        }

        RunLoop.current.add(vm.rotationTimer!, forMode: .common)
    }

    private func stopRotation() {
        vm.rotationTimer?.invalidate()
    }
    
    func updateCameraPosition() {
        vm.rotationAngle = (vm.rotationAngle + 0.08)
            .truncatingRemainder(dividingBy: 360)

        mapCameraPosition = .camera(
            MapCamera(
                centerCoordinate: vm.location.coordinates.clLocationCoordinate2D,
                distance: 400,
                heading: vm.rotationAngle,
                pitch: 60
            )
        )
    }
}

#Preview {
    NavigationStack {
        LocationDetailView(location: DeveloperPreview.shared.location)
            .environment(Router())
            .environment(FavoriteManager())
    }
}
