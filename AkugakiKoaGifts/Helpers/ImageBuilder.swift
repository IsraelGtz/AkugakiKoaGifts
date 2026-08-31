//
//  ImageBuilder.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 30.7.2026.
//

import SwiftUI

struct IdentifiableImageResource: Identifiable {
    let id = UUID()
    let resource: ImageResource

    init(_ resource: ImageResource) {
        self.resource = resource
    }
}

enum ImageBuilder {
    static let imageResources: [IdentifiableImageResource] = [
        .init(.koaCute),
        .init(.koaNya),
        .init(.koaPigtails),
        .init(.koaStrawberry),
        .init(.test),
    ]

    static var randomIdentifiableImage: IdentifiableImageResource {
        imageResources.randomElement() ?? .init(.koaPigtails)
    }

    static func getAllImages(
        scaleEffect: CGFloat = 1.5,
        applyGradient: Bool = true,
        gradientStartRadius: CGFloat = 0,
        gradientEndRadius: CGFloat = 100
    ) -> [some View] {
        imageResources.compactMap { image in
            Image(image.resource)
                .genericStyle(
                    scaleEffect: scaleEffect,
                    applyGradient: applyGradient,
                    gradientStartRadius: gradientStartRadius,
                    gradientEndRadius: gradientEndRadius
                )
        }
    }

    @ViewBuilder
    static func getRandomImage(
        scaleEffect: CGFloat = 1.5,
        applyGradient: Bool = true,
        gradientStartRadius: CGFloat = 0,
        gradientEndRadius: CGFloat = 85
    ) -> some View {
        Image(randomIdentifiableImage.resource)
            .genericStyle(
                scaleEffect: scaleEffect,
                applyGradient: applyGradient,
                gradientStartRadius: gradientStartRadius,
                gradientEndRadius: gradientEndRadius
            )
    }
}
