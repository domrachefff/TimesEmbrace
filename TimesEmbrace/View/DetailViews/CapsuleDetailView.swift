import SwiftUI

struct CapsuleDetailView: View {
    let capsule: CapsuleEntity

    var body: some View {
        VStack {
            if let text = capsule.text, !text.isEmpty {
                Text(text)
                    .font(.body)
                    .padding()
            } else if let mediaURL = capsule.mediaURL {
                MediaView(mediaURL: mediaURL)
            } else {
                Text("Содержимое отсутствует.")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(capsule.title ?? "Капсула")
        .navigationBarTitleDisplayMode(.inline)
    }
}
