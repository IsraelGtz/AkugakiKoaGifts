//
//  ImageBuilder.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 30.7.2026.
//

import SwiftUI

struct IdentifiableUIImage: Identifiable {
    let id = UUID()
    let uiimage: UIImage
    let name: String
}

enum ImageBuilder {
//    static let shared: ImageBuilder = .init()
//
//    private init() {}

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
        "art_45",
        "art_46",
        "art_47",
        "art_48",
        "art_49",
        "art_50",
        "art_51",
        "art_52",
    ]

    static var randomImageName: String {
        ImageBuilder.imageNames.randomElement() ?? "art_39"
    }

    public nonisolated static func downsampleAssetCatalogJPEG(
        named name: String,
        to pointSize: CGSize,
        scale: CGFloat
    ) async -> IdentifiableUIImage? {
        let cacheKey = "\(name)_\(pointSize.width)x\(pointSize.height)_\(scale)"
        if let cached = await ImageCache.shared.image(forKey: cacheKey) {
            return cached
        }

        guard
            let uiImage = UIImage(named: name),
            let imageData = uiImage.jpegData(compressionQuality: 1.0)
        else {
            return nil
        }

        return await Task.detached(priority: .userInitiated) {
            // Disable internal global system caching to isolate memory per background thread
            let imageOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageOptions) else { return nil }

            let maxDimension = max(pointSize.width, pointSize.height) * scale
            let downsampleOptions = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: true, // Forces extraction *now* in the background
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: maxDimension,
            ] as CFDictionary

            guard let downsampledCGImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }
            let uiimage = UIImage(cgImage: downsampledCGImage, scale: scale, orientation: .up)
            let identifiableUIImage = IdentifiableUIImage(uiimage: uiimage, name: name)
            await ImageCache.shared.setImage(identifiableUIImage, forKey: cacheKey)

            return IdentifiableUIImage(uiimage: uiimage, name: name)
        }.value
    }
}
