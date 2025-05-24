//
//  DAlertType.swift
//  Disvigo
//
//  Created by abdullah on 24.05.2025.
//

import SwiftUI

enum DAlertType {
    case locationPermission(permissionAlertType: PermissionAlertType, allowAction: () -> Void)
    case general(title: String, message: String)
    case custom(title: String, message: String, primary: Alert.Button, secondary: Alert.Button)

    func build() -> Alert {
        switch self {
        case .locationPermission(let permissionAlertType, let allowAction):
            return Alert(
                title: Text(String(localized: "Location Access")),
                message: Text(permissionAlertMessage),
                primaryButton: .default(Text(String(localized: "Allow")), action: allowAction),
                secondaryButton: .cancel(Text(String(localized: "Not Now")))
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

    var permissionAlertMessage: String {
        switch self {
        case .locationPermission(let permissionAlertType, let allowAction):

            switch permissionAlertType {
            case .focusOnUser:
                return String(localized: "Allow access to your location to show your position on the map?")
            case .sortLocations:
                return String(localized: "To sort the nearest cities according to your location, you need to grant location permission.")
            }
        case .general(title: let title, message: let message):
            return ""
        case .custom(title: let title, message: let message, primary: let primary, secondary: let secondary):
            return ""
        }
    }
}
