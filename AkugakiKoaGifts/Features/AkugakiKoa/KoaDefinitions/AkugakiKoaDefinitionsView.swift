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
        VStack {
            Group {
                Text(text)
                    .font(.system(.body, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 8)
                if let author {
                    HStack {
                        Spacer()
                        Text(author)
                            .font(.system(.headline, weight: .bold))
                    }
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

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
