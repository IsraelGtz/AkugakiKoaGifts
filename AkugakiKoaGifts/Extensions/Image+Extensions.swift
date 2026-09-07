//
//  Image+Extensions.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.8.2026.
//

import SwiftUI

extension Image {
    func genericStyle(
        scaleEffect: CGFloat = 1.5,
        applyGradient: Bool = true,
        gradientColors: Gradient = Gradient(colors: [.black, .black, .clear]),
        gradientStartRadius: CGFloat = 0,
        gradientEndRadius: CGFloat = 100
    ) -> some View {
        resizable()
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(scaleEffect)
            .if(applyGradient, transform: { view in
                view
                    .clipShape(Circle())
                    .mask {
                        RadialGradient(
                            gradient: gradientColors,
                            center: .center,
                            startRadius: gradientStartRadius,
                            endRadius: gradientEndRadius
                        )
                    }
            })
    }
}
