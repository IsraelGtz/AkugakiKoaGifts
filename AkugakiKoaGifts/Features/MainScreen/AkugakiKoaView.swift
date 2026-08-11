//
//  AkugakiKoaView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 9.8.2026.
//

import SwiftUI

struct AkugakiKoaView: View {
    var body: some View {
        ZStack {
            WaterMeshBackground()
                .ignoresSafeArea()
            List {
                Text("Who is Akugaki Koa? ↝")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(.title, design: .rounded, weight: .semibold))
                    .listRowBackground(Color.clear)

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

                text1
                    .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .listRowSpacing(0)
//            .scrollContentBackground(.hidden)
        }
    }

    @ViewBuilder
    private var text1: some View {
        buildKoaDefinitionCell(
            text: "Koa is the chaos demon who stole my heart and the hearts of many Koanikis. She inspires us with her hard work to chase her dreams, and she’s the most important to us because of the love she shares. Se le quire mucho↝ 🩵🩵🩵🩵",
            author: "HansH↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is the warm light of chaos that ignites people's souls; she scares away the darkness and replaces it with love and hope. She is the cutest demon idol who, with her hard work and perseverance, inspires us to never give up, to pursue our dreams, and to be the best version of ourselves that we can be. She is pure love, kindness, and fun. Koa BIG LOVE🩵🩵🩵🩵🩵🩵🩵🩵",
            author: "JoaquínVS↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is my inspiration on gray days, to never give up, to keep learning 🩵",
            author: "Smiling"
        )

        buildKoaDefinitionCell(
            text: "Koa is the chaos demon who stole my heart and the hearts of many Koanikis. She inspires us with her hard work to chase her dreams, and she’s the most important to us because of the love she shares. Se le quire mucho↝ 🩵🩵🩵🩵",
            author: "HansH↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is the warm light of chaos that ignites people's souls; she scares away the darkness and replaces it with love and hope. She is the cutest demon idol who, with her hard work and perseverance, inspires us to never give up, to pursue our dreams, and to be the best version of ourselves that we can be. She is pure love, kindness, and fun. Koa BIG LOVE🩵🩵🩵🩵🩵🩵🩵🩵",
            author: "JoaquínVS↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is my inspiration on gray days, to never give up, to keep learning 🩵",
            author: "Smiling"
        )

        buildKoaDefinitionCell(
            text: "Koa is the chaos demon who stole my heart and the hearts of many Koanikis. She inspires us with her hard work to chase her dreams, and she’s the most important to us because of the love she shares. Se le quire mucho↝ 🩵🩵🩵🩵",
            author: "HansH↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is the warm light of chaos that ignites people's souls; she scares away the darkness and replaces it with love and hope. She is the cutest demon idol who, with her hard work and perseverance, inspires us to never give up, to pursue our dreams, and to be the best version of ourselves that we can be. She is pure love, kindness, and fun. Koa BIG LOVE🩵🩵🩵🩵🩵🩵🩵🩵",
            author: "JoaquínVS↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is my inspiration on gray days, to never give up, to keep learning 🩵",
            author: "Smiling"
        )

        buildKoaDefinitionCell(
            text: "Koa is the chaos demon who stole my heart and the hearts of many Koanikis. She inspires us with her hard work to chase her dreams, and she’s the most important to us because of the love she shares. Se le quire mucho↝ 🩵🩵🩵🩵",
            author: "HansH↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is the warm light of chaos that ignites people's souls; she scares away the darkness and replaces it with love and hope. She is the cutest demon idol who, with her hard work and perseverance, inspires us to never give up, to pursue our dreams, and to be the best version of ourselves that we can be. She is pure love, kindness, and fun. Koa BIG LOVE🩵🩵🩵🩵🩵🩵🩵🩵",
            author: "JoaquínVS↝⛓️"
        )

        buildKoaDefinitionCell(
            text: "Koa is my inspiration on gray days, to never give up, to keep learning 🩵",
            author: "Smiling"
        )
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
    }
}

#Preview {
    AkugakiKoaView()
}
