//
//  AkugakiKoaGiftsApp.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.7.2026.
//

import SwiftUI

@main
struct AkugakiKoaGiftsApp: App {
    @State private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environment(networkMonitor)
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
