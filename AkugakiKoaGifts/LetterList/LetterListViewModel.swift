//
//  LetterListViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 16.7.2026.
//

import Foundation
import KoaneKoanikisLettersStorage

@Observable
class LetterListViewModel {
    private let storage = KoaneKoanikisLettersStorage.shared
    var letters: [Letter] = []
    var error: Error?

    func fetchLetters() {
        do {
            let letters = try storage.fetchLetters()
            self.letters = letters
        } catch {
            self.error = error
        }
    }
}
