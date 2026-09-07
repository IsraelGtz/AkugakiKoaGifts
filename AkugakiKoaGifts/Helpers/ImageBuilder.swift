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
    static let imageNames: [String] = [
        "art_1",
        "art_2",
        "art_3",
        "art_4",
        "art_5",
        "art_6",
        "art_7",
        "art_8",
        "art_9",
        "art_10",
        "art_11",
        "art_12",
        "art_13",
        "art_14",
        "art_15",
        "art_16",
        "art_17",
        "art_18",
        "art_19",
        "art_20",
        "art_21",
        "art_22",
        "art_23",
        "art_24",
        "art_25",
        "art_26",
        "art_27",
        "art_28",
        "art_29",
        "art_30",
        "art_31",
        "art_32",
        "art_33",
        "art_34",
        "art_35",
        "art_36",
        "art_37",
        "art_38",
        "art_39",
        "art_40",
        "art_41",
        "art_42",
        "art_43",
        "art_44",
    ]

    static let imageResources: [IdentifiableImageResource] = [
        .init(.art1),
        .init(.art2),
        .init(.art3),
        .init(.art4),
        .init(.art5),
        .init(.art6),
        .init(.art7),
        .init(.art8),
        .init(.art9),
        .init(.art10),
        .init(.art11),
        .init(.art12),
        .init(.art13),
        .init(.art14),
        .init(.art15),
        .init(.art16),
        .init(.art17),
        .init(.art18),
        .init(.art19),
        .init(.art20),
        .init(.art21),
        .init(.art22),
        .init(.art23),
        .init(.art24),
        .init(.art25),
        .init(.art26),
        .init(.art27),
        .init(.art28),
        .init(.art29),
        .init(.art30),
        .init(.art31),
        .init(.art32),
        .init(.art33),
        .init(.art34),
        .init(.art35),
        .init(.art36),
        .init(.art37),
        .init(.art38),
        .init(.art39),
        .init(.art40),
        .init(.art41),
        .init(.art42),
        .init(.art43),
        .init(.art44),
        .init(.art45),
        .init(.art46),
        .init(.art47),
        .init(.art48),
        .init(.art49),
        .init(.art50),
        .init(.art51),
        .init(.art52),
    ]

//        .init(.koaCute),
//        .init(.koaNya),
//        .init(.koaPigtails),
//        .init(.koaStrawberry),
//        .init(.test),

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
