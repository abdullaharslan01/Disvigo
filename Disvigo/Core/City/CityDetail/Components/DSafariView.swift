//
//  DSafariView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import SafariServices
import SwiftUI

struct DSafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> some SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        return SFSafariViewController(url: url, configuration: config)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
