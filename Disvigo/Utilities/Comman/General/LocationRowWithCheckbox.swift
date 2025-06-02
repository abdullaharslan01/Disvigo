//
//  LocationRowWithCheckbox.swift
//  Disvigo
//
//  Created by abdullah on 02.06.2025.
//

import SwiftUI

struct LocationRowWithCheckbox: View {
    let location: Location
    let isSelected: Bool
    let rotation: Double
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 10) {
                checkmarkIcon
                LocationSelectionRowView(location: location)
            }
        }
        .buttonStyle(.plain)
    }

    private var checkmarkIcon: some View {
        Image(systemName: isSelected ? AppIcons.checkMarkCircleFill : AppIcons.checkMarkCircle)
            .font(.system(size: 25))
            .foregroundStyle(isSelected ? .appGreenPrimary : .gray)
            .rotationEffect(.degrees(rotation))
            .animation(.easeInOut(duration: 0.5), value: rotation)
    }
}

