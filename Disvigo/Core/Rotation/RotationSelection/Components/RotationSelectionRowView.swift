//
//  RotationSelectionRowView.swift
//  Disvigo
//
//  Created by abdullah on 26.05.2025.
//

import SwiftUI

struct RotationSelectionRowView: View {
    let location: Location
    var contexMenuGesture: (() -> ())?
    var body: some View {
        HStack(alignment: .top) {
            DImageLoaderView(url: location.images.first, contentMode: .fill)
                .frame(width: 150, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            VStack(alignment: .leading, spacing: 5) {
                Text(location.title)
                    .font(.poppins(.semiBold, size: .callout))
                    .lineLimit(2)

                Text(location.description)
                    .lineLimit(4)
                    .font(.poppins(.light, size: .caption))
            }
        }
        .contextMenu {
            DLabelButtonView(systemImage: AppIcons.locationDetail, title: String(localized: "Go to Detail")) {
                contexMenuGesture?()
            }
        }
    }
}

#Preview {
    RotationSelectionRowView(location: DeveloperPreview.shared.location)
}
