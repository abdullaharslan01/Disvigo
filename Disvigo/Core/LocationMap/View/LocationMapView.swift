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
    @State var showMapSelectionSheet = false

    let location: Location
    var body: some View {
        Map(position: $position) {
            Marker(location.title, systemImage: AppIcons.star, coordinate: location.coordinates.clLocationCoordinate2D)
                .tint(.appGreenPrimary)

            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic)).mapControls {
            MapCompass()
            MapPitchToggle()
        }
        .tint(.white)
        .navigationTitle(location.title)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .onAppear {
            position = .camera(
                MapCamera(
                    centerCoordinate: location.coordinates.clLocationCoordinate2D,
                    distance: 900,
                    heading: 0,
                    pitch: 40
                )
            )
        }
        .overlay(alignment: .bottom) {
            bottomButtons
        }
    }

    private var bottomButtons: some View {
        VStack {
            DUserLocationButtonView {}.frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

            DLabelButtonView(title: Strings.getDirections) {
                showMapSelectionSheet = true
            }
        }.confirmationDialog(
            Strings.mapSelectionTitle,
            isPresented: $showMapSelectionSheet,
            actions: {
                Group {
                    Button(Strings.appleMaps) {
                        MapManager.shared.openInAppleMaps(
                            coordinate: location.coordinates.clLocationCoordinate2D,
                            name: location.title
                        )
                    }

                    if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                        Button(Strings.googleMaps) {
                            MapManager.shared.openInGoogleMaps(
                                coordinate: location.coordinates.clLocationCoordinate2D,
                                name: location.title
                            )
                        }
                    }

                    if UIApplication.shared.canOpenURL(URL(string: "yandexmaps://")!) {
                        Button(Strings.yandexMaps) {
                            MapManager.shared.openInYandexMaps(
                                coordinate: location.coordinates.clLocationCoordinate2D,
                                name: location.title
                            )
                        }
                    }

                    Button(Strings.cancel, role: .cancel) {}
                }
            }
        ) {
            Text(Strings.chooseMapApp)
        }
    }
}

extension LocationMapView {
    private enum Strings {
        static let getDirections = String(localized: "Get Directions",
                                          comment: "Button title for getting directions")
        static let mapSelectionTitle = String(localized: "Select Map App",
                                              comment: "Title for map selection dialog")
        static let chooseMapApp = String(localized: "Choose a map app for directions",
                                         comment: "Message for map selection dialog")
        static let appleMaps = String(localized: "Apple Maps",
                                      comment: "Apple Maps option")
        static let googleMaps = String(localized: "Google Maps",
                                       comment: "Google Maps option")
        static let yandexMaps = String(localized: "Yandex Maps",
                                       comment: "Yandex Maps option")
        static let cancel = String(localized: "Cancel",
                                   comment: "Cancel button title")
    }
}

#Preview {
    NavigationStack {
        LocationMapView(location: DeveloperPreview.shared.location)
    }
}
