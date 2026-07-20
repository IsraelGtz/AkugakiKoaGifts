//
//  LetterCellPreferenceKey.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 20.7.2026.
//

import SwiftUI

struct LetterCellPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
