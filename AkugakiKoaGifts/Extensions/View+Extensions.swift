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

    func sectionHeaderStyle() -> some View {
        font(.system(.headline, weight: .medium))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundStyle(.letterFont)
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

extension View {
    func onFirstAppear(_ onFirstAppearAction: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(onFirstAppearAction))
    }
}

struct OnFirstAppearModifier: ViewModifier {
    private let onFirstAppearAction: () -> Void
    @State private var hasAppeared = false

    public init(_ onFirstAppearAction: @escaping () -> Void) {
        self.onFirstAppearAction = onFirstAppearAction
    }

    public func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                hasAppeared = true
                onFirstAppearAction()
            }
    }
}
