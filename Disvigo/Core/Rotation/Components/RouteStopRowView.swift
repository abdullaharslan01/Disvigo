//
//  RouteStopRowView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI
import MapKit

struct RouteStopRowView: View {
    let index: Int
    let stop: Location
    let userLocation: CLLocationCoordinate2D?
    
    var body: some View {
        HStack {
            HStack {
                Text("\(index + 1).")
                    .bold()
                    .foregroundColor(.appGreenLight)
                
                Text(stop.title)
                    .font(.poppins(.semiBold, size: .callout))
                    .lineLimit(1)
            }.frame(maxWidth: .infinity, alignment: .leading)
        
            if let distance = calculatedDistance {
                Text(distance)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
        }.padding()
            .background(
                Color.black.opacity(0.4), in: RoundedRectangle(cornerRadius: 16)
            )
    }
    private var calculatedDistance: String? {
        guard let userLoc = userLocation else { return nil }
        
        let stopLoc = stop.coordinates.clLocationCoordinate2D
        let distance = CLLocation(latitude: userLoc.latitude, longitude: userLoc.longitude)
            .distance(from: CLLocation(latitude: stopLoc.latitude, longitude: stopLoc.longitude))
        
        return distance >= 1000 ?
            String(format: "%.2f km", distance / 1000) :
            String(format: "%.0f m", distance)
    }
}
