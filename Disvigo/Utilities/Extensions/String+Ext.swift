//
//  String+Ext.swift
//  Disvigo
//
//  Created by abdullah on 23.05.2025.
//

import SwiftUI

extension String {
    func isTruncated(
        font: Poppins,
        fontSize: FontSize,
        lineLimit: Int = 3,
        maxWidth: CGFloat = UIScreen.main.bounds.width,
        horizontalPadding: CGFloat = 16
    ) -> Bool {
        let font = UIFont(name: font.fontName, size: fontSize.value) ?? UIFont.systemFont(ofSize: 16)

        let attributes: [NSAttributedString.Key: Any] = [.font: font]

        let constraintRect = CGSize(
            width: maxWidth - (horizontalPadding * 2),
            height: .greatestFiniteMagnitude
        )

        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: attributes,
                                            context: nil)

        return boundingBox.height > font.lineHeight * CGFloat(lineLimit)
    }
}
