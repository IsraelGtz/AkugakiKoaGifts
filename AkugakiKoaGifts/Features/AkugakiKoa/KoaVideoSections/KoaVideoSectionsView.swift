//
//  KoaVideoSectionsView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.9.2026.
//

import KoaGiftsStorage
import SwiftUI

struct KoaVideoSectionsView: View {
    let sections: [VideoSection]

    var body: some View {
        Group {
            ForEach(sections) { videoSection in
                buildVideoSection(with: videoSection)
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listSectionSpacing(30)
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
                .sectionHeaderStyle()
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
