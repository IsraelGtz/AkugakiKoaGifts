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
            Tab("Akugaki Koa", image: "koaTabIcon") {
                NavigationStack {
                    AkugakiKoaView()
                }
            }
            Tab("Gifts", systemImage: "gift.fill") {
                NavigationStack {
                    GiftsView()
                }
            }

            Tab("Gallery", systemImage: "paintpalette") {
                NavigationStack {
                    ArtGalleryView()
                }
            }

            Tab("Credits", systemImage: "person.3") {
                NavigationStack {
                    CreditsView()
                }
            }
        }
    }
}

#Preview {
    MainScreenView()
}
