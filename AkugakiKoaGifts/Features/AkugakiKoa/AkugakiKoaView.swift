//
//  AkugakiKoaView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 9.8.2026.
//

import KoaGiftsStorage
import SwiftUI

struct AkugakiKoaView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var viewModel = AkugakiKoaViewModel()
    @State private var imageWidth: CGFloat = 0

    var body: some View {
        ZStack {
            WaterMeshBackground()
                .ignoresSafeArea()
            List {
                mainImage
                definitionsSection
                videosSection
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("↜ Who is Akugaki Koa? ↝")
            .navigationBarTitleDisplayMode(.large)
            .if(colorScheme == .light, transform: { view in
                view
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            })
        }
        .onGeometryChange(for: CGFloat.self) { proxy in
            proxy.size.width
        } action: { newValue in
            imageWidth = newValue * 0.8
        }
    }

    @ViewBuilder
    private var mainImage: some View {
        HStack {
            Spacer()
            Image(.koaMain1)
                .genericStyle(
                    gradientColors: .init(colors: [.black, .black, .black, .black, .black, .clear]),
                    gradientStartRadius: 0,
                    gradientEndRadius: imageWidth / 2
                )
                .frame(width: imageWidth, alignment: .center)
                .shadow(color: .akugakiKoaImagesShadow, radius: 15)
                .padding(.top, 8)
                .padding(.bottom)
            Spacer()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }

    @ViewBuilder
    private var definitionsSection: some View {
        switch viewModel.definitionsState {
        case .idle, .loading:
            ProgressView()
        case let .loaded(definitions):
            AkugakiKoaDefinitionsView(definitions)
                .padding(.bottom, 12)
        case let .error(error):
            VStack {
                Text("Error loading information")
                Text(error.localizedDescription)
            }
            .listRowBackground(Color.clear)
        }
    }

    @ViewBuilder
    private var videosSection: some View {
        switch viewModel.videoSectionsState {
        case .idle, .loading, .error:
            EmptyView()
        case let .loaded(sections):
            KoaVideoSectionsView(sections: sections)
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
