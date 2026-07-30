//
//  LetterListView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.7.2026.
//

import KoaneKoanikisLettersStorage
import SwiftUI

struct LetterListView: View {
    @State private var viewModel = LetterListViewModel()
    @State private var selectedLetter: Letter? = nil
    @Namespace private var zoomNamespace

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
            case .didLoad:
                letterList
            case let .error(error):
                buildErrorView(with: error)
            }
        }
    }

    @ViewBuilder
    private var letterList: some View {
        List {
            ForEach(viewModel.letters) { letter in
                LetterCellView(
                    selectedLetter: $selectedLetter,
                    letter: letter
                )
                .matchedTransitionSource(id: letter.id, in: zoomNamespace)
            }
        }
        .fullScreenCover(item: $selectedLetter, content: { letter in
            LetterView(letter: letter)
                .navigationTransition(.zoom(sourceID: letter.id, in: zoomNamespace))
        })
        .listStyle(.plain)
        .listRowSpacing(12)
        .background()
        .navigationTitle("Letters/Cartas")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func buildErrorView(with _: Error?) -> some View {
        VStack(
            alignment: .center,
            spacing: 12
        ) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
            Text("Error loading Koanes and Koanikis letters")
                .lineLimit(nil)
        }
    }
}

#Preview {
    LetterListView()
}
