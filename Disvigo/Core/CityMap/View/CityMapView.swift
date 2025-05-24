//
//  CityMapView.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import MapKit
import SwiftUI

struct CityMapView: View {
    @State var vm: CityMapViewModel

    @State var position: MapCameraPosition = .automatic
    @State var selectedLocation: Location?

    init(city: City, locations: [Location]) {
        self._vm = State(wrappedValue: CityMapViewModel(city: city, locations: locations))
    }

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            locationMap
                .overlay(alignment: .bottom, content: {
                    bottomControls
                })
                .onAppear {
                    focusOnCity()
                }

        }.preferredColorScheme(.dark)
            .navigationTitle(vm.city.name)
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $vm.permissionAlertStatus) {
                DAlertType.locationPermission {
                    vm.openMapsForPermission()
                }.build()
            }.onChange(of: vm.focusOnUserState) {
                focusOnUser()
            }
    }

    var locationMap: some View {
        Map(position: $position, selection: $selectedLocation) {
            ForEach(vm.locations, id: \.title) { location in
                Marker(location.title, systemImage: selectedLocation == location ? AppIcons.starFill : AppIcons.defaultLocation, coordinate: location.coordinates.clLocationCoordinate2D)
                    .tag(location)
                    .tint(selectedLocation == location ? Color.appGreenPrimary : .blue)
            }
            
            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapCompass()
            MapPitchToggle()
        }
    }

    private var bottomControls: some View {
        VStack(spacing: 20) {
            locationButtons
            scrollableLocationCards
        }.padding(.horizontal)
    }

    private var locationButtons: some View {
        VStack {
            DIconButtonView(iconButtonType: .user, iconColor: .appTextLight, bgMaterial: .ultraThinMaterial) {
               focusOnUser()
            }
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }

    private var scrollableLocationCards: some View {
        TabView(selection: $selectedLocation) {
            ForEach(vm.locations) { location in

                LocationCardView(location: location) {}.frame(height: 180)
                    .tag(location)
            }
        }.tabViewStyle(.page)
            .frame(height: 180)
            .animation(.default, value: selectedLocation)
            .onChange(of: selectedLocation) { _, _ in
                focusOnLocation()
            }
    }
    
    
}

extension CityMapView {
    private func focusOnCity() {
        withAnimation {
            position = .region(.init(
                center: vm.city.coordinates.clLocationCoordinate2D,
                latitudinalMeters: 6000,
                longitudinalMeters: 6000
            ))
        }
    }

    private func focusOnLocation() {
        guard let location = selectedLocation else { return }

        withAnimation {
            position = .region(.init(
                center: location.coordinates.clLocationCoordinate2D,
                latitudinalMeters: 700,
                longitudinalMeters: 700
            ))
        }
    }
    
    private func focusOnUser() {
        guard let userLocation = vm.getUserLocation() else { return }
        withAnimation {
            position = .region(.init(center: userLocation.clLocationCoordinate2D, latitudinalMeters: 350, longitudinalMeters: 350))
        }
    }
}

#Preview {
    NavigationStack {
        CityMapView(city: DeveloperPreview.shared.city, locations: DeveloperPreview.shared.locations)
    }
}
