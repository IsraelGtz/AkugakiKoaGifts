//
//  ArtGalleryView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.8.2026.
//

import SwiftUI

struct ArtGalleryView: View {
    @Namespace private var zoomNamespace
    @Namespace private var galleryNamespace
    @State private var selectedImage: IdentifiableImageResource? = nil

//    private let randomImages: [IdentifiableImageResource] = (0 ... 4).map { _ in
//        // TODO: CHECK THIS THAT IT'S NOT WORKING!!!
//        ImageBuilder.randomIdentifiableImage
//    }

    private let randomImages: [IdentifiableImageResource] = ImageBuilder.imageResources

    private let gridItemWidth = 100.0
    private let columns: [GridItem]

    init() {
        columns = Array(repeating: GridItem(.adaptive(minimum: gridItemWidth)), count: 3)
    }

    var body: some View {
        ZStack {
            List {
                LazyVGrid(columns: columns, spacing: 4) {
                    drawsSection
                    gifsSection
                }
            }
            .ignoresSafeArea(.keyboard)
            .listStyle(.plain)
            if let selectedImage {
                ImageViewer(
                    image: selectedImage,
                    nameSpace: galleryNamespace,
                    selectedImage: $selectedImage
                )
                .zIndex(1)
                .id(selectedImage.id)
                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
    }

    @ViewBuilder
    private var drawsSection: some View {
        Section {
            ForEach(ImageBuilder.imageResources) { image in
                let isSelected = selectedImage?.id == image.id
                Image(image.resource)
                    .genericStyle(
                        minSize: .init(width: gridItemWidth, height: gridItemWidth),
                        applyGradient: false
                    )
                    .opacity(isSelected ? 0 : 1)
                    .matchedGeometryEffect(
                        id: image.id,
                        in: galleryNamespace,
                        isSource: selectedImage != nil ? false : true
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                            selectedImage = image
                        }
                    }
            }
        } header: {
            Text("Draws")
                .titleCellStyle(style: .title2, color: .cyan)
        }
    }

    @ViewBuilder
    private var stickersSection: some View {
        Section {
            ForEach(
                randomImages
            ) { image in
                Image(image.resource)
                    .genericStyle(
                        minSize: .init(width: gridItemWidth, height: gridItemWidth),
                        applyGradient: false
                    )
                    .matchedTransitionSource(id: image.id, in: zoomNamespace)
                    .onTapGesture {
                        selectedImage = image
                    }
            }
        } header: {
            Text("Stickers")
                .titleCellStyle(style: .title2, color: .cyan)
                .padding(.top, 18)
        }
    }

    @ViewBuilder
    private var gifsSection: some View {
        Section {
            ForEach(1 ..< 4) { _ in
                LocalGIFViewer(name: "koaGif")
                    .aspectRatio(1, contentMode: .fill)
                    .frame(minWidth: gridItemWidth)
            }
        } header: {
            Text("Gifs")
                .titleCellStyle(style: .title2, color: .cyan)
                .padding(.top, 18)
        }
    }
}

#Preview {
    MainScreenView()
}
