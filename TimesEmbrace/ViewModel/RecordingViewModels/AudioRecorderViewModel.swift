import SwiftUI
import AVFoundation

class AudioRecorderViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var audioFileURL: URL?
    
    private var audioRecorder: AVAudioRecorder?
    private let audioFileName = "audioRecording.m4a"
    
    init() {
        requestRecordingPermission()
    }
    
    func requestRecordingPermission() {
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { granted in
                if granted {
                    print("Запись разрешена")
                } else {
                    print("Запись запрещена")
                }
            }
        } else {
            // Старый метод для iOS < 17.0
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if granted {
                    print("Запись разрешена")
                } else {
                    print("Запись запрещена")
                }
            }
        }
    }
    
    func saveMediaToFileSystem() {
            guard let audioFileURL = audioFileURL else { return }
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let newAudioFileURL = documentsPath.appendingPathComponent(UUID().uuidString + ".m4a")
            
            do {
                try FileManager.default.copyItem(at: audioFileURL, to: newAudioFileURL)
                print("Медиа сохранено: \(newAudioFileURL)")
            } catch {
                print("Ошибка при сохранении медиа: \(error.localizedDescription)")
            }
        }
    
    func startRecording() {
        guard !isRecording else { return }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilePath = documentsPath.appendingPathComponent(audioFileName)
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFilePath, settings: settings)
            audioRecorder?.record()
            audioFileURL = audioFilePath
            isRecording = true
            
            print("Запись начата")
        } catch {
            print("Ошибка при запуске записи: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        guard isRecording else { return }
        
        audioRecorder?.stop()
        audioRecorder = nil
        isRecording = false
        saveMediaToFileSystem()
        
        print("Запись остановлена")
    }
}
