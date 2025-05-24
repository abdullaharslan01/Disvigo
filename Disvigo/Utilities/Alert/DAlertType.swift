//
//  DAlertType.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import SwiftUI

enum DAlertType {
    case locationPermission(allowAction: () -> Void)
    case general(title: String, message: String)
    case custom(title: String, message: String, primary: Alert.Button, secondary: Alert.Button)

    func build() -> Alert {
        switch self {
        case .locationPermission(let allowAction):
            return Alert(
                title: Text("Location Access"),
                message: Text("Allow access to your location to show your position on the map?"),
                primaryButton: .default(Text("Allow"), action: allowAction),
                secondaryButton: .cancel(Text("Not Now"))
            )

        case .general(let title, let message):
            return Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text(String(localized: "OK")))
            )

        case .custom(let title, let message, let primary, let secondary):
            return Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: primary,
                secondaryButton: secondary
            )
        }
    }
}
