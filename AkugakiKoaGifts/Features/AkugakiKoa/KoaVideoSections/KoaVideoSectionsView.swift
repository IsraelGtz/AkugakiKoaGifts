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
    let sections: [VideoSection]

    var body: some View {
        if network.isConnected {
            Group {
                ForEach(sections) { videoSection in
                    buildVideoSection(with: videoSection)
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
    private func buildVideoSection(with section: VideoSection) -> some View {
        Section {
            ForEach(section.elements) { videoElement in
                VStack {
                    VideoSectionCellView(
                        title: videoElement.title,
                        urlString: videoElement.url
                    )
                }
            }
        } header: {
            Text(section.title)
                .font(.system(.headline, weight: .medium))
                .foregroundStyle(.letterFont)
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
