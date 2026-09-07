//
//  GiftsView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.7.2026.
//

import KoaGiftsStorage
import SwiftUI

struct GiftsView: View {
    @State private var viewModel = GiftsViewModel()
    @State private var selectedPhysicalLetter: PhysicalLetter? = nil
    @State private var selectedAudioLetter: AudioLetter? = nil
    @State private var selectedASMR: ASMR? = nil
    @Namespace private var zoomNamespace

    var body: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case .didLoad:
            giftsList
        case let .error(error):
            buildErrorView(with: error)
        }
    }

    @ViewBuilder
    private var giftsList: some View {
        List {
            physicalLettersSection
            audioLettersSection
            asmrsSection
        }
        .fullScreenCover(item: $selectedPhysicalLetter, content: { physicalLetter in
            PDFViewerView(fileName: physicalLetter.fileName)
                .navigationTransition(.zoom(sourceID: physicalLetter.id, in: zoomNamespace))
        })
        .fullScreenCover(item: $selectedAudioLetter, content: { audioLetter in
            LetterView(letter: audioLetter)
                .navigationTransition(.zoom(sourceID: audioLetter.id, in: zoomNamespace))
        })
        .fullScreenCover(item: $selectedASMR, content: { asmr in
            ASMRView(asmr: asmr)
                .navigationTransition(.zoom(sourceID: asmr.id, in: zoomNamespace))
        })
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .navigationTitle("Gifts")
        .navigationBarTitleDisplayMode(.large)
    }

    @ViewBuilder
    private var physicalLettersSection: some View {
        Section {
            ForEach(viewModel.physicalLetters) { physicalLetter in
                PhysicalLetterCellView(
                    selectedLetter: $selectedPhysicalLetter,
                    letter: physicalLetter
                )
                .matchedTransitionSource(id: physicalLetter.id, in: zoomNamespace)
            }
        } header: {
            Text("Letters")
                .sectionHeaderStyle()
        }
        .listSectionSeparator(.hidden)
    }

    @ViewBuilder
    private var audioLettersSection: some View {
        Section {
            ForEach(viewModel.audioLetters) { audioLetter in
                LetterCellView(
                    selectedLetter: $selectedAudioLetter,
                    letter: audioLetter
                )
                .matchedTransitionSource(id: audioLetter.id, in: zoomNamespace)
            }
        } header: {
            Text("Audio Letters")
                .sectionHeaderStyle()
        }
        .listSectionSeparator(.hidden)
    }

    @ViewBuilder
    private var asmrsSection: some View {
        Section {
            ForEach(viewModel.asmrs) { asmr in
                Text(asmr.title)
                    .matchedTransitionSource(id: asmr.id, in: zoomNamespace)
                    .onTapGesture {
                        selectedASMR = asmr
                    }
            }
        } header: {
            Text("ASMRs")
                .sectionHeaderStyle()
        }
        .listSectionSeparator(.hidden)
    }

    @ViewBuilder
    private func buildErrorView(with _: Error?) -> some View {
        VStack(
            alignment: .center,
            spacing: 12
        ) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
            Text("Error loading Koanes and Koanikis letters")
                .lineLimit(nil)
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
