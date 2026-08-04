//
//  LetterListViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 16.7.2026.
//

import Foundation
import KoaneKoanikisLettersStorage

@MainActor
enum LetterViewModelState {
    case idle
    case loading
    case didLoad
    case error(Error?)
}

@Observable @MainActor
class LetterListViewModel {
    private let storage = KoaneKoanikisLettersStorage.shared
    var state: LetterViewModelState = .idle
    var letters: [Letter] = []

    init() {
        fetchLetters()
    }

    func fetchLetters() {
        do {
            state = .loading
            let letters = try storage.fetchLetters()
            self.letters = letters
            state = .didLoad
        } catch {
            state = .error(error)
        }
    }
}
