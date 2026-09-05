//
//  PDFViewerView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 4.9.2026.
//

import SwiftUI

struct PDFViewerView: View {
    let fileName: String

    var body: some View {
        if let pdfUrl = Bundle.main.url(
            forResource: fileName,
            withExtension: "pdf"
        ) {
            PDFKitView(url: pdfUrl)
        } else {
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                Text("Could not find or load asset: \(fileName)")
            }
            .task {
                if let pdfUrl = Bundle.main.url(
                    forResource: fileName,
                    withExtension: "pdf"
                ) {
                    // Successfully retrieved the PDF URL
                    print("FOUND BIATCHESsdgdgf")
                    print(pdfUrl)
                }
            }
        }
    }
}
