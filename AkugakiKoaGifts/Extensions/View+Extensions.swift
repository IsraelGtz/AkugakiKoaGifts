//
//  View+Extensions.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 30.7.2026.
//

import AudioPlayer
import SwiftUI

extension View {
    func titleCellStyle(
        style: Font.TextStyle = .largeTitle,
        color: Color = Color.koaCyan,
        minimumScaleFactor: Double? = 0.8
    ) -> some View {
        modifier(
            Styles.TitleCell(
                style: style,
                color: color,
                minimumScaleFactor: minimumScaleFactor
            )
        )
    }

    func linearGradientAnimationStyle() -> some View {
        modifier(
            Styles.linearGradientAnimation()
        )
    }
}

extension View {
    @ViewBuilder
    func `if`(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
