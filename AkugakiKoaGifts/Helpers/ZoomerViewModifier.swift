//
//  ZoomerViewModifier.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 26.8.2026.
//

import SwiftUI

extension View {
    func zoomable(
        contextMenu: ZoomableContextMenu,
        dismissAction: (() -> Void)? = nil
    ) -> some View {
        modifier(
            ZoomerModifier(
                contextMenu: contextMenu,
                dismissAction: dismissAction
            )
        )
    }
}

struct ZoomableContextMenu {
    let title: String
    let action: (() -> Void)?
}

struct ZoomerModifier: ViewModifier {
    let contextMenu: ZoomableContextMenu
    let dismissAction: (() -> Void)?

    @GestureState private var currentScale: CGFloat = 1
    @GestureState private var currentOffset: CGSize = .zero
    @State private var finalScale: CGFloat = 1.0
    @State private var finalOffset: CGSize = .zero
    @State private var backgroundOpacity: Double = 1.0
    private let viewModel: ImageViewerViewModel = .init()

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .frame(width: proxy.size.width, height: proxy.size.height)
                .contentShape(Rectangle())
                .scaleEffect(finalScale * currentScale)
                .offset(
                    x: finalOffset.width + currentOffset.width,
                    y: finalOffset.height + currentOffset.height
                )
                .gesture(
                    MagnifyGesture()
                        .updating($currentScale, body: { value, state, _ in
                            state = value.magnification
                        })
                        .onEnded { value in
                            finalScale *= value.magnification
                            // Prevent zooming out smaller than original size
                            if finalScale < 1.0 {
                                withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                                    finalScale = 1.0
                                    finalOffset = .zero
                                }
                            }
                        }
                        .simultaneously(
                            with: DragGesture()
                                .updating($currentOffset, body: { value, state, _ in
                                    state = value.translation
                                })
                                .onChanged { value in
                                    let verticalDistance = value.translation.height
                                    if finalScale <= 1 {
                                        updateBackgroundOpacityAndScale(with: verticalDistance)
                                    }
                                }
                                .onEnded { value in
                                    if finalScale > 1.0 {
                                        // If there is any scale applied just move
                                        updateImageOffset(with: value.translation)
                                    }
                                    if shouldResetImagePositionAfterDrag(with: value) {
                                        // Applied when the image, with no scale applied is moved around
                                        finalOffset = value.translation
                                        resetPositionAndScale()
                                    }
                                    if shouldDismissImage(with: value) {
                                        dismissImage()
                                    }
                                }
                        )
                )
                .contextMenu {
                    Button(contextMenu.title) {
                        contextMenu.action?()
                    }
                }
        }
        .background(.black.opacity(backgroundOpacity))
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(count: 2) {
            resetPositionAndScale()
        }
        .onAppear {
            backgroundOpacity = 1.0
        }
    }

    private func shouldDismissImage(with value: DragGesture.Value) -> Bool {
        finalScale <= 1.0 &&
            value.translation.height >= 200
    }

    private func shouldResetImagePositionAfterDrag(
        with value: DragGesture.Value
    ) -> Bool {
        finalScale <= 1.0 &&
            value.translation.height > -CGFloat.greatestFiniteMagnitude &&
            value.translation.height < 200
    }

    private func updateImageOffset(with translation: CGSize) {
        finalOffset.width += translation.width
        finalOffset.height += translation.height
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
        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
            finalScale = 1.0
            finalOffset = .zero
            backgroundOpacity = 1
        }
    }

    private func dismissImage() {
        dismissAction?()
        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
            backgroundOpacity = 0.0
        }
    }
}
