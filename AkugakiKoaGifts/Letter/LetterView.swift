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

//        ScrollView {
//            VStack(alignment: .leading, spacing: 12) {
//                Text(viewModel.body)
//                    .font(.headline)
//                    .lineLimit(nil)
//                    .multilineTextAlignment(.leading)
//                viewModel.image
//                    .onScrollVisibilityChange(threshold: 0.7) { visible in
//                        withAnimation(.linear(duration: 0.3)) {
//                            isHalfwayVisible = visible
//                        }
//                    }
//            }
//            .padding()
//        }
        .safeAreaInset(edge: .bottom) {
            AudioPlayerView(
                audioFileName: "test",
                audioFileExtension: "caf"
            )
        }
        .background(backgroundColor)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
    }
}
