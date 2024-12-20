import SwiftUI

struct AudioCapsuleView: View {
    @StateObject private var viewModel = AudioRecorderViewModel()
    
    var body: some View {
        VStack {
            if let audioURL = viewModel.audioFileURL {
                Text("Файл аудио: \(audioURL.lastPathComponent)")
                    .padding()
            } else {
                Text("Нажмите для записи аудио")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                if viewModel.isRecording {
                    viewModel.stopRecording()
                    if let audioURL = viewModel.audioFileURL {
                        // Передаем URL записи в mediaURL 
                        CreateCapsuleViewModel().mediaURL = audioURL
                    }
                } else {
                    viewModel.startRecording()
                }
            }) {
                Text(viewModel.isRecording ? "Остановить запись" : "Начать запись")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isRecording ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Аудиокапсула")
        .onDisappear {
            if viewModel.isRecording {
                viewModel.stopRecording()
            }
        }
    }
}
