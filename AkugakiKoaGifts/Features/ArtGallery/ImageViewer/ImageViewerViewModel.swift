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

    init() {
        saver = .init()
        saver.successHandler = {
            print("saved successfully")
        }
        saver.errorHandler = { error in
            print(error.localizedDescription)
        }
    }

    func save(image: IdentifiableImageResource?) {
        requestPhotoLibraryWriteAccess()
        guard
            let image
        else {
            return
        }
        saver.writeToPhotoAlbum(image: UIImage(resource: image.resource))
    }

    private func requestPhotoLibraryWriteAccess() {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)

        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    // Call your save function here
                } else {}
            }

        case .authorized, .limited:
            print("Permission already granted.")
            // Call your save function here

        case .denied, .restricted:
            print("Permission denied or restricted. Direct the user to iOS Settings.")
            // Optional: Show an alert guiding the user to App Settings

        @unknown default:
            break
        }
    }
}
