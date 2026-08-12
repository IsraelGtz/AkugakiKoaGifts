//
//  AkugakiKoaViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 12.8.2026.
//

import Foundation
import KoaneKoanikisLettersStorage

enum AkugakiKoaViewState {
    case idle
    case loading
    case loaded(_ definitions: [KoaDefinition])
    case error(Error)
}

@MainActor @Observable
class AkugakiKoaViewModel {
    var state: AkugakiKoaViewState = .idle

    init() {
        getKoaDefinitions()
    }

    func getKoaDefinitions() {
        state = .loading
        do {
            let definitions = try KoaneKoanikisLettersStorage.shared.fetchDefinitions()
            state = .loaded(definitions)
        } catch {
            state = .error(error)
        }
    }
}
