//
//  ImageSaver.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 17.8.2026.
//

import Photos
import SwiftUI

enum ImageSaverError: Error {
    case noGifFile
    case denied
}

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func save(gif name: String) {
        requestPhotoLibraryWriteAccess {
            self.authorizedSave(gif: name)
        } deniedAction: {
            self.errorHandler?(ImageSaverError.denied)
        }
    }

    private func authorizedSave(gif name: String) {
        guard let data = NSDataAsset(name: name) else {
            errorHandler?(ImageSaverError.noGifFile)
            return
        }

        let gifData = data.data
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetCreationRequest.forAsset()
            request.addResource(with: .photo, data: gifData, options: nil)
        }) { _, error in
            if let error = error {
                self.errorHandler?(error)
            } else {
                self.successHandler?()
            }
        }
    }

    func writeToPhotoAlbum(image: UIImage) {
        requestPhotoLibraryWriteAccess()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_: UIImage, didFinishSavingWithError error: Error?, contextInfo _: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }

    private func requestPhotoLibraryWriteAccess(
        authorizedAction: (() -> Void)? = nil,
        deniedAction: (() -> Void)? = nil
    ) {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)

        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    authorizedAction?()
                } else {
                    deniedAction?()
                }
            }
        case .authorized, .limited:
            authorizedAction?()
        case .denied, .restricted:
            deniedAction?()
        @unknown default:
            break
        }
    }
}
