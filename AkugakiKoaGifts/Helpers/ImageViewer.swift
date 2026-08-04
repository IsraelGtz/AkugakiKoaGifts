//
//  ImageViewer.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.8.2026.
//

import SwiftUI

struct ImageViewer: View {
    let image: IdentifiableImageResource

    @State private var currentScale: CGFloat = 0
    @State private var finalScale: CGFloat = 1.0

    @State private var currentOffset: CGSize = .zero
    @State private var finalOffset: CGSize = .zero

    var body: some View {
        GeometryReader { proxy in
            buildImageWith(proxy: proxy)
                .contextMenu {
                    Button("Download") {
                        print("Downloading")
                    }
                }
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
    }

    @ViewBuilder
    private func buildImageWith(proxy: GeometryProxy) -> some View {
        Image(image.resource)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: proxy.size.width, height: proxy.size.height)
            .scaleEffect(finalScale + currentScale)
            .offset(x: finalOffset.width + currentOffset.width,
                    y: finalOffset.height + currentOffset.height)
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        // Inside onChanged, magnification maps natively to scale change
                        currentScale = value.magnification - 1
                    }
                    .onEnded { _ in
                        finalScale += currentScale
                        currentScale = 0

                        // Prevent zooming out smaller than original size
                        if finalScale < 1.0 {
                            withAnimation(.spring()) {
                                finalScale = 1.0
                                finalOffset = .zero // Reset positions
                            }
                        }
                    }
                    .simultaneously(
                        with: DragGesture()
                            .onChanged { value in
                                // Only allow dragging if the image is zoomed in
                                if finalScale > 1.0 {
                                    currentOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if finalScale > 1.0 {
                                    finalOffset.width += currentOffset.width
                                    finalOffset.height += currentOffset.height
                                    currentOffset = .zero
                                }
                            }
                    )
            )
            .onTapGesture(count: 2) {
                withAnimation(.spring()) {
                    finalScale = 1.0
                    finalOffset = .zero
                    currentScale = 0
                    currentOffset = .zero
                }
            }
    }
}

#Preview {
    ImageViewer(image: .init(.koaNya))
}
