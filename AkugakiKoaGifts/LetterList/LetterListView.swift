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
    @State private var selectedLetter: Letter? = nil

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.letters) { letter in
                    LetterCellView(
                        selectedLetter: $selectedLetter,
                        letter: letter
                    )
                }
            }
            .navigationDestination(item: $selectedLetter, destination: { letter in
                LetterView(letter: letter)
            })
            .listStyle(.plain)
            .listRowSpacing(0)
            .onAppear {
                viewModel.fetchLetters()
            }
        }
    }
}

#Preview {
    LetterListView()
}
