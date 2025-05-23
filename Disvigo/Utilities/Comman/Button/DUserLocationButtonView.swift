//
//  DUserLocationButtonView.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import SwiftUI

struct DUserLocationButtonView: View {
    let onTapGesture:()->()
    var body: some View {
        Button {
            onTapGesture()
        } label: {
            Image(systemName: AppIcons.personCircle)
                .padding()
                .font(.poppins(.regular, size: .title2))
                .foregroundStyle(.appTextLight)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    DUserLocationButtonView() {
        
    }
}
