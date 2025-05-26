//
//  TravelModeView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import MapKit
import SwiftUI

enum TravelMode: String, CaseIterable, Identifiable {
    case walking = "Walking"
    case automobile = "Driving"

    var id: String { rawValue }
    var transportType: MKDirectionsTransportType {
        switch self {
        case .walking: return .walking
        case .automobile: return .automobile
        }
    }

    var iconName: String {
        switch self {
        case .walking: return "figure.walk"
        case .automobile: return "car.fill"
        }
    }

    var appleMapsValue: String {
        switch self {
        case .walking:
            return MKLaunchOptionsDirectionsModeWalking
        case .automobile:
            return MKLaunchOptionsDirectionsModeDriving
        }
    }

    var googleMapsValue: String {
        switch self {
        case .walking:
            return "walking"
        case .automobile:
            return "driving"
        }
    }
}

struct TravelModeView: View {
    @Binding var selectedMode: TravelMode
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TravelMode.allCases) { mode in
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                        impactFeedback.impactOccurred()
                        selectedMode = mode
                    }
                }) {
                    HStack {
                        Image(systemName: mode.iconName)
                        Text(mode.rawValue)
                            .font(.caption)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(selectedMode == mode ? .white : .gray)
                }
                .background(
                    ZStack {
                        if selectedMode == mode {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.blue)
                                .matchedGeometryEffect(id: "mode_background", in: animation)
                        }
                    }
                )
            }
        }
        .padding(4)
        .background(Color.black.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
