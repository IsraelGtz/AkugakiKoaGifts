//
//  URL+Extensions.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 4.9.2026.
//

import Foundation

public extension URL {
    func isReachable() async -> Bool {
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"
        request.timeoutInterval = 2.0

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return false }
            return (200 ... 299).contains(httpResponse.statusCode)
        } catch {
            return false
        }
    }
}
