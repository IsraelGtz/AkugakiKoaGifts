//
//  WaterMeshBackground.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 10.8.2026.
//

import SwiftUI

struct WaterMeshBackground: View {
//    private let colors: [Color] = [
//        .teal, .blue, .cyan,
//        .blue, .indigo, .teal,
//        .cyan, .teal, .indigo
//    ]

    private let colors: [Color] = [
        .topLeftWaterMesh, .topCenterWaterMesh, .topRightWaterMesh,
        .middleLeftWaterMesh, .middleCenterWaterMesh, .middleRightWaterMesh,
        .bottomLeftWaterMesh, .bottomCenterWaterMesh, .bottomRightWaterMesh,
    ]

//    private let colors: [Color] = [
//        .gray.opacity(0.1), .black.opacity(0.65) , .cyan,
//        .gray.opacity(0.4), .black.opacity(0.5) , .blue,
//        .gray.opacity(0.6), .black.opacity(0.35) , .teal,
//    ]

    private var randomColor: Color {
        colors.randomElement() ?? .cyan
    }

    var body: some View {
        // Restricted to 30 FPS to save battery and processing power
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate

            // Keeps the movement localized and fluid
            let xShift = Float(sin(time * 0.6) * 0.12)
            let yShift = Float(cos(time * 0.5) * 0.12)

            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    // Top Row: Completely locked at the edges
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],

                    // Middle Row: Left/Right locked, Center floats fluidly
                    [0.0, 0.5], [0.5 + xShift, 0.5 + yShift], [1.0, 0.5],

                    // Bottom Row: Completely locked at the edges
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
                ],
                colors: colors
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    AkugakiKoaView()
}
