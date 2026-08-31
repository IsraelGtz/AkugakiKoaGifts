//
//  LetterViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 16.7.2026.
//

import KoaGiftsStorage
import SwiftUI

@Observable
class LetterViewModel {
    private let letter: Letter

    var title: String {
        letter.title
    }

    var body: String {
        letter.body
    }

    var imageName: String? {
        letter.imageName
    }

    var audioFileName: String? {
        letter.audioName
    }

    @ViewBuilder
    var image: some View {
        if let imageName = letter.imageName,
           let uiImage = UIImage(named: imageName)
        {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }

    init(letter: Letter) {
        self.letter = letter
    }
}
