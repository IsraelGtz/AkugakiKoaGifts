//
//  ImageCache.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 7.9.2026.
//

import Foundation

actor ImageCache {
    static let shared = ImageCache()
    private var cache = [String: IdentifiableUIImage]()

    func image(forKey key: String) -> IdentifiableUIImage? {
        return cache[key]
    }

    func setImage(_ image: IdentifiableUIImage, forKey key: String) {
        cache[key] = image
    }
}
