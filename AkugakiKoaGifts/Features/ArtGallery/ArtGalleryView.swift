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
    @State private var selectedGif: String? = nil

    private let viewModel = ImageViewerViewModel()
    private let gifNames: [String] = ["koaGif", "chaosInSmallDoses720"]

    private let gridItemWidth = 100.0
    private let columns: [GridItem]

    init() {
        columns = Array(repeating: GridItem(.adaptive(minimum: gridItemWidth)), count: 3)
    }

    var body: some View {
        ZStack {
            List {
                drawsSection
                gifsSection
            }
            .ignoresSafeArea(.keyboard)
            .listStyle(.plain)

            if let selectedImage {
                zoomableImage(with: selectedImage)
            }
            if let selectedGif {
                zoomableGif(with: selectedGif)
                    .id(selectedGif)
                    .compositingGroup()
            }
        }
        .navigationTitle("Gallery")
        .navigationBarTitleDisplayMode(.large)
    }

    @ViewBuilder
    private var drawsSection: some View {
        Section {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(ImageBuilder.imageResources) { image in
                    let isSelected = selectedImage?.id == image.id
                    Image(image.resource)
                        .genericStyle(
                            scaleEffect: 1,
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
            }
        } header: {
            Text("Draws")
                .sectionHeaderStyle()
        }
        .listRowSeparator(.hidden)
        .listSectionSeparator(.hidden)
    }

    @ViewBuilder
    private var gifsSection: some View {
        Section {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(gifNames, id: \.self) { gif in
                    let isSelected = selectedGif == gif
                    LocalGIFViewer(name: gif)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(minWidth: gridItemWidth)
                        .contentShape(Rectangle())
                        .opacity(isSelected ? 0 : 1)
                        .matchedGeometryEffect(
                            id: gif,
                            in: galleryNamespace,
                            isSource: selectedGif != nil ? false : true
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                                selectedGif = gif
                            }
                        }
                }
            }
        } header: {
            Text("Gifs")
                .sectionHeaderStyle()
        }
        .listRowSeparator(.hidden)
        .listSectionSeparator(.hidden)
    }

    @ViewBuilder
    private func zoomableImage(with image: IdentifiableImageResource) -> some View {
        Image(image.resource)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .zIndex(1)
            .id(image.id)
            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            .toolbarVisibility(.hidden, for: .tabBar)
            .matchedGeometryEffect(id: image.id, in: galleryNamespace, isSource: false)
            .zoomable(contextMenu: .init(title: "Save Image", action: {
                viewModel.save(image: image)
            }), dismissAction: {
                selectedImage = nil
            })
    }

    @ViewBuilder
    private func zoomableGif(with name: String) -> some View {
        LocalGIFViewer(name: name)
            .aspectRatio(1, contentMode: .fit)
            .contentShape(Rectangle())
            .zIndex(1)
            .id(name)
            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            .toolbarVisibility(.hidden, for: .tabBar)
            .matchedGeometryEffect(id: name, in: galleryNamespace, isSource: false)
            .zoomable(contextMenu: .init(title: "Save Image", action: {
                viewModel.save(gif: name)
            }), dismissAction: {
                selectedGif = nil
            })
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
