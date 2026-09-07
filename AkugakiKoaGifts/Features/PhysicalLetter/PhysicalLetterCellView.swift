//
//  PhysicalLetterCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 4.9.2026.
//

import AudioPlayer
import KoaGiftsStorage
import SwiftUI

struct PhysicalLetterCellView: View {
    @Binding private var selectedLetter: PhysicalLetter?
    private let letter: PhysicalLetter

    init(
        selectedLetter: Binding<PhysicalLetter?>,
        letter: PhysicalLetter
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
        ZStack {
            HStack(alignment: .center) {
                Text(letter.author)
                    .frame(alignment: .leading)
                    .allowsTightening(true)
                    .titleCellStyle(
                        style: .title,
                        minimumScaleFactor: 0.9
                    )
                    .padding(.vertical)
                Spacer()
                backgroundImage
            }
        }
        .frame(height: 110)
        .clipped()
        .background(
            Color.sliderTrack.gradient,
            in: RoundedRectangle(cornerRadius: 20)
        )
    }

    @ViewBuilder
    private var backgroundImage: some View {
        Image(ImageBuilder.imageNames.randomElement() ?? "art_1")
            .scaleEffect(1.5)
            .frame(width: 135, height: 135)
            .padding(.trailing)

//        ImageBuilder.getRandomImage(
//            scaleEffect: 1.15,
//            gradientEndRadius: 63
//        )
//        .frame(width: 135, height: 135)
//        .padding(.trailing)
    }
}
