//
//  CreditsViewModel.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 7.9.2026.
//

import Foundation
import KoaGiftsStorage

enum CreditsViewState {
    case idle
    case loading
    case loaded(_ credits: [String])
    case error(Error)
}

@MainActor @Observable
class CreditsViewModel {
    let message: String =
        """
            Thanks for being our reason to be better.
            Thanks for holding our hands.
            Thanks for never give up.
            Thanks for being alive and staying with us.
            Thanks for all you do for us,\neven the things we don't see.
            Thanks for everything!.
            WE LOVE YOU!!
            🩵🩵🩵🩵🩵🩵🩵🩵↝
        """
    var state: CreditsViewState = .idle

    func fetchCredits() {
        do {
            state = .loading
            let credits = try KoaGiftsStorage.shared.fetchCredits()
            state = .loaded(credits)
        } catch {
            state = .error(error)
        }
    }
}
