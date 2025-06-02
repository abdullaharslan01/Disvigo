//
//  SelectAllButton.swift
//  Disvigo
//
//  Created by abdullah on 02.06.2025.
//

import SwiftUI

struct DSelectAllButton: View {
    let isAllSelected: Bool
    let onToggle: () -> Void

    var body: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            onToggle()
        }) {
            ZStack {
                if isAllSelected {
                    Image(systemName: AppIcons.unCheckedAllList)
                        .font(.poppins(.medium, size: .title3))
                        .transition(.opacity)

                } else {
                    Image(systemName: AppIcons.checkedAllList)
                        .font(.poppins(.medium, size: .title3))
                        .transition(.opacity)

                }
            }.padding(10)
                .padding(.horizontal)
                .foregroundStyle(.red)
                .background(
                    Color.appTextLight, in: RoundedRectangle(cornerRadius: 16)
                )
        }

        .animation(.easeInOut(duration: 0.2), value: isAllSelected)
    }
}

#Preview {
    ZStack {
        Color.appBackgroundDark.ignoresSafeArea()

        HStack(spacing: 30) {
            DSelectAllButton(isAllSelected: true) {}
            DSelectAllButton(isAllSelected: false) {}
        }
    }
}
