//
//  Image+Extensions.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.8.2026.
//

import SwiftUI

extension Image {
    func genericStyle(
        idealSize: CGSize? = nil,
        minSize: CGSize? = nil,
        maxSize: CGSize? = nil,
        applyGradient: Bool = true,
        gradientColors: Gradient = Gradient(colors: [.black, .black, .clear]),
        gradientStartRadius: CGFloat = 0,
        gradientEndRadius: CGFloat = 100
    ) -> some View {
        resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(
                minWidth: minSize?.width,
                idealWidth: idealSize?.width,
                maxWidth: maxSize?.width,
                minHeight: minSize?.height,
                maxHeight: maxSize?.height
            )
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
