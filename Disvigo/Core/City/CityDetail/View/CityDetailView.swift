import MapKit
import SwiftUI

struct CityDetailView: View {
    @Environment(Router.self) private var router
    @State var vm: CityDetailViewModel
    @State var position: MapCameraPosition = .automatic
    @State var selectedLocation: Location?

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
            .onAppear(perform: {
                vm.didAppeear = true
            })
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
        .alert(isPresented: $vm.errorAlert) {
            DAlertType.general(title: vm.alert.title, message: vm.alert.message).build()
        }
        .task {
            vm.fecthCity()
        }.onChange(of: vm.locations.count) { _, _ in
            withAnimation(.easeInOut(duration: 1)) {
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
                    DCategoryCardView(category: category, isLoading: $vm.isLoading, size: .init(width: 180, height: 250)) {
                        if vm.isLoading {
                            vm.alert = .init(title: String(localized: "Loading"), message: String(localized: "Please wait while we fetch your data..."))
                            vm.errorAlert.toggle()
                        } else {
                            switch category {
                            case .location:
                                guard !vm.locations.isEmpty else { return }
                                router.navigate(to: .locationList(vm.locations, vm.city.name))
                            case .food:
                                guard !vm.foods.isEmpty else { return }
                                router.navigate(to: .foodList(vm.foods, vm.city.name))
                            case .memory:
                                guard !vm.memories.isEmpty else { return }
                                router.navigate(to: .memoryList(vm.memories, vm.city.name))
                            }
                        }
                    }
                }
            }.padding(.horizontal)
        }.scrollIndicators(.hidden)
            .frame(height: 220)
    }

    private var cityMap: some View {
        Map(position: $position, selection: $selectedLocation) {
            ForEach(vm.locations) { location in
                Annotation(location.title, coordinate: location.coordinates.clLocationCoordinate2D) {
                    DImageLoaderView(url: location.images.first ?? "", contentMode: .fill)
                        .clipShape(.circle)
                        .frame(
                            width: location == selectedLocation ? 60 : 30,
                            height: location == selectedLocation ? 60 : 30
                        )
                        .animation(.easeInOut(duration: 0.3), value: selectedLocation)
                        .contextMenu {
                            Button {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                router.navigate(to: .locationDetail(location))
                            } label: {
                                Label(String(localized: "Go to Detail"), systemImage: AppIcons.locationDetail)
                            }
                        }
                }
                .tag(location)
            }

            UserAnnotation()
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        .overlay(alignment: .bottom) {
            DLabelButtonView(systemImage: AppIcons.binoculars, title: String(localized: "Explore Locations")) {
                router.navigate(to: .cityMap(vm.locations, vm.city))
            }
            .padding(.bottom, 30)
        }
        .onChange(of: selectedLocation) { _, newValue in
            if let location = newValue {
                focusOn(location: location)
            }
        }
    }

    var cityMapView: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.gray.opacity(0.1))
                .overlay {
                    if vm.isLoading {
                        ProgressView(String(localized: "Loading Locations..."))
                    } else if vm.locations.isEmpty {
                        DEmptyStateView(type: .custom(title: String(localized: "Location Not Found"), description: String(localized: "We couldn't find any location data for this area. Please check your connection or try another location."), buttonText: nil, icon: AppIcons.map))
                    }
                }

            if !vm.locations.isEmpty {
                cityMap
            }
        }
        .frame(height: 300)
        .padding(.top,30)
    }

    private func focusOn(location: Location?) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        guard let location = location else { return }

        let coordinate = location.coordinates.clLocationCoordinate2D

        guard CLLocationCoordinate2DIsValid(coordinate) else { return }

        withAnimation(.easeInOut(duration: 0.5)) {
            position = .region(MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            ))
        }
    }
}

#Preview {
    NavigationStack {
        CityDetailView(city: DeveloperPreview.shared.city)
    }
    .environment(Router())
}
