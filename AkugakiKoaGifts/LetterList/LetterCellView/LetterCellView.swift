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

    var body: some View {
        Button {
            selectedLetter = letter
        } label: {
            cellBody
        }
        .listRowSeparator(.hidden)
    }

    @ViewBuilder
    private var cellBody: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    if Bool.random() {
                        Image("koaPigtails")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72, height: 72)
                            .position(.init(x: 0, y: 0))
                    }
                    Text(letter.name)
                        .font(.system(.title, design: .rounded, weight: .regular))
                        .foregroundStyle(Color.letterFontColor)
                    if Bool.random() {
                        Image("koaStrawberry")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72, height: 72)
                            .position(.init(x: size.width, y: size.height))
                    }
                }
                .background(
                    GeometryReader { elementGeo in
                        Color.clear
                            .preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: elementGeo.frame(in: .named("scrollContainer"))
                            )
                            .onAppear {
                                size = elementGeo.size
                            }
                    }
                )
                Spacer()
            }
            .frame(minHeight: 72)
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.cyan)
        )
        .padding()
    }
}

#Preview {
    LetterListView()
}
