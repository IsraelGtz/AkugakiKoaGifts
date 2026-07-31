//
//  AkugakiKoaGiftsApp.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.7.2026.
//

import SwiftUI

@main
struct AkugakiKoaGiftsApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView()
        }
    }
}

struct MainScreenView: View {
    var body: some View {
        TabView {
            Tab("Letters", systemImage: "envelope") {
                LetterListView()
            }

            Tab("Art", systemImage: "paintpalette") {
//                MainArtView()
                ArtGalleryView()
            }

            Tab("Credits", systemImage: "person.3") {
                Text("Credits")
            }
        }
    }
}

struct MainArtView: View {
    private let artsType: [String] = ["Draws", "Tales", "Music"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(artsType, id: \.self) { type in
                    Text(type)
                }
            }
        }
    }
}

struct ArtGalleryView: View {
    private let gridItemWidth = 100.0
    private let columns: [GridItem]

    init() {
        columns = Array(repeating: GridItem(.adaptive(minimum: gridItemWidth)), count: 3)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 4) {
                Section {
                    ForEach(1 ..< 25) { _ in
                        ImageBuilder.getRandomImage(
                            minSize: .init(width: gridItemWidth, height: gridItemWidth),
                            applyGradient: false
                        )
                    }
                } header: {
                    Text("Draws")
                        .titleCellStyle(style: .title2, color: .cyan)
                }

                Section {
                    ForEach(1 ..< 25) { _ in
                        ImageBuilder.getRandomImage(
                            minSize: .init(width: gridItemWidth, height: gridItemWidth),
                            applyGradient: false
                        )
                    }
                } header: {
                    Text("Stickers")
                        .titleCellStyle(style: .title2, color: .cyan)
                        .padding(.top, 18)
                }

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
        .padding()
    }
}

#Preview {
    MainScreenView()
}
