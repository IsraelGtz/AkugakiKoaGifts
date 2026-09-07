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
                .font(
                    .system(
                        style,
                        design: .serif,
                        weight: .semibold
                    )
                )
                .minimumScaleFactor(minimumScaleFactor)
                .foregroundStyle(color)
                .padding()
        }
    }

    struct linearGradientAnimation: ViewModifier {
        @State private var startPoint = UnitPoint(x: -1, y: 0)
        @State private var endPoint = UnitPoint(x: 0, y: 0)
        private let colors: [Color]

        init(_ colors: [Color] = [.letterFont, .cyan, .blue, .purpleGradientAnimation]) {
            self.colors = colors
        }

        func body(content: Content) -> some View {
            content
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: colors,
                        startPoint: startPoint,
                        endPoint: endPoint
                    )
                )
                .onAppear {
                    withAnimation(
                        .linear(duration: Double.random(in: 4 ... 5.5))
                    ) {
                        startPoint = UnitPoint(x: 1, y: 0)
                        endPoint = UnitPoint(x: 2, y: 0)
                    }
                }
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
