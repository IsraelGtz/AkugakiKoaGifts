//
//  DrawCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 7.9.2026.
//

import SwiftUI

struct DrawCellView: View {
    let imageData: IdentifiableUIImage
    let namespace: Namespace.ID
    @Binding var selectedImage: IdentifiableUIImage?

    var body: some View {
        let isSelected = selectedImage?.id == imageData.id
        Image(uiImage: imageData.uiimage)
            .genericStyle(
                scaleEffect: 1,
                applyGradient: false
            )
            .opacity(isSelected ? 0 : 1)
            .matchedGeometryEffect(
                id: imageData.id,
                in: namespace,
                isSource: selectedImage != nil ? false : true
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
                    selectedImage = imageData
                }
            }
    }
}
