//
//  GiftsViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 16.7.2026.
//

import Foundation
import KoaGiftsStorage

@MainActor
enum LetterViewModelState {
    case idle
    case loading
    case didLoad
    case error(Error?)
}

@Observable @MainActor
class GiftsViewModel {
    private let storage = KoaGiftsStorage.shared
    var state: LetterViewModelState = .idle
    var letters: [Letter] = []
    var asmrs: [ASMR] = []

    init() {
        loadData()
    }

    private func loadData() {
        state = .loading
        fetchLetters()
        fetchASMRs()
        state = .didLoad
    }

    private func fetchLetters() {
        do {
            let letters = try storage.fetchLetters()
            self.letters = letters
        } catch {
            print(error)
            state = .error(error)
        }
    }

    private func fetchASMRs() {
        do {
            let asmrs = try storage.fetchASMRs()
            self.asmrs = asmrs
        } catch {
            print(error)
            state = .error(error)
        }
    }
}
