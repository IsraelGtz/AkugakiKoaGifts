//
//  AkugakiKoaView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 9.8.2026.
//

import KoaGiftsStorage
import SwiftUI

struct AkugakiKoaView: View {
    @State private var viewModel = AkugakiKoaViewModel()

    var body: some View {
        ZStack {
            WaterMeshBackground()
                .ignoresSafeArea()
            List {
                mainImage
                switch viewModel.definitionsState {
                case .idle, .loading:
                    ProgressView()
                case let .loaded(definitions):
                    AkugakiKoaDefinitionsView(definitions)
                case let .error(error):
                    VStack {
                        Text("Error loading information")
                        Text(error.localizedDescription)
                    }
                }

                switch viewModel.videoSectionsState {
                case .idle, .loading, .error:
                    EmptyView()
                case let .loaded(
                    specialGuestAppearances,
                    liveConcerts,
                    covers
                ):
                    KoaVideoSectionsView(
                        specialGuestAppearances: specialGuestAppearances,
                        liveConcerts: liveConcerts,
                        covers: covers
                    ).id(1)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .listRowSpacing(0)
            .navigationTitle("↜ Who is Akugaki Koa? ↝")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        }
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
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
