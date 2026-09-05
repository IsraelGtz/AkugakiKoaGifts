//
//  AkugakiKoaViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 12.8.2026.
//

import Foundation
import KoaGiftsStorage

enum AkugakiKoaDefinitionsState {
    case idle
    case loading
    case loaded(_ definitions: [KoaDefinition])
    case error(Error)
}

enum AkugakiKoaVideosState {
    case idle
    case loading
    case loaded(_ sections: [VideoSection])
    case error(Error)
}

@MainActor @Observable
class AkugakiKoaViewModel {
    var definitionsState: AkugakiKoaDefinitionsState = .idle
    var videoSectionsState: AkugakiKoaVideosState = .idle

    init() {
        getKoaDefinitions()
        getVideoSections()
    }

    func getKoaDefinitions() {
        definitionsState = .loading
        do {
            let definitions = try KoaGiftsStorage.shared.fetchDefinitions()
            definitionsState = .loaded(definitions)
        } catch {
            definitionsState = .error(error)
        }
    }

    func getVideoSections() {
        videoSectionsState = .idle
        do {
            let sections = try KoaGiftsStorage.shared.fetchVideoSections()
            videoSectionsState = .loaded(sections)
        } catch {
            videoSectionsState = .error(error)
        }
    }
}
