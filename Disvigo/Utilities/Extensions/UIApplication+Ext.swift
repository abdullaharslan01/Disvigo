//
//  UIApplication+Ext.swift
//  Disvigo
//
//  Created by abdullah on 01.06.2025.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
