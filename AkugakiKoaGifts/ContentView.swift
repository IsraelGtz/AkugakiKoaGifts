//
//  ContentView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.7.2026.
//

import SwiftUI
import AudioPlayer

struct ContentView: View {
    var body: some View {
        VStack {
            Text("")
            Spacer()
            AudioPlayerView(
                audioFileName: "test",
                audioFileExtension: "caf"
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
