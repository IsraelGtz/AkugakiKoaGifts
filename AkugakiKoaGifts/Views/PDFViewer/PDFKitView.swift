//
//  PDFKitView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 4.9.2026.
//

import PDFKit
import SwiftUI

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context _: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context _: Context) {
        pdfView.document = PDFDocument(url: url)
    }
}

#Preview {
    PDFViewerView(fileName: "HansHerre_physicalLetter")
}
