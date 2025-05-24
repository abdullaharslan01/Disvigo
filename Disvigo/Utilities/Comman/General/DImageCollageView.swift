//
//  DImageCollageView.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import SwiftUI

struct DImageCollageView: View {
    let images: [String]

    let height: CGFloat

    init(images: [String], height: CGFloat = 250) {
        self.images = images
        self.height = height
    }

    var body: some View {
        ZStack {
            if !images.isEmpty {
                TabView {
                    ForEach(images, id: \.self) { image in

                        DImageLoaderView(url: image, contentMode: .fill)
                    }

                }.tabViewStyle(.page)
            } else {
                contentUnavaliableView
            }
        }.frame(height: height)
    }

    var imageCollageView: some View {
        TabView {
            ForEach(images, id: \.self) { image in

                DImageLoaderView(url: image, contentMode: .fill)
            }

        }.tabViewStyle(.page)
    }

    var contentUnavaliableView: some View {
        DEmptyStateView(type: .imageNotFound)
    }
}

#Preview {
    DImageCollageView(images: [
    ])
}
