//
//  LetterListView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.7.2026.
//

import KoaneKoanikisLettersStorage
import SwiftUI

struct LetterListView: View {
    private let viewModel = LetterListViewModel()

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

#Preview {
    LetterListView()
}
