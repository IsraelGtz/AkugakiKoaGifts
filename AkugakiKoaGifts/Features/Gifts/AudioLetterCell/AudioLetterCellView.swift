//
//  AudioLetterCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 19.7.2026.
//

import AudioPlayer
import KoaGiftsStorage
import SwiftUI

struct AudioLetterCellView: View {
    @State private var size: CGSize = .zero
    @Binding var selectedLetter: AudioLetter?
    let letter: AudioLetter

    private var shouldShowAudioIcon: Bool {
        letter.audioName != nil
    }

    init(
        selectedLetter: Binding<AudioLetter?>,
        letter: AudioLetter
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
                Text(letter.name)
                    .frame(alignment: .leading)
                    .allowsTightening(true)
                    .titleCellStyle(
                        style: .title,
                        minimumScaleFactor: 0.9
                    )
                    .padding(.vertical)
                Spacer()
            }
            HStack {
                Spacer()
                RandomBackgroundImageView(imageName: ImageBuilder.randomImageName)
                    .id(1)
            }
            if shouldShowAudioIcon {
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        Image(systemName: "waveform")
                            .symbolEffect(.breathe.pulse.byLayer, options: .nonRepeating)
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(Color.koaCyan)
                            .padding(.top)
                            .padding(.trailing, 8)
                    }
                    Spacer()
                }
                .background(.clear)
            }
        }
        .frame(height: 110)
        .clipped()
        .background(
            Color.sliderTrack.gradient,
            in: RoundedRectangle(cornerRadius: 20)
        )
    }
}

#Preview {
    GiftsView()
}
