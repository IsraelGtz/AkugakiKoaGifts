//
//  ASMRView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 31.8.2026.
//

import AudioPlayer
import KoaGiftsStorage
import SwiftUI

struct ASMRView: View {
    let asmr: ASMR
    private let colors: [Color] = [
        .black, .indigo, .black,
        .indigo, .blue, .indigo,
        .black, .indigo, .black,
    ]

    var body: some View {
        ZStack {
            WaterMeshBackground(colors: colors)
                .ignoresSafeArea()

            VStack {
                Text(asmr.title)
                    .font(.system(.title, design: .monospaced, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.75))
            }
            VStack {
                Spacer()
                AudioPlayerView(
                    audioFileName: asmr.audioName,
                    audioFileExtension: "caf"
                )
            }
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
