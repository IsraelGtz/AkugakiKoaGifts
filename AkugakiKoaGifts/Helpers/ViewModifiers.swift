//
//  ViewModifiers.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 30.7.2026.
//

import AudioPlayer
import SwiftUI

enum Styles {
    struct TitleCell: ViewModifier {
        @Environment(\.colorScheme) private var colorScheme
        let style: Font.TextStyle
        let color: Color
        let minimumScaleFactor: Double

        public init(
            style: Font.TextStyle = .largeTitle,
            color: Color = .black,
            minimumScaleFactor: Double? = nil
        ) {
            self.style = style
            self.color = color
            self.minimumScaleFactor = minimumScaleFactor ?? 0.75
        }

        func body(content: Content) -> some View {
            content
                .font(.system(style, design: .serif, weight: .semibold))
                .minimumScaleFactor(minimumScaleFactor)
                .foregroundStyle(color)
                .padding()
        }
    }
}
