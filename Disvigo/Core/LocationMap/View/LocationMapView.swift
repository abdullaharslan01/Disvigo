//
//  LocationMapView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import MapKit
import SwiftUI

struct LocationMapView: View {
    @State var position: MapCameraPosition = .automatic

    @State var vm: LocationMapViewModel

    init(location: Location) {
        self._vm = State(wrappedValue: LocationMapViewModel(location: location))
    }

    var body: some View {
        Map(position: $position) {
            Marker(vm.location.title, systemImage: AppIcons.star, coordinate: vm.location.coordinates.clLocationCoordinate2D)
                .tint(.appGreenPrimary)

            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic)).mapControls {
            MapCompass()
            MapPitchToggle()
        }
        .tint(.white)
        .navigationTitle(vm.location.title)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .onAppear {
            focusOnLocation()
        }
        .overlay(alignment: .bottom) {
            bottomButtons
        }
    }

    private var bottomButtons: some View {
        VStack(spacing: 15) {
            VStack(spacing: 15) {
                DIconButtonView(iconButtonType: .location, iconColor: .appTextLight, bgMaterial: .ultraThinMaterial) {
                    focusOnLocation()
                }

                DIconButtonView(iconButtonType: .user, iconColor: .appTextLight, bgMaterial: .ultraThinMaterial) {
                    vm.focusOnUser()
                }
            }.frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)

            DLabelButtonView(title: Strings.getDirections) {
                vm.showMapSelectionSheet = true
            }
        }.confirmationDialog(
            Strings.mapSelectionTitle,
            isPresented: $vm.showMapSelectionSheet,
            actions: {
                Group {
                    Button(Strings.appleMaps) {
                        MapManager.shared.openInAppleMaps(
                            coordinate: vm.location.coordinates.clLocationCoordinate2D,
                            name: vm.location.title
                        )
                    }

                    if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                        Button(Strings.googleMaps) {
                            MapManager.shared.openInGoogleMaps(
                                coordinate: vm.location.coordinates.clLocationCoordinate2D,
                                name: vm.location.title
                            )
                        }
                    }

                    if UIApplication.shared.canOpenURL(URL(string: "yandexmaps://")!) {
                        Button(Strings.yandexMaps) {
                            MapManager.shared.openInYandexMaps(
                                coordinate: vm.location.coordinates.clLocationCoordinate2D,
                                name: vm.location.title
                            )
                        }
                    }

                    Button(Strings.cancel, role: .cancel) {}
                }
            }
        ) {
            Text(Strings.chooseMapApp)
        }.alert(isPresented: $vm.permissionAlertStatus) {
            DAlertType.locationPermission {
                vm.openMapsForPermission()
            }.build()
        }.onChange(of: vm.focusOnUserState) {
            focusOnUser()
        }
    }

    private func focusOnLocation() {
        withAnimation {
            position = .camera(
                MapCamera(
                    centerCoordinate: vm.location.coordinates.clLocationCoordinate2D,
                    distance: 1000,
                    heading: 0,
                    pitch: 40
                )
            )
        }
    }

    private func focusOnUser() {
        print("Focus on User worked")
        guard let userLocation = vm.getUserLocation() else { return }
        withAnimation {
            position = .region(.init(center: userLocation.clLocationCoordinate2D, latitudinalMeters: 350, longitudinalMeters: 350))
        }
    }
}

extension LocationMapView {
    private enum Strings {
        static let getDirections = String(localized: "Get Directions", comment: "Button title for getting directions")
        static let mapSelectionTitle = String(localized: "Select Map App", comment: "Title for map selection dialog")
        static let chooseMapApp = String(localized: "Choose a map app for directions", comment: "Message for map selection dialog")
        static let appleMaps = String(localized: "Apple Maps", comment: "Apple Maps option")
        static let googleMaps = String(localized: "Google Maps", comment: "Google Maps option")
        static let yandexMaps = String(localized: "Yandex Maps", comment: "Yandex Maps option")
        static let cancel = String(localized: "Cancel", comment: "Cancel button title")
    }
}

#Preview {
    NavigationStack {
        LocationMapView(location: DeveloperPreview.shared.location)
    }
}
