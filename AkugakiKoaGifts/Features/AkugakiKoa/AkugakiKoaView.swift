//
//  AkugakiKoaView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 9.8.2026.
//

import KoaneKoanikisLettersStorage
import SwiftUI

struct AkugakiKoaView: View {
    @State private var viewModel = AkugakiKoaViewModel()

    var body: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case let .loaded(definitions):
            buildListOfDefinitions(definitions)
        case let .error(error):
            VStack {
                Text("Error loading information")
                Text(error.localizedDescription)
            }
        }
    }

    @ViewBuilder
    private func buildListOfDefinitions(
        _ definitions: [KoaDefinition]
    ) -> some View {
        ZStack {
            WaterMeshBackground()
                .ignoresSafeArea()
            List {
                title
                mainImage
                ForEach(definitions, id: \.self) { definition in
                    buildKoaDefinitionCell(
                        text: definition.body,
                        author: definition.author
                    )
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .listRowSpacing(0)
        }
    }

    @ViewBuilder
    private var title: some View {
        Text("Who is Akugaki Koa? ↝")
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(.title, design: .rounded, weight: .semibold))
            .listRowBackground(Color.clear)
    }

    @ViewBuilder
    private var mainImage: some View {
        Image(.koaMain1)
            .genericStyle(
                gradientColors: .init(colors: [.black, .black, .black, .black, .black, .clear]),
                gradientStartRadius: 0,
                gradientEndRadius: 195
            )
            .shadow(color: .akugakiKoaImagesShadow, radius: 15)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.top, 8)
            .padding(.bottom, 12)
    }

    @ViewBuilder
    private func buildKoaDefinitionCell(
        text: String,
        author: String?
    ) -> some View {
        VStack {
            Text(text)
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

#Preview {
    MainScreenView()
}
