//
//  Text+Ext.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import SwiftUI

extension Text {
    init(markdown: String) {
        do {
            let attributed = try AttributedString(
                markdown: markdown,
                options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
            self.init(attributed)
        } catch {
            self.init("Markdown error: \(error.localizedDescription)")
        }
    }
}
