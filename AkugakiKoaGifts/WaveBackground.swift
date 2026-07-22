import SwiftUI

struct WaveBackground: View {
    var body: some View {
        WaveMesh()
            .ignoresSafeArea()
    }
}

private struct WaveMesh: View {
    private let nearBlack = Color(hue: 0.68, saturation: 0.85, brightness: 0.08)
    private let royalBlue = Color(hue: 0.61, saturation: 0.80, brightness: 0.65)
    private let cyanAccent = Color(hue: 0.54, saturation: 0.65, brightness: 0.95)
    private let deepViolet = Color(hue: 0.75, saturation: 0.45, brightness: 0.70)

    private var palette: [Color] {
        [nearBlack, royalBlue, cyanAccent, deepViolet]
    }

    private var randomColor: Color {
        let index = Int.random(in: 0 ..< palette.count)
        guard
            palette.indices.contains(index)
        else {
            return cyanAccent
        }
        return palette[index]
    }

    @State private var points: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
    ]

    @State private var colors: [Color] = []

    init() {
        let initialColors = [
            randomColor, randomColor, randomColor,
            randomColor, randomColor, randomColor,
            randomColor, randomColor, randomColor,
        ]
        _colors = State(initialValue: initialColors)
    }

    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: points,
            colors: colors,
            smoothsColors: true
        )
        .onAppear {
            startRandomAnimationLoop()
        }
    }

    // Recursive smooth loop
    private func startRandomAnimationLoop() {
        let duration = Double.random(in: 3.5 ... 7.5)

        withAnimation(.easeInOut(duration: duration)) {
            points = [
                [0.0, 0.0], [Float.random(in: 0.2 ... 0.8), 0.0], [1.0, 0.0],
                [0.0, Float.random(in: 0.2 ... 0.8)], [Float.random(in: 0.2 ... 0.8), Float.random(in: 0.2 ... 0.8)], [1.0, Float.random(in: 0.2 ... 0.8)],
                [0.0, 1.0], [Float.random(in: 0.2 ... 0.8), 1.0], [1.0, 1.0],
            ]

            colors = (0 ..< 9).map { _ in palette.randomElement() ?? cyanAccent
            }
        } completion: {
            startRandomAnimationLoop()
        }
    }
}

#Preview {
    WaveBackground()
}
