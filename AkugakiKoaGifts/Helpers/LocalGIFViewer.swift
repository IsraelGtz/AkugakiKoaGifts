//
//  LocalGIFViewer.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 31.7.2026.
//

import ImageIO
import SwiftUI

struct LocalGIFViewer: UIViewRepresentable {
    let name: String

    func makeUIView(context _: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)

        guard let asset = NSDataAsset(name: name) else { return imageView }

        CGAnimateImageDataWithBlock(asset.data as CFData, nil) { [weak imageView] _, cgImage, _ in
            guard let imageView else { return }

            DispatchQueue.main.async {
                imageView.image = UIImage(cgImage: cgImage)
            }
        }
        return imageView
    }

    func updateUIView(_: UIImageView, context _: Context) {}
}
