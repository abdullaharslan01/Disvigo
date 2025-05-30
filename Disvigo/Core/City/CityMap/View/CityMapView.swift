//
//  CityMapView.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import MapKit
import SwiftUI

struct CityMapView: View {
    @Environment(Router.self) var router
    @State var vm: CityMapViewModel

    @Environment(GemineViewStateController.self) private var gemine

    @State var position: MapCameraPosition = .automatic
    @State var selectedLocation: Location?

    @State var countsDown: Bool = false
    @State private var previousSelectedLocation: Location?

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
                    gemine.isVisible = .hidden

                    focusOnCity()
                }.onChange(of: vm.focusOnUserState) {
                    focusOnUser()
                }

        }.preferredColorScheme(.dark)
            .toolbarVisibility(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.requestForSortLocations()

                    } label: {
                        Image(systemName: AppIcons.sort)
                            .foregroundStyle(.yellow)
                    }

                    .contextMenu {
                        Button {
                            vm.requestForSortLocations()

                        } label: {
                            Label(String(localized: "Orders locations by proximity."), systemImage: AppIcons.sort)
                        }
                    }
                }
            }
            .navigationTitle(vm.city.name)
            .navigationBarTitleDisplayMode(.inline)
            .alert(String(localized: "Already Sorted"), isPresented: $vm.sortedAlertMessage) {
                Button("OK") {}
            } message: {
                Text(String(localized: "The locations in \(vm.city.name) city are already ordered by proximity to you."))
            }

            .alert(item: $vm.permissionAlertType, content: { type in
                DAlertType.locationPermission(permissionAlertType: type) {
                    vm.openMapsForPermission()
                }.build()

            })
    }

    var locationMap: some View {
        Map(position: $position, selection: $selectedLocation) {
            ForEach(vm.locations, id: \.title) { location in

                Annotation(coordinate: location.coordinates.clLocationCoordinate2D) {
                    DImageLoaderView(url: location.images.first ?? "", contentMode: .fill)
                        .clipShape(.circle)
                        .frame(width: location == selectedLocation ? 70 : 35, height: location == selectedLocation ? 70 : 35)
                        .contextMenu {
                            DLabelButtonView(systemImage: AppIcons.locationDetail, title: String(localized: "Go to Detail")) {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()

                                router.navigate(to: .locationDetail(location))
                            }
                        }
                        .transition(.scale.combined(with: .opacity))

                } label: {
                    Text(location.title)
                }.tag(location)
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
                }.contextMenu {
                    Button {
                        jum(to: .forward)

                    } label: {
                        Label(String(localized: "Nearest to you."), systemImage: AppIcons.jumpFirst)
                    }
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
                }.contextMenu {
                    Button {
                        jum(to: .bakcward)
                    } label: {
                        Label(String(localized: "Farthest from you."), systemImage: AppIcons.jumpEnd)
                    }
                }
            }

            Spacer()

            VStack(spacing: 20) {
                DIconButtonView(iconButtonType: .custom(AppIcons.map), iconColor: .cyan, bgMaterial: .ultraThinMaterial) {
                    router.navigate(to: .rotationSelection(vm.locations))
                }
                .contextMenu {
                    Button {
                        router.navigate(to: .rotationSelection(vm.locations))

                    } label: {
                        Label(String(localized: "Create route from selected locations."), systemImage: AppIcons.map)
                    }
                }

                DIconButtonView(iconButtonType: .user, iconColor: .mint, bgMaterial: .ultraThinMaterial) {
                    vm.requestForFocusOnUser()
                }
                .contextMenu {
                    Button {
                        vm.requestForFocusOnUser()

                    } label: {
                        Label(String(localized: "Centers on your position."), systemImage: AppIcons.sort)
                    }
                }
            }
        }.frame(maxWidth: .infinity)
    }

    private var scrollableLocationCards: some View {
        TabView(selection: $selectedLocation) {
            ForEach(Array(vm.sortedLocations.enumerated()), id: \.element.id) { _, location in
                LocationCardView(location: location, distance: vm.formattedDistance(for: location)) {
                    router.navigate(to: .locationDetail(location))
                }
                .tag(location)
            }
        }
        .frame(height: 180)
        .tabViewStyle(.page)
        .animation(.default, value: selectedLocation)
        .onChange(of: selectedLocation) { _, newValue in
            guard let newLocation = newValue,
                  newLocation != previousSelectedLocation else { return }

            if let newIndex = vm.sortedLocations.firstIndex(where: { $0.id == newLocation.id }) {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                withAnimation {
                    countsDown = newIndex < vm.currentPageIndex
                    vm.currentPageIndex = newIndex
                }
            }

            previousSelectedLocation = newLocation
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
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation {
            position = .region(.init(center: userLocation.clLocationCoordinate2D, latitudinalMeters: 350, longitudinalMeters: 350))
        }
    }

    private func jum(to sort: JumState) {
        guard let location = vm.jump(to: sort) else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation(.linear(duration: 0.5)) {
            selectedLocation = location
        }
    }
}

#Preview {
    NavigationStack {
        CityMapView(city: DeveloperPreview.shared.city, locations: DeveloperPreview.shared.locations)
            .environment(Router())
            .environment(GemineViewStateController())
    }
}
