//
//  LetterView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 16.7.2026.
//

import AudioPlayer
import KoaneKoanikisLettersStorage
import SwiftUI

struct LetterView: View {
    @State var viewModel: LetterViewModel

    @State private var isHalfwayVisible: Bool = false
    private var backgroundColor: Color {
        isHalfwayVisible ? Color.blue.opacity(0.2) : Color.clear
    }

    init(letter: Letter) {
        viewModel = LetterViewModel(letter: letter)
    }

    var body: some View {
        ScrollToImageAnimationView(
            text: viewModel.body,
            imageName: viewModel.imageName,
            backgroundColor: .letterBackgroundColor,
            fadeBackgroundColor: .letterFadeBackgroundColor
        )
        .safeAreaInset(edge: .bottom) {
            AudioPlayerView(
                audioFileName: "test",
                audioFileExtension: "caf"
            )
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
    }
}
