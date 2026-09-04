//
//  VideoCellViewRepresentable.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.9.2026.
//

import SwiftUI
import WebKit

struct VideoCellViewRepresentable: UIViewRepresentable {
    let videoId: String

    func makeUIView(context _: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context _: Context) {
        if uiView.url != nil { return }

        let htmlString = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="referrer" content="strict-origin-when-cross-origin">
            <style>
                body, html { margin: 0; padding: 0; width: 100%; height: 100%; overflow: hidden; background-color: black; }
                iframe { width: 100%; height: 100%; border: none; }
            </style>
        </head>
        <body>
            <iframe 
                src="https://www.youtube.com/embed/\(videoId)?playsinline=1" 
                referrerpolicy="strict-origin-when-cross-origin"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                allowfullscreen>
            </iframe>
        </body>
        </html>
        """
        if let dummyURL = URL(string: "https://localhost") {
            uiView.loadHTMLString(htmlString, baseURL: dummyURL)
        } else {
            uiView.loadHTMLString(htmlString, baseURL: nil)
        }
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator _: ()) {
        uiView.stopLoading()
        guard
            let url = URL(string: "about:blank")
        else {
            return
        }
        uiView.load(URLRequest(url: url))
    }
}
