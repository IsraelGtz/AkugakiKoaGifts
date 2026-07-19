//
//  ScrollOffsetPreferenceKey.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 19.7.2026.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
