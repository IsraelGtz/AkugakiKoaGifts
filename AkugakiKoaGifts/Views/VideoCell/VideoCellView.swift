//
//  VideoCellView.swift
//  AkugakiKoaGifts
//
//  Created by Israel Gutiérrez Castillo on 3.9.2026.
//

import SwiftUI

struct VideoCellView: View {
    @State private var isPlaying: Bool = false
    @State private var thumbnailURLString: String = ""
    private let videoId: String

    init(urlString: String) {
        let videoId = YouTubeIdExtractor.extractId(from: urlString) ?? ""
        self.videoId = videoId
    }

    var body: some View {
        if videoId.isEmpty {
            noVideoView
        } else {
            VStack {
                if isPlaying {
                    VideoCellViewRepresentable(videoId: videoId)
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .cornerRadius(12)
                } else {
                    Button(action: { isPlaying = true }) {
                        ZStack {
                            if let url = URL(string: thumbnailURLString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(height: 200)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.black.opacity(0.1))

                                    case let .success(image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 200)
                                            .clipped()

                                    case .failure:
                                        Color.clear
                                            .onAppear {
                                                let fallback = "https://img.youtube.com/vi/\(videoId)/hqdefault.jpg"
                                                if thumbnailURLString != fallback {
                                                    thumbnailURLString = fallback
                                                }
                                            }

                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .cornerRadius(12)
                            } else {
                                Color.black
                                    .frame(height: 200)
                                    .cornerRadius(12)
                            }

                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .onFirstAppear {
                if thumbnailURLString.isEmpty {
                    thumbnailURLString = "https://img.youtube.com/vi/\(videoId)/maxresdefault.jpg"
                }
            }
        }
    }

    @ViewBuilder
    private var noVideoView: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundStyle(.yellow)
                    .padding(.bottom)
                Text("Unable to find the video")
                    .font(.title3)
            }
            Spacer()
        }
        .padding()
    }
}
