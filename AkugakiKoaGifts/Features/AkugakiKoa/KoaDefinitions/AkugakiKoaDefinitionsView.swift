//
//  AkugakiKoaDefinitionsView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.9.2026.
//

import KoaGiftsStorage
import SwiftUI

struct AkugakiKoaDefinitionsView: View {
    let definitions: [KoaDefinition]

    init(_ definitions: [KoaDefinition]) {
        self.definitions = definitions
    }

    var body: some View {
        ForEach(definitions, id: \.self) { definition in
            buildKoaDefinitionCell(
                text: definition.body,
                author: definition.author
            )
        }
    }

    @ViewBuilder
    private func buildKoaDefinitionCell(
        text: String,
        author: String?
    ) -> some View {
        VStack(spacing: 8) {
            Text(text)
                .multilineTextAlignment(.leading)
            if let author {
                HStack {
                    Spacer()
                    Text(author)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
        .linearGradientAnimationStyle()
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}
