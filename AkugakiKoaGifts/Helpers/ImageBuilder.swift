//
//  ImageBuilder.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 30.7.2026.
//

import SwiftUI

enum ImageBuilder {
    private static let imageNames: [String] = [
        "koaPigtails",
        "koaStrawberry",
        "koaNya",
        "koaCute",
    ]

    private static var randomImageName: String {
        imageNames.randomElement() ?? "koaPigtails"
    }

    @ViewBuilder
    static func getRandomImage(
        idealSize: CGSize? = nil,
        minSize: CGSize? = nil,
        maxSize: CGSize? = nil,
        applyGradient: Bool = true,
        gradientStartRadius: CGFloat = 0,
        gradientEndRadius: CGFloat = 100
    ) -> some View {
        Image(randomImageName)
            .resizable()
            .scaledToFit()
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
                            gradient: Gradient(colors: [.black, .black, .clear]),
                            center: .center,
                            startRadius: gradientStartRadius,
                            endRadius: gradientEndRadius
                        )
                    }
            })
    }
}
