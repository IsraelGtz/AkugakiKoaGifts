//
//  ImageBuilder.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 30.7.2026.
//

import SwiftUI

struct IdentifiableImageResource: Identifiable {
    let id = UUID()
    let uiimage: UIImage
    let name: String
}

// struct IdentifiableImageResource: Identifiable {
//    let id = UUID()
//    let resource: ImageResource
//    let name: String
////    let uiimage: UIImage?
//
//    init(
//        resource: ImageResource,
//        name: String
//    ) {
//        self.resource = resource
//        self.name = name
////        self.uiimage = IdentifiableImageResource.downscalingImage(name: name, to: .init(width: 100, height: 100))
//    }
// }

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

//    static let imageResources: [IdentifiableImageResource] = [
//        .init(resource: .art1, name:"art_1"),
//        .init(resource: .art2, name:"art_2"),
//        .init(resource: .art3, name:"art_3"),
//        .init(resource: .art4, name:"art_4"),
//        .init(resource: .art5, name:"art_5"),
//        .init(resource: .art6, name:"art_6"),
//        .init(resource: .art7, name:"art_7"),
//        .init(resource: .art8, name:"art_8"),
//        .init(resource: .art9, name:"art_9"),
//        .init(resource: .art10, name:"art_10"),
//        .init(resource: .art11, name:"art_11"),
//        .init(resource: .art12, name:"art_12"),
//        .init(resource: .art13, name:"art_13"),
//        .init(resource: .art14, name:"art_14"),
//        .init(resource: .art15, name:"art_15"),
//        .init(resource: .art16, name:"art_16"),
//        .init(resource: .art17, name:"art_17"),
//        .init(resource: .art18, name:"art_18"),
//        .init(resource: .art19, name:"art_19"),
//        .init(resource: .art20, name:"art_20"),
//        .init(resource: .art21, name:"art_21"),
//        .init(resource: .art22, name:"art_22"),
//        .init(resource: .art23, name:"art_23"),
//        .init(resource: .art24, name:"art_24"),
//        .init(resource: .art25, name:"art_25"),
//        .init(resource: .art26, name:"art_26"),
//        .init(resource: .art27, name:"art_27"),
//        .init(resource: .art28, name:"art_28"),
//        .init(resource: .art29, name:"art_29"),
//        .init(resource: .art30, name:"art_30"),
//        .init(resource: .art31, name:"art_31"),
//        .init(resource: .art32, name:"art_32"),
//        .init(resource: .art33, name:"art_33"),
//        .init(resource: .art34, name:"art_34"),
//        .init(resource: .art35, name:"art_35"),
//        .init(resource: .art36, name:"art_36"),
//        .init(resource: .art37, name:"art_37"),
//        .init(resource: .art38, name:"art_38"),
//        .init(resource: .art39, name:"art_39"),
//        .init(resource: .art40, name:"art_40"),
//        .init(resource: .art41, name:"art_41"),
//        .init(resource: .art42, name:"art_42"),
//        .init(resource: .art43, name:"art_43"),
//        .init(resource: .art44, name:"art_44"),
//        .init(resource: .art45, name:"art_45"),
//        .init(resource: .art46, name:"art_46"),
//        .init(resource: .art47, name:"art_47"),
//        .init(resource: .art48, name:"art_48"),
//        .init(resource: .art49, name:"art_49"),
//        .init(resource: .art50, name:"art_50"),
//        .init(resource: .art51, name:"art_51"),
//        .init(resource: .art52, name:"art_52")
//    ]

//        .init(.koaCute),
//        .init(.koaNya),
//        .init(.koaPigtails),
//        .init(.koaStrawberry),
//        .init(.test),

//    static var randomIdentifiableImage: IdentifiableImageResource {
//        imageResources.randomElement() ?? .init(resource: .art8, name: "art_8" )
//    }
//
//    static func getAllImages(
//        scaleEffect: CGFloat = 1.5,
//        applyGradient: Bool = true,
//        gradientStartRadius: CGFloat = 0,
//        gradientEndRadius: CGFloat = 100
//    ) -> [some View] {
//        imageResources.compactMap { image in
//            Image(image.resource)
//                .genericStyle(
//                    scaleEffect: scaleEffect,
//                    applyGradient: applyGradient,
//                    gradientStartRadius: gradientStartRadius,
//                    gradientEndRadius: gradientEndRadius
//                )
//        }
//    }
//
//    @ViewBuilder
//    static func getRandomImage(
//        scaleEffect: CGFloat = 1.5,
//        applyGradient: Bool = true,
//        gradientStartRadius: CGFloat = 0,
//        gradientEndRadius: CGFloat = 85
//    ) -> some View {
//        Image(randomIdentifiableImage.resource)
//            .genericStyle(
//                scaleEffect: scaleEffect,
//                applyGradient: applyGradient,
//                gradientStartRadius: gradientStartRadius,
//                gradientEndRadius: gradientEndRadius
//            )
//    }
}
