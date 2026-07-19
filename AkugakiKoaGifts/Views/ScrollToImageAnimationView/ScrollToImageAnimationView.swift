//
//  ScrollToImageAnimationView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 16.7.2026.
//

import AudioPlayer
import SwiftUI

struct ScrollToImageAnimationView: View {
    @State private var imageRect: CGRect = .zero
    @State private var scrollViewHeight: CGFloat = 0

    @State private var text: String
    @State private var imageName: String?
    @State private var backgroundColor: Color
    @State private var fadeBackgroundColor: Color

    init(
        text: String,
        imageName: String?,
        backgroundColor: Color = .cyan,
        fadeBackgroundColor: Color = .clear
    ) {
        self.text = text
        self.imageName = imageName
        self.backgroundColor = backgroundColor
        self.fadeBackgroundColor = fadeBackgroundColor
    }

    /// Define how long the color transition takes (e.g., finishes when image is 200px on screen)
    @State private var animationDuration: CGFloat = 0

    // Calculates color transition progress from 0.0 to 1.0
    var transitionProgress: CGFloat {
        guard
            scrollViewHeight > 0,
            imageName != nil
        else {
            return 0
        }

        // Distance remaining until the image is fully scrolled into view
        let distanceRemaining = imageRect.minY - scrollViewHeight
        if distanceRemaining > 0 {
            return 0 // Image is still below the screen fold
        } else {
            // Map the intersection distance to a 0.0 -> 1.0 range
            let progress = -distanceRemaining / animationDuration
            return max(0, min(progress, 1.0))
        }
    }

    var body: some View {
        ZStack {
            backgroundColor.mix(
                with: fadeBackgroundColor,
                by: transitionProgress
            )
            .ignoresSafeArea()

            // Track the total visible height of the ScrollView container
            GeometryReader { containerGeo in
                ScrollView {
                    VStack(spacing: 20) {
                        Text(text)
                            .font(.system(.title3, design: .rounded, weight: .regular))
                            .foregroundStyle(Color.letterFontColor)
                            .padding()

                        if let name = imageName {
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .background(
                                    // Hidden geometry reader to capture the image's layout bounds
                                    GeometryReader { elementGeo in
                                        Color.clear
                                            .preference(
                                                key: ScrollOffsetPreferenceKey.self,
                                                value: elementGeo.frame(in: .named("scrollContainer"))
                                            )
                                            .onAppear {
                                                animationDuration = elementGeo.size.height
                                            }
                                    }
                                )
                                .padding(.bottom, 50)
                        }
                    }
                }
                .coordinateSpace(name: "scrollContainer")
                .onAppear {
                    scrollViewHeight = containerGeo.size.height
                }
                // Handle dynamic screen resizing or rotations safely
                .onChange(of: containerGeo.size.height) { _, newHeight in
                    scrollViewHeight = newHeight
                }
            }
            // Listen for changes to the target element's frame position
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { rect in
                imageRect = rect
            }
        }
    }
}

#Preview {
    ScrollToImageAnimationView(
        text: """
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
           asfd dfiahdfk adkfha dfiuhagdkuhfa kdhfka df \naskdfhkdsj af adfijadiflh akdahlf ldsf\n alkdfhlakidhuoiaugdkjad fklahd lkjahdsufai dlqjewokalds;f alkdhf lakdhl fkjahd f\n\n
        """,
        imageName: "testImage",
        backgroundColor: .cyanCrystal.opacity(0.25),
        fadeBackgroundColor: .letterFadeBackgroundColor
    )
}
