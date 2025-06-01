//
//  AddLocationView.swift
//  Disvigo
//
//  Created by abdullah on 01.06.2025.
//

import SwiftUI

struct DAddLocationButtonView: View {
    var onTapGusture: () -> ()

    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

            onTapGusture()
        } label: {
            Image(systemName: AppIcons.plus)
                .font(.poppins(.medium, size: .title))
                .foregroundStyle(.appGreenPrimary)
                .padding()
                .background(
                    .white, in: RoundedRectangle(cornerRadius: 16)
                ).padding()
        }
    }
}

#Preview {

    DAddLocationButtonView {}
}
