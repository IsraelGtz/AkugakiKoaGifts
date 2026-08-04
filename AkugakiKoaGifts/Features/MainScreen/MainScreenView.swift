//
//  MainScreenView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.8.2026.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        TabView {
            Tab("Koa", image: "koaTabIcon") {
                Text("info")
            }
            Tab("Letters", systemImage: "envelope") {
                LetterListView()
            }

            Tab("Art", systemImage: "paintpalette") {
                ArtGalleryView()
            }

            Tab("Credits", systemImage: "person.3") {
                ImageViewer(image: .init(.koaNya))
            }
        }
    }
}
