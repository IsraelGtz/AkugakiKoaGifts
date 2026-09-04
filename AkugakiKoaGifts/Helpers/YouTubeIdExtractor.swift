//
//  YouTubeIdExtractor.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.9.2026.
//

import Foundation

enum YouTubeIdExtractor {
    static func extractId(from urlString: String) -> String? {
        let pattern = #"((?<=(v|V)/)|(?<=be/)|(?<=(\?|\&)v=)|(?<=embed/))([\w-]{11})"#

        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return nil }
        let range = NSRange(urlString.startIndex ..< urlString.endIndex, in: urlString)

        if let match = regex.firstMatch(in: urlString, options: [], range: range) {
            if let idRange = Range(match.range(at: 0), in: urlString) {
                return String(urlString[idRange])
            }
        }
        return nil
    }
}
