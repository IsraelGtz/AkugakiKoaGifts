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
    
    var body: some View {
        List {
            Text(asmr.title)
        }.safeAreaInset(edge: .bottom) {
            AudioPlayerView(
                audioFileName: asmr.audioName,
                audioFileExtension: "caf"
            )
        }
    }
}
