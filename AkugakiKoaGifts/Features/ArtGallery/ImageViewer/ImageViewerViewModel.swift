//
//  ImageViewerViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 17.8.2026.
//

import KoaGiftsStorage
import Photos
import SwiftUI

@MainActor @Observable
class ImageViewerViewModel {
    var artImages: [IdentifiableUIImage] = []
    var memeImages: [IdentifiableUIImage] = []
    var gifNames: [String] = []
    var memeNames: [String] = []
    private var imageNames: [String] = []
    private let saver: ImageSaver

    init() {
        saver = .init()
        saver.successHandler = {
            print("saved successfully")
        }
        saver.errorHandler = { error in
            print(error.localizedDescription)
        }
        gifNames = getNamesOfElementsInSectionWith(title: "Gifs")
        memeNames = getNamesOfElementsInSectionWith(title: "Memes")
        imageNames = getNamesOfElementsInSectionWith(title: "Arts")
        print("images: \(imageNames)")
        print("memes: \(memeNames)")
        print("gifs: \(gifNames)")
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

    func processArtsImages(screenScale: CGFloat) async {
        Task.detached(
            name: "arts",
            priority: .userInitiated
        ) {
            let arts = await self.processImages(names: self.imageNames, screenScale: screenScale)
            Task { @MainActor in
                self.artImages = arts
            }
        }
    }

    func processMemesImages(screenScale: CGFloat) async {
        Task.detached(
            name: "memes",
            priority: .userInitiated
        ) {
            let memes = await self.processImages(names: self.memeNames, screenScale: screenScale)
            Task { @MainActor in
                self.memeImages = memes
            }
        }
    }

    private func processImages(
        names: [String],
        screenScale: CGFloat
    ) async -> [IdentifiableUIImage] {
        let targetSize = CGSize(width: 100, height: 100)
        let downscaledImages = await withTaskGroup(
            of: IdentifiableUIImage?.self,
            returning: [IdentifiableUIImage].self
        ) { taskGroup in
            for imageName in names {
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
        return downscaledImages
    }

    private func getNamesOfElementsInSectionWith(title: String) -> [String] {
        do {
            let sections = try KoaGiftsStorage.shared.fetchGallerySections()
            let names = sections.first(where: { $0.title == title })?.names ?? []
            return names
        } catch {
            print(error)
            return []
        }
    }
}
