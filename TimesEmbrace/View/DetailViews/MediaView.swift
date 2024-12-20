import SwiftUI
import AVKit

struct MediaView: View {
    let mediaURL: URL

    var body: some View {
        if mediaURL.pathExtension.lowercased() == "m4a" {
            AudioPlayerView(audioURL: mediaURL)
        } else {
            VideoPlayer(player: AVPlayer(url: mediaURL))
                .aspectRatio(contentMode: .fit)
        }
    }
}

