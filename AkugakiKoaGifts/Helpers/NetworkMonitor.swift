//
//  NetworkMonitor.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 4.9.2026.
//

import Network
import SwiftUI

@Observable
class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    var isConnected: Bool = false

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                withAnimation {
                    self?.isConnected = (path.status == .satisfied)
                }
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
