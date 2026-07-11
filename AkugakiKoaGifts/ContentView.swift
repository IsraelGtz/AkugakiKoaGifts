//
//  ContentView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.7.2026.
//

import AudioPlayer
import KoaneKoanikisLettersStorage
import SwiftUI

@Observable
class ContentViewModel {
    private let storage = KoaneKoanikisLettersStorage.shared
    var letters: [Letter] = []
    var error: Error?

    func fetchLetters() {
        do {
            let letters = try storage.fetchLetters()
            self.letters = letters
        } catch {
            self.error = error
        }
    }
}

struct ContentView: View {
    private let viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.letters) { letter in
                    NavigationLink {
                        LetterView(letter: letter)
                    } label: {
                        cell(of: letter)
                    }
                }
            }
            .onAppear {
                viewModel.fetchLetters()
            }
        }
    }

    @ViewBuilder
    private func cell(of letter: Letter) -> some View {
        VStack {
            Text(letter.name)
        }
    }
}

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
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.body)
                    .font(.headline)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                viewModel.image
                    .onScrollVisibilityChange(threshold: 0.7) { visible in
                        withAnimation(.linear(duration: 0.3)) {
                            isHalfwayVisible = visible
                        }
                    }
            }
            .padding()
        }
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

@Observable
class LetterViewModel {
    private let letter: Letter

    var title: String {
        letter.title
    }

    var body: String {
        letter.body
    }

    @ViewBuilder
    var image: some View {
        if let imageName = letter.imageName,
           let uiImage = UIImage(named: imageName)
        {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }

    init(letter: Letter) {
        self.letter = letter
    }
}

#Preview {
    ContentView()
}
