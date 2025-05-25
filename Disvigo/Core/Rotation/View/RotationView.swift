//
//  RotationView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import MapKit
import SwiftUI

struct RotationView: View {
    var stops: [Location]

    @State private var locationManager = RotationLocationManager()
    @State private var position: MapCameraPosition = .automatic
    @State private var routeCoordinates: [CLLocationCoordinate2D] = []
    @State private var travelTime: TimeInterval = 0
    @State private var totalDistance: CLLocationDistance = 0

    @State private var showMapSelectionSheet = false

    @Namespace var animation
    @State private var selectedMode: TravelMode = .walking

    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.55
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0

    // @Environment(Router.self) var router

    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .bottom) {
                Map(position: $position) {
                    ForEach(stops) { stop in

                        Marker(stop.title, systemImage: AppIcons.star, coordinate: stop.coordinates.clLocationCoordinate2D)
                            .tint(.appGreenLight)
                            .tag(stop)
                    }

                    if let userLocation = locationManager.userLocation {
                        Marker(String(localized: "You"), systemImage: AppIcons.personFill, coordinate: userLocation)
                            .tint(.red)
                    }

                    MapPolyline(coordinates: routeCoordinates)
                        .stroke(.blue, lineWidth: 4)
                }
                .onAppear(perform: {
                    locationManager.requestLocation()
                    updateRoute()
                })
                .onChange(of: locationManager.userLocationReady) { _, newValue in
                    if newValue {
                        updateRoute()
                    }
                }

                .onChange(of: selectedMode) { _, _ in
                    updateRoute()
                }
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    viewOnMapButton
                        .padding(.horizontal)
                }
                VStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                        .padding(.bottom, 10)

                    rotationInfoView
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 10)
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }

                        }.onEnded { _ in

                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                    currentDragOffsetY = 0
                                }
                                else if endingOffsetY != 0, currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                    currentDragOffsetY = 0
                                }

                                currentDragOffsetY = 0
                            }
                        }
                )
            }
            .preferredColorScheme(.dark)
        }.ignoresSafeArea(edges: [.bottom])
            .confirmationDialog(
                String(localized: "Select Map App",
                       comment: "Title for map selection dialog"),
                isPresented: $showMapSelectionSheet,
                actions: {
                    Group {
                        Button(String(localized: "Apple Maps",
                                      comment: "Apple Maps option"))
                        {
                            MapManager.shared.openRouteInAppleMaps(
                                stops: stops, mode: selectedMode
                            )
                        }

                        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                            Button(String(localized: "Google Maps",
                                          comment: "Google Maps option"))
                            {
                                MapManager.shared.openRouteInGoogleMaps(
                                    stops: stops,
                                    mode: selectedMode
                                )
                            }
                        }

                        Button(String(localized: "Cancel",
                                      comment: "Cancel button title"), role: .cancel) {}
                    }
                }
            ) {
                Text(String(localized: "Choose a map app for directions",
                            comment: "Message for map selection dialog"))
            }
    }

    private func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return hours > 0 ? "\(hours) \(String(localized: "h")) \(remainingMinutes) \(String(localized: "min"))" : "\(remainingMinutes) \(String(localized: "min"))"
    }

    private var viewOnMapButton: some View {
        DLabelButtonView(systemImage: AppIcons.locationSquare, title: String(localized: "Get Directions")) {
            showMapSelectionSheet.toggle()
        }
    }

    private var rotationInfoView: some View {
        VStack(spacing: 25) {
            TravelModeView(selectedMode: $selectedMode, animation: animation)

            VStack(spacing: 15) {
                LabeledContent(String(localized: "Total Distance"), value: "\(String(format: "%.2f", totalDistance / 1000)) km")
                LabeledContent(String(localized: "Estimated Time"), value: "\(formattedTime(travelTime))")
            }

            List {
                ForEach(Array(stops.enumerated()), id: \ .offset) { index, item in
                    RouteStopRowView(index: index, stop: item, userLocation: locationManager.userLocation)
                        .contextMenu {
                            Button {} label: {
                                Label(String(localized: "Go to Detail"), systemImage: selectedMode.iconName)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                }
            }

            .background(.clear)
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }

    private func updateRoute() {
        guard let userLocation = locationManager.userLocation else { return }

        position = .region(MKCoordinateRegion(
            center: userLocation,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        ))

        calculateRoute(from: userLocation)
    }

    private func calculateRoute(from start: CLLocationCoordinate2D) {
        routeCoordinates = []
        travelTime = 0
        totalDistance = 0

        let destinations = stops.map { $0.coordinates.clLocationCoordinate2D }
        var previous = start

        for destination in destinations {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: previous))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
            request.transportType = selectedMode.transportType

            let directions = MKDirections(request: request)
            directions.calculate { response, _ in
                guard let route = response?.routes.first else { return }

                routeCoordinates.append(contentsOf: route.polyline.coordinates)
                travelTime += route.expectedTravelTime
                totalDistance += route.distance
            }
            previous = destination
        }
    }
}

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

#Preview {
    RotationView(stops: DeveloperPreview.shared.locations)
}
