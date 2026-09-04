//
//  KoaVideoSectionsView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.9.2026.
//

import KoaGiftsStorage
import SwiftUI

struct KoaVideoSectionsView: View {
    @Environment(NetworkMonitor.self) private var network
    let specialGuestAppearances: [SpecialGuestAppearance]
    let liveConcerts: [LiveConcert]
    let covers: [Cover]

    init(
        specialGuestAppearances: [SpecialGuestAppearance],
        liveConcerts: [LiveConcert],
        covers: [Cover]
    ) {
        self.specialGuestAppearances = specialGuestAppearances
        self.liveConcerts = liveConcerts
        self.covers = covers
    }

    var body: some View {
        if network.isConnected {
            Group {
                if !specialGuestAppearances.isEmpty {
                    specialGuestAppearancesSection(specialGuestAppearances)
                }
                if !liveConcerts.isEmpty {
                    liveConcertsSection(liveConcerts)
                }
                if !covers.isEmpty {
                    coversSection(covers)
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listSectionSpacing(30)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func specialGuestAppearancesSection(
        _ specialGuestAppearances: [SpecialGuestAppearance]
    ) -> some View {
        Section {
            ForEach(specialGuestAppearances) { specialGuestAppearance in
                VStack {
                    VideoSectionCellView(
                        title: specialGuestAppearance.title,
                        urlString: specialGuestAppearance.url
                    )
                }
            }
        } header: {
            Text("↜ SPECIAL GUEST APPEARANCE ↝")
                .font(.system(.headline, weight: .medium))
                .foregroundStyle(.letterFont)
        }
    }

    @ViewBuilder
    private func liveConcertsSection(
        _ liveConcerts: [LiveConcert]
    ) -> some View {
        Section {
            ForEach(liveConcerts) { liveConcert in
                VideoSectionCellView(
                    title: liveConcert.title,
                    urlString: liveConcert.url
                )
            }
        } header: {
            Text("♪ LIVE CONCERTS ♪")
                .font(.system(.headline, weight: .medium))
                .foregroundStyle(.letterFont)
        }
    }

    @ViewBuilder
    private func coversSection(
        _ covers: [Cover]
    ) -> some View {
        Section {
            ForEach(covers) { cover in
                VideoSectionCellView(
                    title: cover.title,
                    urlString: cover.url
                )
            }
        } header: {
            Text("♪ COVERS ♪")
                .font(.system(.headline, weight: .medium))
                .foregroundStyle(.letterFont)
        }
    }
}
