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
        idealSize: CGSize? = nil,
        minSize: CGSize? = nil,
        maxSize: CGSize? = nil,
        applyGradient: Bool = true,
        gradientStartRadius: CGFloat = 0,
        gradientEndRadius: CGFloat = 100
    ) -> [some View] {
        imageResources.compactMap { image in
            Image(image.resource)
                .genericStyle(
                    idealSize: idealSize,
                    minSize: minSize,
                    maxSize: maxSize,
                    applyGradient: applyGradient,
                    gradientStartRadius: gradientStartRadius,
                    gradientEndRadius: gradientEndRadius
                )
        }
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
        Image(randomIdentifiableImage.resource)
            .genericStyle(
                idealSize: idealSize,
                minSize: minSize,
                maxSize: maxSize,
                applyGradient: applyGradient,
                gradientStartRadius: gradientStartRadius,
                gradientEndRadius: gradientEndRadius
            )
    }
}
