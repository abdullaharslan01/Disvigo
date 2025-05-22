//
//  DImageLoaderView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct DImageLoaderView: View {
    let url: String?
    let contentMode: ContentMode

    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                if let url {
                    SDWebImageLoader(url: url, contentMode: contentMode)
                }
            }
            .clipped()
    }
}

private struct SDWebImageLoader: View {
    let url: String
    let contentMode: ContentMode

    var body: some View {
        WebImage(url: URL(string: url)) { image in
            image
                .resizable()
        } placeholder: {
            Rectangle()
                .foregroundColor(.gray)
        }
        .indicator(.activity)
        .transition(.opacity)
        .aspectRatio(contentMode: contentMode)
    }
}

#Preview {
    DImageLoaderView(url: "https://upload.wikimedia.org/wikipedia/commons/4/4a/Hagia_Sophia_%28228968325%29.jpeg", contentMode: .fill)
}
