//
//  LocationView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import MapKit
import SwiftUI

struct LocationView: View {
    @State private var showFullDescription = false
    @State var mapCameraPosition: MapCameraPosition = .automatic
    @State private var rotationTimer: Timer?
    
    @State var rotationAngle: Double = 0
    
    var isFavorite: Bool {
        return false
    }
  
    let location: Location
    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            
            contentView
            
        }.preferredColorScheme(.dark)
    }
    
    var contentView: some View {
        ScrollView {
            VStack {
                imageSection
                detailSection
                    .padding(.horizontal)
                
                mapSection
                    .padding(.bottom)
            }
        }.ignoresSafeArea()
    }
    
    var imageSection: some View {
        DImageCollageView(images: location.images, height: 350)
            .overlay(alignment: .top) {
                VStack {
                    DIconButtonView(iconButtonType: .favorite(isFavorite)) {}.padding(.top, getSafeArea().top == 0 ? 15 : getSafeArea().top)
                        .padding(.horizontal)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
    }
    
    var detailSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(location.title)
                .font(.poppins(.semiBold, size: .largeTitle))
        
            ExpandableTextView(text: location.description, font: .regular, fontSize: .callout, lineLimit: 4, horizontalPadding: 16)
        
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var mapSection: some View {
        Map(position: $mapCameraPosition) {
            Marker(location.title, coordinate: location.coordinates.clLocationCoordinate2D)
                .tint(.appGreenPrimary)
        }
        .mapStyle(.standard(elevation: .realistic))
        .frame(height: 300)
        .overlay(alignment: .bottom) {
            DLabelButtonView(title: String(localized: "View On Map"))
                .padding(.bottom, 20)
        }
        .onAppear(perform: startRotation)
        .onDisappear(perform: stopRotation)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    private func startRotation() {
        rotationTimer = Timer.scheduledTimer(
            withTimeInterval: 0.01,
            repeats: true
        ) { _ in

            DispatchQueue.main.async {
                updateCameraPosition()
            }
        }

        RunLoop.current.add(rotationTimer!, forMode: .common)
    }

    private func stopRotation() {
        rotationTimer?.invalidate()
    }
    
    func updateCameraPosition() {
        rotationAngle = (rotationAngle + 0.08)
            .truncatingRemainder(dividingBy: 360)

        mapCameraPosition = .camera(
            MapCamera(
                centerCoordinate: location.coordinates.clLocationCoordinate2D,
                distance: 400,
                heading: rotationAngle,
                pitch: 60
            )
        )
    }
}

#Preview {
    NavigationStack {
        LocationView(location: DeveloperPreview.shared.location)
    }
}
