//
//  ImageViewerViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 17.8.2026.
//

import Photos
import SwiftUI

@MainActor @Observable
class ImageViewerViewModel {
    private let saver: ImageSaver

    var images: [IdentifiableUIImage] = []

    init() {
        saver = .init()
        saver.successHandler = {
            print("saved successfully")
        }
        saver.errorHandler = { error in
            print(error.localizedDescription)
        }
    }

    func save(gif name: String) {
        saver.save(gif: name)
    }

    func save(image: IdentifiableUIImage?) {
        guard
            let image
        else {
            return
        }
        saver.writeToPhotoAlbum(image: image.uiimage)
    }

    func processImages(screenScale: CGFloat) async {
        let targetSize = CGSize(width: 100, height: 100)
        let downscaledImages = await withTaskGroup(
            of: IdentifiableUIImage?.self,
            returning: [IdentifiableUIImage].self
        ) { taskGroup in
            for imageName in ImageBuilder.imageNames {
                taskGroup.addTask {
                    await ImageBuilder.downsampleAssetCatalogJPEG(
                        named: imageName,
                        to: targetSize,
                        scale: screenScale
                    )
                }
            }

            var completedImages = [IdentifiableUIImage]()
            for await downscaledImage in taskGroup {
                if let downscaledImage {
                    completedImages.append(downscaledImage)
                }
            }
            return completedImages
        }
        Task { @MainActor in
            withAnimation {
                self.images = downscaledImages
            }
        }
    }

    private nonisolated func downsampleAssetCatalogJPEG(
        named name: String,
        to pointSize: CGSize,
        scale: CGFloat
    ) -> IdentifiableUIImage? {
        guard
            let uiImage = UIImage(named: name),
            let imageData = uiImage.jpegData(compressionQuality: 1.0)
        else {
            return nil
        }

        // Disable internal global system caching to isolate memory per background thread
        let imageOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageOptions) else { return nil }

        let maxDimension = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimension,
        ] as CFDictionary

        guard let downsampledCGImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }
        let uiimage = UIImage(cgImage: downsampledCGImage, scale: scale, orientation: .up)
        return IdentifiableUIImage(uiimage: uiimage, name: name)
    }
}
