//
//  LetterCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 19.7.2026.
//

import AudioPlayer
import KoaneKoanikisLettersStorage
import SwiftUI

private enum ImagePosition {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight

    func getCGPoint(with size: CGSize) -> CGPoint {
        switch self {
        case .topLeft:
            .init(x: 0, y: 0)
        case .topRight:
            .init(x: size.width - 72, y: 0)
        case .bottomLeft:
            .init(x: 0, y: size.height - 72)
        case .bottomRight:
            .init(x: size.width - 36, y: size.height - 36)
        }
    }
}

struct LetterCellView: View {
    @State private var size: CGSize = .zero
    @Binding var selectedLetter: Letter?
    let letter: Letter

    @State private var firstImageName: String?
    @State private var secondImageName: String?

    private let images = [
        "koaPigtails",
        "koaStrawberry",
        "koaNya",
        "koaCute",
    ]

    private var randomImageName: String? {
        return images.randomElement()
    }

    init(
        selectedLetter: Binding<Letter?>,
        letter: Letter
    ) {
        _selectedLetter = selectedLetter
        self.letter = letter
        _firstImageName = State(initialValue: images.randomElement())
        _secondImageName = State(initialValue: images.randomElement())
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
            ZStack {
                getImage(with: firstImageName, position: .topLeft)
                Text(letter.name)
                    .font(.system(.largeTitle, design: .serif, weight: .semibold))
                    .foregroundStyle(Color.koaCyan)
                getImage(with: secondImageName, position: .bottomRight)
            }
            .padding()
            .background(
                WaveBackground()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            )
            .frame(minHeight: 72)
        }
        .background(
            GeometryReader { elementGeo in
                Color.clear
                    .preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: elementGeo.frame(in: .named("scrollContainer"))
                    )
                    .task(id: elementGeo.size) {
                        size = elementGeo.size
                    }
            }
        )
        .frame(minHeight: 72)
    }

    @ViewBuilder
    private func getImage(
        with name: String?,
        position: ImagePosition
    ) -> some View {
        if let name {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .position(position.getCGPoint(with: size))
        }
    }
}

#Preview {
    LetterListView()
}
