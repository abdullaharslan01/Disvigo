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

    @State var countsDown: Bool = false

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
                }.onChange(of: vm.focusOnUserState) {
                    focusOnUser()
                }

        }.preferredColorScheme(.dark)
            .navigationTitle(vm.city.name)
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $vm.permissionAlertType, content: { type in
                DAlertType.locationPermission(permissionAlertType: type) {
                    vm.openMapsForPermission()
                }.build()

            })
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
        HStack(alignment: .bottom, spacing: 30) {
            HStack(spacing: 20) {
                DIconButtonView(iconButtonType: .custom(AppIcons.jumpFirst), iconColor: .accent, bgMaterial: .ultraThinMaterial) {
                    jum(to: .forward)
                }
                VStack(spacing: 0) {
                    Text("\(vm.currentPageIndex + 1)")
                        .frame(width: 50)
                        .contentTransition(.numericText(countsDown: countsDown))

                    Divider()

                    Text("\(vm.locationCount)")
                        .frame(width: 50)
                }
                .monospacedDigit()
                .lineLimit(1)
                .font(.poppins(.medium, size: .title2))
                .padding(5)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                DIconButtonView(iconButtonType: .custom(AppIcons.jumpEnd), iconColor: .accent, bgMaterial: .ultraThinMaterial) {
                    jum(to: .bakcward)
                }
            }

            Spacer()

            VStack(spacing: 20) {
                DIconButtonView(iconButtonType: .custom(AppIcons.sort), iconColor: .yellow, bgMaterial: .ultraThinMaterial) {
                    vm.requestForSortLocations()
                }

                DIconButtonView(iconButtonType: .user, iconColor: .mint, bgMaterial: .ultraThinMaterial) {
                    vm.requestForFocusOnUser()
                }
            }
        }.frame(maxWidth: .infinity)
    }

    private var scrollableLocationCards: some View {
        TabView(selection: $selectedLocation) {
            ForEach(Array(vm.sortedLocations.enumerated()), id: \.element.id) { index, location in
                LocationCardView(location: location, distance: vm.formattedDistance(for: location)) {}
                    .tag(location)
                    .onAppear {
                        withAnimation {
                            countsDown = index < vm.currentPageIndex

                            vm.currentPageIndex = index
                        }
                    }
            }
        }
        .frame(height: 180)
        .tabViewStyle(.page)
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

        UIImpactFeedbackGenerator(style: .light).impactOccurred()

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

    private func jum(to sort: JumState) {
        guard let location = vm.jump(to: sort) else { return }

        withAnimation(.linear(duration: 0.5)) {
            selectedLocation = location
        }
    }
}

#Preview {
    NavigationStack {
        CityMapView(city: DeveloperPreview.shared.city, locations: DeveloperPreview.shared.locations)
    }
}
