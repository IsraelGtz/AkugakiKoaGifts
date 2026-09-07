//
//  ImageViewerViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 17.8.2026.
//

import Photos
import SwiftUI

@MainActor
class ImageViewerViewModel {
    private let saver: ImageSaver

    var uncachedImages: [UIImage] {
        ImageBuilder.imageNames.map { loadUncachedFromCatalog(name: $0) }.compactMap { $0 }
    }

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

    func save(image: IdentifiableImageResource?) {
        guard
            let image
        else {
            return
        }
        saver.writeToPhotoAlbum(image: UIImage(resource: image.resource))
    }

    func loadUncachedFromCatalog(name: String) -> UIImage? {
        guard let asset = NSDataAsset(name: name) else { return nil }
        return UIImage(data: asset.data)
    }
}
