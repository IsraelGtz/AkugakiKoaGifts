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
    case loaded(
        _ validSpecialGuestAppearances: [SpecialGuestAppearance],
        _ validLiveConcerts: [LiveConcert],
        _ validCovers: [Cover]
    )
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
            videoSectionsState = .loaded(
                sections.specialGuestAppearances,
                sections.liveConcerts,
                sections.covers
            )
            // await checkIfSectionsAreReachable(videoSections)
        } catch {
            videoSectionsState = .error(error)
        }
    }

    func checkIfSectionsAreReachable(_ sections: VideoSections) async {
        let validSpecialGuestAppearances = await withTaskGroup(
            of: SpecialGuestAppearance?.self,
            returning: [SpecialGuestAppearance].self
        ) { taskGroup in
            for specialGuestAppearance in sections.specialGuestAppearances {
                taskGroup.addTask {
                    let isReachable = await self.isURLReachable(specialGuestAppearance.url)
                    if isReachable {
                        return specialGuestAppearance
                    } else {
                        return nil
                    }
                }
            }
            var validSpecialGuestAppearances = [SpecialGuestAppearance]()
            while let reachableSpecialGuestAppearance = await taskGroup.next() {
                if let reachableSpecialGuestAppearance {
                    validSpecialGuestAppearances.append(reachableSpecialGuestAppearance)
                }
            }
            return validSpecialGuestAppearances
        }

        let validLiveConcerts = await withTaskGroup(
            of: LiveConcert?.self,
            returning: [LiveConcert].self
        ) { taskGroup in
            for liveConcert in sections.liveConcerts {
                taskGroup.addTask {
                    let isReachable = await self.isURLReachable(liveConcert.url)
                    if isReachable {
                        return liveConcert
                    } else {
                        return nil
                    }
                }
            }

            var validLiveConcerts = [LiveConcert]()
            while let reachableLiveConcert = await taskGroup.next() {
                if let reachableLiveConcert {
                    validLiveConcerts.append(reachableLiveConcert)
                }
            }
            return validLiveConcerts
        }

        let validCovers = await withTaskGroup(
            of: Cover?.self,
            returning: [Cover].self
        ) { taskGroup in
            for cover in sections.covers {
                taskGroup.addTask {
                    let isReachable = await self.isURLReachable(cover.url)
                    if isReachable {
                        return cover
                    } else {
                        return nil
                    }
                }
            }

            var validCovers = [Cover]()
            while let validCover = await taskGroup.next() {
                if let validCover {
                    validCovers.append(validCover)
                }
            }
            return validCovers
        }

        if !validSpecialGuestAppearances.isEmpty ||
            !validLiveConcerts.isEmpty ||
            !validCovers.isEmpty
        {
            videoSectionsState = .loaded(validSpecialGuestAppearances, validLiveConcerts, validCovers)
        }
    }

    private func isURLReachable(_ urlString: String) async -> Bool {
        let url = URL(string: urlString)
        guard
            let url,
            await url.isReachable()
        else {
            return false
        }
        return true
    }
}
