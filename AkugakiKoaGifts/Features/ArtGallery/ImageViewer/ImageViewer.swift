//
//  ImageViewer.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.8.2026.
//

import SwiftUI

struct ImageViewer: View {
    let image: IdentifiableImageResource
    let nameSpace: Namespace.ID
    @Binding var selectedImage: IdentifiableImageResource?
    @Binding var isItPossibleToOpenViewer: Bool

    @State private var currentScale: CGFloat = 0
    @State private var finalScale: CGFloat = 1.0
    @State private var backgroundOpacity: Double = 1.0
    @State private var currentOffset: CGSize = .zero
    @State private var finalOffset: CGSize = .zero
    @State private var isFullyExpanded: Bool = false
    private let viewModel: ImageViewerViewModel = .init()

    var body: some View {
        GeometryReader { proxy in
            buildImageWith(proxy: proxy)
                .contextMenu {
                    Button("Save in Library") {
                        viewModel.save(image: selectedImage)
                    }
                }
        }
        .background(.black.opacity(backgroundOpacity))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            backgroundOpacity = 1.0
            finalScale = 1.0
            currentOffset = .zero
            finalOffset = .zero

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                isFullyExpanded = true
            }
        }
    }

    @ViewBuilder
    private func buildImageWith(proxy: GeometryProxy) -> some View {
        if isFullyExpanded {
            Image(image.resource)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: image.id, in: nameSpace)
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
                                    // set the position based on the dragging value
                                    let verticalDistance = value.translation.height
                                    currentOffset = value.translation
                                    if finalScale <= 1 {
                                        updateBackgroundOpacityAndScale(with: verticalDistance)
                                    }
                                }
                                .onEnded { value in
                                    if finalScale >= 1.0 {
                                        updateImageOffset()
                                    }
                                    if shouldResetImagePositionAfterDrag(with: value) {
                                        resetPositionAndScale()
                                    }
                                    if shouldDismissImage(with: value) {
                                        dismissImage()
                                    }
                                }
                        )
                )
                .onTapGesture(count: 2) {
                    resetPositionAndScale()
                }
                .onDisappear {
                    dismissImage()
                }
        } else {
            Image(image.resource)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: image.id, in: nameSpace)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }

    private func shouldDismissImage(with value: DragGesture.Value) -> Bool {
        finalScale <= 1.0 &&
            value.translation.height >= 200
    }

    private func shouldResetImagePositionAfterDrag(with value: DragGesture.Value) -> Bool {
        finalScale <= 1.0 &&
            value.translation.height > -CGFloat.greatestFiniteMagnitude &&
            value.translation.height < 200
    }

    private func updateImageOffset() {
        finalOffset.width += currentOffset.width
        finalOffset.height += currentOffset.height
        currentOffset = .zero
    }

    private func updateBackgroundOpacityAndScale(with distance: CGFloat) {
        // set the backgroundOpacity based on the vertical distance
        let newBackgroundOpacity = max(0.5, 1 - (distance / 500))
        backgroundOpacity = newBackgroundOpacity

        // set the scale based on the vertical distance
        let newScale = min(1, max(0.75, 1 - (distance / 1500)))
        finalScale = newScale
    }

    private func resetPositionAndScale() {
        withAnimation(.spring()) {
            finalScale = 1.0
            finalOffset = .zero
            currentScale = 0
            currentOffset = .zero
            backgroundOpacity = 1
        }
    }

    private func dismissImage() {
        isItPossibleToOpenViewer = false
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            finalOffset = .zero
            currentOffset = .zero
            finalScale = 1.0
            backgroundOpacity = 0.0
            selectedImage = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                isItPossibleToOpenViewer = true
            }
        }
    }
}

#Preview {
    MainScreenView()
}
