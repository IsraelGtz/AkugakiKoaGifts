//
//  LetterCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 19.7.2026.
//

import AudioPlayer
import KoaneKoanikisLettersStorage
import SwiftUI

struct LetterCellView: View {
    @State private var size: CGSize = .zero
    @Binding var selectedLetter: Letter?
    let letter: Letter

    init(
        selectedLetter: Binding<Letter?>,
        letter: Letter
    ) {
        _selectedLetter = selectedLetter
        self.letter = letter
    }

    var body: some View {
        Button {
            selectedLetter = letter
        } label: {
            cellBody
        }
        .listRowSeparator(.hidden)
        .buttonStyle(PlainButtonStyle())
        .listRowBackground(Color.clear)
    }

    @ViewBuilder
    private var cellBody: some View {
        HStack(alignment: .center) {
            Text(letter.name)
                .titleCellStyle()
            Spacer()
            backgroundImage
        }
        .frame(height: 120)
        .clipped()
        .background(
            Color.sliderTrack.gradient,
            in: RoundedRectangle(cornerRadius: 20)
        )
    }

    @ViewBuilder
    private var backgroundImage: some View {
        ImageBuilder.getRandomImage(
            minSize: .init(width: 180, height: 180),
            maxSize: .init(width: 200, height: 200)
        )
    }
}

#Preview {
    LetterListView()
}
