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
    @State private var selectedLetter: Letter? = nil
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
            lettersSection
            asmrsSection
        }
        .fullScreenCover(item: $selectedLetter, content: { letter in
            LetterView(letter: letter)
                .navigationTransition(.zoom(sourceID: letter.id, in: zoomNamespace))
        })
        .fullScreenCover(item: $selectedASMR, content: { asmr in
            ASMRView(asmr: asmr)
                .navigationTransition(.zoom(sourceID: asmr.id, in: zoomNamespace))
        })
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .listRowSpacing(12)
        .navigationTitle("Gifts")
        .navigationBarTitleDisplayMode(.large)
    }

    @ViewBuilder
    private var lettersSection: some View {
        Section {
            ForEach(viewModel.letters) { letter in
                LetterCellView(
                    selectedLetter: $selectedLetter,
                    letter: letter
                )
                .matchedTransitionSource(id: letter.id, in: zoomNamespace)
            }
        } header: {
            Text("Letters")
                .font(.system(.headline))
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
                .font(.system(.headline))
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
    GiftsView()
}
