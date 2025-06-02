import MapKit
import SwiftUI

struct RotataionDetailView: View {
    var stops: [Location]

    @Environment(GemineViewStateController.self) private var gemine

    @State var selectedLocation: Location?
    @State var vm = RotationViewModel()
    
    @State private var isCalculatingRoute = false
    @State private var position: MapCameraPosition = .automatic
    @State private var routeCoordinates: [CLLocationCoordinate2D] = []
    @State private var travelTime: TimeInterval = 0
    @State private var totalDistance: CLLocationDistance = 0
    @State private var showMapSelectionSheet = false
    @State private var sortedStops: [Location] = []
    
    @State private var showThrottlingAlert = false
    @State private var routeCalculationFailed = false
    @State private var requestCount = 0
    @State private var isThrottled = false
    @State private var throttleStartTime: Date?
    @State private var remainingThrottleTime: Int = 60
    @State private var throttleTimer: Timer?
    
    @Namespace var animation
    @State private var selectedMode: TravelMode = .walking
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.55
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    private let maxRequests = 50
    private let throttleWindow: TimeInterval = 60
    
    @Environment(Router.self) var router
    
    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .bottom) {
                Map(position: $position, selection: $selectedLocation) {
                    ForEach(sortedStops) { location in
                        
                        Annotation(coordinate: location.coordinates.clLocationCoordinate2D) {
                            DImageLoaderView(url: location.images[0], contentMode: .fill)
                                .clipShape(.circle)
                                .frame(width: location == selectedLocation ? 70 : 35, height: location == selectedLocation ? 70 : 35)
                                .contextMenu {
                                    DLabelButtonView(systemImage: AppIcons.locationDetail, title: String(localized: "Go to Detail")) {
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

                                        router.navigate(to: .locationDetail(location))
                                    }
                                }.transition(.scale.combined(with: .opacity))

                        } label: {
                            Text(location.title)
                        }.tag(location)
                    }
                    
                    if let userLocation = vm.locationManager.userLocation {
                        Marker(String(localized: "You"), systemImage: AppIcons.personFill, coordinate: userLocation)
                            .tint(.red)
                    }
                    
                    MapPolyline(coordinates: routeCoordinates)
                        .stroke(.blue, lineWidth: 4)
                }
                .onAppear {
                    gemine.isVisible = .hidden

                    vm.locationManager.requestLocation()
                    updateRoute()
                }
                .onChange(of: vm.locationManager.userLocationReady) { _, newValue in
                    if newValue {
                        updateRoute()
                    }
                }.alert(isPresented: $vm.locationManager.settingsWarningState) {
                    DAlertType.locationPermission(permissionAlertType: .focusOnUser) {
                        vm.locationManager.openSettingsForLocationPermission()
                    }.build()
                }
                
                .onChange(of: selectedMode) { _, _ in
                    updateRoute()
                }
                .onChange(of: selectedLocation) { _, _ in
                    
                    focusOn(location: selectedLocation)
                }
                .ignoresSafeArea()
                .overlay(alignment: .topLeading) {
                    viewOnMapButton
                        .padding(.horizontal)
                        .padding(.vertical)
                }
                
                VStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .foregroundColor(.gray)
                        .padding(.vertical, 10)
                    
                    rotationInfoView
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 10)
                .offset(y: startingOffsetY + currentDragOffsetY + endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0, currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
                )
                
                if isCalculatingRoute {
                    VStack {
                        ProgressView(String(localized: "Calculating Route"))
                            .progressViewStyle(.circular)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                }
            }
        }
        .ignoresSafeArea(edges: [.bottom])
        .alert(String(localized: "Rate Limit Exceeded"),
               isPresented: $showThrottlingAlert,
               actions: {
                   Button(String(localized: "OK")) {
                       showThrottlingAlert = false
                   }
               },
               message: {
                   Text(String(localized: "Please wait before making more route requests."))
               })
        .confirmationDialog(String(localized: "Select Map App"),
                            isPresented: $showMapSelectionSheet,
                            actions: {
                                Button(String(localized: "Apple Maps")) {
                                    MapManager.shared.openRouteInAppleMaps(stops: sortedStops, mode: selectedMode)
                                }
                                
                                if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                                    Button(String(localized: "Google Maps")) {
                                        MapManager.shared.openRouteInGoogleMaps(stops: sortedStops, mode: selectedMode)
                                    }
                                }
                                
                                Button(String(localized: "Cancel"), role: .cancel) {}
                            })
    }
    
    private func updateRoute() {
        guard let userLocation = vm.locationManager.userLocation else { return }
        
        if isThrottled {
            return
        }
        
        if requestCount >= maxRequests {
            startThrottling()
            return
        }
        
        requestCount += 1
        calculateRoute(from: userLocation)
    }
    
    private func focusOn(location: Location?) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        guard let location = location?.coordinates.clLocationCoordinate2D else { return }
        
        withAnimation {
            position = .region(MKCoordinateRegion(
                center: location,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            ))
        }
    }
    
    private func startThrottling() {
        isThrottled = true
        throttleStartTime = Date()
        remainingThrottleTime = Int(throttleWindow)
        startThrottleCountdown(from: remainingThrottleTime)
        showThrottlingAlert = true
    }
    
    private func calculateRoute(from start: CLLocationCoordinate2D) {
        isCalculatingRoute = true
        routeCalculationFailed = false
        
        var newRouteCoordinates: [CLLocationCoordinate2D] = []
        var newTravelTime: TimeInterval = 0
        var newTotalDistance: CLLocationDistance = 0
        var newSortedStops: [Location] = []
        
        let sorted = stops.sorted {
            $0.coordinates.clLocationCoordinate2D.distance(to: start) <
                $1.coordinates.clLocationCoordinate2D.distance(to: start)
        }
        
        var previous = start
        let group = DispatchGroup()
        
        for stop in sorted {
            let destination = stop.coordinates.clLocationCoordinate2D
            group.enter()
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: previous))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
            request.transportType = selectedMode.transportType
            
            MKDirections(request: request).calculate { response, error in
                defer { group.leave() }
                
                if let error = error as NSError? {
                    let isThrottlingError = (error.domain == "GEOErrorDomain" && error.code == -3) ||
                        (error.domain == "MKErrorDomain" && error.code == 3 &&
                            error.userInfo["MKErrorGEOError"] as? Int == -3) ||
                        (error.localizedDescription.contains("Directions Not Available") &&
                            error.userInfo["MKErrorGEOErrorUserInfo"] != nil)
                    
                    if isThrottlingError {
                        DispatchQueue.main.async {
                            handleThrottlingError(error)
                        }
                        return
                    }
                    
                    return
                }
                
                if let route = response?.routes.first, !route.steps.isEmpty {
                    newRouteCoordinates.append(contentsOf: route.polyline.coordinates)
                    newTravelTime += route.expectedTravelTime
                    newTotalDistance += route.distance
                    newSortedStops.append(stop)
                }
            }
            
            previous = destination
        }
        
        group.notify(queue: .main) {
            isCalculatingRoute = false
            
            if !routeCalculationFailed && !isThrottled {
                routeCoordinates = newRouteCoordinates
                travelTime = newTravelTime
                totalDistance = newTotalDistance
                sortedStops = newSortedStops
                
                position = .region(MKCoordinateRegion(
                    center: start,
                    latitudinalMeters: 2000,
                    longitudinalMeters: 2000
                ))
            }
        }
    }
    
    private func handleThrottlingError(_ error: NSError) {
        routeCalculationFailed = true
        var timeUntilReset = Int(throttleWindow)
        
        if let resetTime = error.userInfo["timeUntilReset"] as? Int {
            timeUntilReset = resetTime
        } else if let geoErrorInfo = error.userInfo["MKErrorGEOErrorUserInfo"] as? [String: Any],
                  let resetTime = geoErrorInfo["timeUntilReset"] as? Int
        {
            timeUntilReset = resetTime
        } else if let geoErrorInfo = error.userInfo["MKErrorGEOErrorUserInfo"] as? [String: Any],
                  let details = geoErrorInfo["details"] as? [[String: Any]],
                  let firstDetail = details.first,
                  let resetTime = firstDetail["timeUntilReset"] as? Int
        {
            timeUntilReset = resetTime
        }
        
        remainingThrottleTime = max(timeUntilReset, 1)
        isThrottled = true
        throttleStartTime = Date()
        startThrottleCountdown(from: remainingThrottleTime)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showThrottlingAlert = true
        }
    }
    
    private func startThrottleCountdown(from seconds: Int) {
        remainingThrottleTime = seconds
        throttleTimer?.invalidate()
        
        throttleTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingThrottleTime > 1 {
                remainingThrottleTime -= 1
            } else {
                timer.invalidate()
                throttleTimer = nil
                isThrottled = false
                requestCount = 0
                throttleStartTime = nil
                routeCalculationFailed = false
            }
        }
    }
    
    private var viewOnMapButton: some View {
        HStack(alignment: .top) {
            DIconButtonView(
                iconButtonType: .custom(AppIcons.xmark),
                iconColor: .appTextLight,
                bgColor: .red
            ) {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                router.navigateBack()
            }
            
            .contextMenu {
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    router.navigateBack()
                } label: {
                    Text(String(localized: "Back"))
                }
            }
            
            Spacer()
            VStack(alignment: .trailing, spacing: 20) {
                DLabelButtonView(systemImage: AppIcons.locationSquare, title: String(localized: "Get Directions")) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    showMapSelectionSheet.toggle()
                }
                .disabled(isThrottled)
                .opacity(isThrottled ? 0.6 : 1.0)
                
                DIconButtonView(iconButtonType: .user, iconColor: .appGreenPrimary, bgMaterial: .ultraThinMaterial) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()

                    vm.locationManager.checkLocationAuthorization()
                }
            }
        }.onChange(of: vm.focusOnUserStatus) { _, _ in
           
            guard let userLocation = vm.locationManager.userLocation else { return }
                
            withAnimation {
                position = .region(MKCoordinateRegion(
                    center: userLocation,
                    latitudinalMeters: 2000,
                    longitudinalMeters: 2000
                ))
            }
        }
    }
    
    private var rotationInfoView: some View {
        VStack(spacing: 25) {
            TravelModeView(selectedMode: $selectedMode, animation: animation)
                .disabled(isThrottled)
                .opacity(isThrottled ? 0.6 : 1.0)
            
            VStack(spacing: 15) {
                if isThrottled {
                    VStack(spacing: 8) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text(String(localized: "Rate Limit Exceeded"))
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.orange)
                        }
                        
                        Text(String(format: String(localized: "Too many route requests. Please wait %d seconds before trying again."), remainingThrottleTime))
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                } else {
                    LabeledContent(String(localized: "Total Distance"), value: "\(String(format: "%.2f", totalDistance / 1000)) km")
                    LabeledContent(String(localized: "Estimated Time"), value: formattedTime(travelTime))
                }
            }
            
            List {
                ForEach(Array(sortedStops.enumerated()), id: \.offset) { index, item in
                    RouteStopRowView(index: index, stop: item, userLocation: vm.locationManager.userLocation) {
                        selectedLocation = item
                    }
                        
                    .contextMenu {
                        Button {
                            router.navigate(to: .locationDetail(item))
                        } label: {
                            DLabelButtonView(systemImage: AppIcons.locationDetail, title: String(localized: "Go to Detail")) {}
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
    
    private func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return hours > 0 ? "\(hours) h \(remainingMinutes) min" : "\(remainingMinutes) min"
    }
}

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

extension CLLocationCoordinate2D {
    func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: latitude, longitude: longitude)
        let to = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return from.distance(from: to)
    }
}

extension Array where Element == CLLocationCoordinate2D {
    var average: CLLocationCoordinate2D? {
        guard !isEmpty else { return nil }
        let totalLat = reduce(0) { $0 + $1.latitude }
        let totalLon = reduce(0) { $0 + $1.longitude }
        return CLLocationCoordinate2D(latitude: totalLat / Double(count), longitude: totalLon / Double(count))
    }
}

#Preview {
    NavigationStack {
        RotataionDetailView(stops: DeveloperPreview.shared.locations)
            .environment(Router())
            .environment(GemineViewStateController())
    }
}
