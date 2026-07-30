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

    @State private var imageName: String = "koaPigtails"

    private let randomImageName: String? = [
        "koaPigtails",
        "koaStrawberry",
        "koaNya",
        "koaCute",
    ].randomElement()

    init(
        selectedLetter: Binding<Letter?>,
        letter: Letter
    ) {
        _selectedLetter = selectedLetter
        self.letter = letter
        if let randomImageName {
            _imageName = State(initialValue: randomImageName)
        }
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
                .font(.system(.largeTitle, design: .serif, weight: .semibold))
                .foregroundStyle(Color.koaCyan)
                .minimumScaleFactor(0.8)
                .padding()
            Spacer()
            backgroundImage
        }
        .frame(height: 120)
        .clipped()
        .background(
            Color.sliderTrack
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        )
    }

    @ViewBuilder
    private var backgroundImage: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(minWidth: 180, maxWidth: 200, minHeight: 180, maxHeight: 200)
            .clipShape(Circle())
            .mask(
                RadialGradient(
                    gradient: Gradient(colors: [.black, .black, .clear]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 100
                )
            )
    }
}

#Preview {
    LetterListView()
}
