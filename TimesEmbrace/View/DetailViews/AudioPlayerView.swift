import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    let audioURL: URL
    @State private var player: AVPlayer?

    var body: some View {
        VStack {
            Button(action: {
                if player?.timeControlStatus == .playing {
                    player?.pause()
                } else {
                    player?.play()
                }
            }) {
                Text(player?.timeControlStatus == .playing ? "Пауза" : "Воспроизвести")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            player = AVPlayer(url: audioURL)
            print(" pon \(audioURL)")
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
    }
}
