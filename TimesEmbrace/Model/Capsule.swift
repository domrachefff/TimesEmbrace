import Foundation

struct Capsule: Identifiable {
    var id: UUID
    var title: String
    var text: String?
    var mediaURL: URL?
    var creationDate: Date
    var openingDate: Date
    var tag: String?
}

enum tag {
    case promise
    case love
    case friendship
}

enum CapsuleType: String, CaseIterable, Identifiable {
    case text = "Текст"
    case video = "Видео"
    case audio = "Аудио"
    
    var id: String { self.rawValue }
}
