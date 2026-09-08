//
//  ASMRCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 7.9.2026.
//

import AudioPlayer
import KoaGiftsStorage
import SwiftUI

struct ASMRCellView: View {
    @State private var size: CGSize = .zero
    @Binding var selectedASMR: ASMR?
    let asmr: ASMR

    init(
        selectedASMR: Binding<ASMR?>,
        asmr: ASMR
    ) {
        _selectedASMR = selectedASMR
        self.asmr = asmr
    }

    var body: some View {
        Button {
            selectedASMR = asmr
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
                Text(asmr.name)
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
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    Image(systemName: "waveform")
                        .symbolEffect(.breathe.pulse.byLayer, options: .nonRepeating)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                }
                Spacer()
                    .frame(height: 65)
            }
            .background(.clear)
            .zIndex(2)
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
