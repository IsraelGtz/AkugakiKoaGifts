//
//  WaterMeshBackground.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 10.8.2026.
//

import SwiftUI

struct WaterMeshBackground: View {
    private let colors: [Color]

    init(
        colors: [Color] = [
            .topLeftWaterMesh, .topCenterWaterMesh, .topRightWaterMesh,
            .middleLeftWaterMesh, .middleCenterWaterMesh, .middleRightWaterMesh,
            .bottomLeftWaterMesh, .bottomCenterWaterMesh, .bottomRightWaterMesh,
        ]
    ) {
        self.colors = colors
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate

            // Center point offsets
            let centerXShift = Float((sin(time * 0.43) * 0.10) + (cos(time * 0.17) * 0.08))
            let centerYShift = Float((cos(time * 0.37) * 0.10) + (sin(time * 0.23) * 0.08))

            // Middle Left point offsets
            let leftYShift = Float((sin(time * 0.31) * 0.09) + (cos(time * 0.13) * 0.06))

            // Middle Right point offsets
            let rightYShift = Float((cos(time * 0.47) * 0.09) + (sin(time * 0.19) * 0.06))

            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    // Top Row: Locked
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],

                    // Middle Row: Complex pseudo-random tracks
                    [0.0, 0.5 + leftYShift], [0.5 + centerXShift, 0.5 + centerYShift], [1.0, 0.5 + rightYShift],

                    // Bottom Row: Locked
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
                ],
                colors: colors
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MainScreenView()
        .environment(NetworkMonitor())
}
