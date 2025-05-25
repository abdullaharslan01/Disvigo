//
//  CityDetailView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import MapKit
import SwiftUI

struct CityDetailView: View {
    @Environment(Router.self) private var router

    @State var vm: CityDetailViewModel

    @State var position: MapCameraPosition = .automatic

    init(city: City) {
        self._vm = State(wrappedValue: CityDetailViewModel(city: city))
    }

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            ScrollView {
                VStack {
                    cityImageView

                    cityContentView
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .ignoresSafeArea(edges: [.top])
            .preferredColorScheme(.dark)
        }.toolbarVisibility(.visible, for: .tabBar)
    }

    var cityImageView: some View {
        DImageLoaderView(url: vm.city.imageUrl, contentMode: .fill)
            .frame(height: 360)
    }

    var cityContentView: some View {
        VStack(alignment: .leading, spacing: 10) {
            if vm.didAppeear {
                VStack(alignment: .leading, spacing: 25) {
                    headerTextView
                        .transition(.flipFromLeft(duration: 0.5))
                    moreDetailView
                        .transition(.slide)
                    descriptionView
                        .transition(.slide)
                }.padding()

                categoryView
                    .transition(.slide)

                cityMapView
            }
        }
        .padding(.top, 5)
        .background(.appBackgroundDark)
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 32, bottomLeading: 0, bottomTrailing: 0, topTrailing: 32)))
        .offset(y: -50)
        .onAppear {
            vm.fetchLocations()
            withAnimation(.easeInOut(duration: 1)) {
                vm.didAppeear = true
                position = .region(.init(center: vm.city.coordinates.clLocationCoordinate2D, latitudinalMeters: 5000, longitudinalMeters: 5000))
            }
        }
    }

    var headerTextView: some View {
        Text(vm.city.name)
            .font(.poppins(.semiBold, size: .largeTitle))
            .fontWeight(.bold)
    }

    var moreDetailView: some View {
        VStack(alignment: .leading, spacing: 16) {
            DLabeledIconView(title: vm.city.region, symbolName: AppIcons.location)

            Button {
                vm.showSafari.toggle()
            } label: {
                DLabeledIconView(title: String(localized: "Learn More"), symbolName: AppIcons.safari, foregroundStyle: .blue)
            }
        }.sheet(isPresented: $vm.showSafari) {
            if let url = vm.url {
                DSafariView(url: url)
                    .presentationDragIndicator(.visible)
            }
        }
    }

    var descriptionView: some View {
        ExpandableTextView(text: vm.city.description, font: .light, fontSize: .body, lineLimit: 3, horizontalPadding: 16)
    }

    var categoryView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Category.allCases, id: \.id) { category in

                    DCategoryCardView(category: category, size: .init(width: 180, height: 250)) {
                        switch category {
                        case .discoveryPoints, .journeyMemories, .localCuisine:
                            guard !vm.locations.isEmpty else { return }
                            router.navigate(to: .locationList(vm.locations, vm.city.name))
                        }
                    }
                }
            }.padding(.horizontal)
        }.scrollIndicators(.hidden)
            .frame(height: 220)
    }

    var cityMapView: some View {
        Map(position: $position) {
            ForEach(vm.locations) { location in

                Marker(location.title, systemImage: AppIcons.pin, coordinate: location.coordinates.clLocationCoordinate2D)
                    .tint(.blue)

                UserAnnotation()
            }
        }.frame(height: 300)
            .frame(maxWidth: .infinity)
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .overlay(alignment: .bottom, content: {
                DLabelButtonView(systemImage: AppIcons.binoculars, title: String(localized: "Explore Locations")) {
                    router.navigate(to: .cityMap(vm.locations, vm.city))
                }
                .padding(.bottom)

            })
            .padding(.top, 30)
    }
}

#Preview {
    NavigationStack {
        CityDetailView(city: DeveloperPreview.shared.city)
    }
    .environment(Router())
}
