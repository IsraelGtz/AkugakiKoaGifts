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
    var audioLetters: [AudioLetter] = []
    var physicalLetters: [PhysicalLetter] = []
    var asmrs: [ASMR] = []

    init() {
        loadData()
    }

    private func loadData() {
        state = .loading
        fetchPhysicalLetters()
        fetchAudioLetters()
        fetchASMRs()
        state = .didLoad
    }

    private func fetchPhysicalLetters() {
        do {
            let physicalLetters = try storage.fetchPhysicalLetters()
            self.physicalLetters = physicalLetters
        } catch {
            state = .error(error)
        }
    }

    private func fetchAudioLetters() {
        do {
            let audioLetters = try storage.fetchAudioLetters()
            self.audioLetters = audioLetters
        } catch {
            state = .error(error)
        }
    }

    private func fetchASMRs() {
        do {
            let asmrs = try storage.fetchASMRs()
            self.asmrs = asmrs
        } catch {
            state = .error(error)
        }
    }
}
