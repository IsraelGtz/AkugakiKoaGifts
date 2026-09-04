//
//  VideoSectionCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.9.2026.
//

import SwiftUI

enum VideoSectionCellState {
    case checkingIfItIsReachable
    case isReachable
    case isNotReachable
}

struct VideoSectionCellView: View {
    let title: String
    let urlString: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Spacer()
                Text(title)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.65)
                    .font(.system(.callout, weight: .semibold))
                    .padding(.top, 6)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 4)
                    .linearGradientAnimationStyle()
                Spacer()
            }
            VideoCellView(urlString: urlString)
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}
