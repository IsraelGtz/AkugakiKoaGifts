//
//  CreditsView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 7.9.2026.
//

import AudioPlayer
import KoaGiftsStorage
import SwiftUI

struct CreditsView: View {
    @State private var viewModel = CreditsViewModel()
    @State private var scrollOffset: CGFloat = 0
    private let colors: [Color] = [
        .koaBlue, .indigo, .blue,
        .indigo, .cyan, .indigo,
        .blue, .indigo, .cyan,
    ]

    private var waveFactor: Double {
        Double(scrollOffset) * 0.001
    }

    var body: some View {
        ZStack {
            meshGradienView
            switch viewModel.state {
            case .idle, .loading:
                loadingView
            case let .loaded(credits):
                buildCreditsView(with: credits)
            case let .error(error):
                buildErrorView(with: error)
            }
        }
        .navigationTitle("Credits")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
    }

    @ViewBuilder
    private var loadingView: some View {
        VStack(alignment: .center) {
            ProgressView()
                .task {
                    viewModel.fetchCredits()
                }
        }
    }

    @ViewBuilder
    private func buildCreditsView(with credits: [String]) -> some View {
        List {
            ForEach(credits, id: \.self) { credit in
                HStack {
                    Spacer()
                    Text(credit)
                        .foregroundStyle(.white)
                        .font(.system(.title3, weight: .semibold))
                    Spacer()
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            messageView
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(8)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            geometry.contentOffset.y
        } action: { _, newValue in
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8)) {
                scrollOffset = newValue
            }
        }
    }

    @ViewBuilder
    private var messageView: some View {
        HStack {
            Spacer()
            Text(viewModel.message)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .foregroundStyle(.white)
                .fixedSize(horizontal: true, vertical: true)
                .font(.system(.headline, weight: .regular))
                .lineLimit(10)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.top, 32)
        .padding(.bottom)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }

    @ViewBuilder
    private func buildErrorView(with _: Error?) -> some View {
        VStack(
            alignment: .center,
            spacing: 12
        ) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
            Text("Error loading credits")
                .lineLimit(nil)
        }
    }

    @ViewBuilder
    private var meshGradienView: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, Float(0.5 + sin(waveFactor) * 0.15)],
                [Float(0.5 + cos(waveFactor) * 0.2), Float(0.5 + sin(waveFactor + 1.0) * 0.2)],
                [1.0, Float(0.5 + cos(waveFactor) * 0.15)],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
            ],
            colors: [
                interpolateColor(phase: 0.0), interpolateColor(phase: 0.2), interpolateColor(phase: 0.4),
                interpolateColor(phase: 0.6), interpolateColor(phase: 0.8), interpolateColor(phase: 1.0),
                interpolateColor(phase: 1.2), interpolateColor(phase: 1.4), interpolateColor(phase: 1.6),
            ]
        )
        .ignoresSafeArea()
    }

    private func interpolateColor(phase: Double) -> Color {
        let waveValue = (sin(waveFactor + phase) + 1.0) / 2.0
        let scaledValue = waveValue * Double(colors.count - 1)
        let index = Int(scaledValue)
        let nextIndex = min(index + 1, colors.count - 1)
        let fraction = scaledValue - Double(index)
        return colors[index].mix(with: colors[nextIndex], by: fraction)
    }
}

#Preview {
    CreditsView()
}
