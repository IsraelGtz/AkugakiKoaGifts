//
//  RandomBackgroundImageView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 7.9.2026.
//

import SwiftUI

struct RandomBackgroundImageView: View {
    @Environment(\.displayScale) var scale
    let imageName: String
    @State private var image: IdentifiableUIImage? = nil

    var body: some View {
        if let image {
            Image(uiImage: image.uiimage)
                .genericStyle(
                    scaleEffect: 1.35,
                    applyGradient: true,
                    gradientEndRadius: 100
                )
                .frame(width: 205, height: 205)
                .transition(.opacity.combined(with: .blurReplace))
        } else {
            ZStack {
                Color.clear
                    .task(
                        id: imageName,
                        priority: .background
                    ) {
                        Task.detached(priority: .userInitiated) {
                            let downsampledImage = await ImageBuilder.downsampleAssetCatalogJPEG(
                                named: imageName,
                                to: .init(width: 165, height: 165),
                                scale: scale
                            )
                            Task { @MainActor in
                                withAnimation {
                                    self.image = downsampledImage
                                }
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    GiftsView()
        .environment(NetworkMonitor())
}
