//
//  ArtGalleryView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.8.2026.
//

import SwiftUI

struct ArtGalleryView: View {
    @Environment(\.displayScale) var scale
    @Namespace private var zoomNamespace
    @Namespace private var galleryNamespace
    @State private var selectedImage: IdentifiableUIImage? = nil
    @State private var selectedGif: String? = nil

    @State var viewModel = ImageViewerViewModel()

    private let gridItemWidth = 100.0
    private let columns: [GridItem]

    init() {
        columns = Array(repeating: GridItem(.adaptive(minimum: gridItemWidth)), count: 3)
    }

    var body: some View {
        ZStack {
            List {
                drawsSection
                memesSection
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
            if !viewModel.artImages.isEmpty {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(viewModel.artImages) { image in
                        DrawCellView(
                            imageData: image,
                            namespace: galleryNamespace,
                            selectedImage: $selectedImage
                        )
                    }
                }
                .transition(.opacity.combined(with: .blurReplace))
            } else {
                VStack {
                    HStack {
                        Spacer()
                        ProgressView()
                            .task(id: 1, priority: .background) {
                                await viewModel.processArtsImages(screenScale: scale)
                            }
                        Spacer()
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
    private var memesSection: some View {
        Section {
            if !viewModel.memeImages.isEmpty {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(viewModel.memeImages) { image in
                        DrawCellView(
                            imageData: image,
                            namespace: galleryNamespace,
                            selectedImage: $selectedImage
                        )
                    }
                }
                .transition(.opacity.combined(with: .blurReplace))
            } else {
                VStack {
                    HStack {
                        Spacer()
                        ProgressView()
                            .task(id: 1, priority: .background) {
                                await viewModel.processMemesImages(screenScale: scale)
                            }
                        Spacer()
                    }
                }
            }
        } header: {
            Text("Memes")
                .sectionHeaderStyle()
        }
        .listRowSeparator(.hidden)
        .listSectionSeparator(.hidden)
    }

    @ViewBuilder
    private var gifsSection: some View {
        Section {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(viewModel.gifNames, id: \.self) { gif in
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
    private func zoomableImage(with image: IdentifiableUIImage) -> some View {
        Image(image.name)
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
