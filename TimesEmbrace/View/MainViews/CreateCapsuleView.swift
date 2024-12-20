import SwiftUI

struct CreateCapsuleView: View {
    @StateObject private var viewModel = CreateCapsuleViewModel()
    
    @State private var title: String = ""
    @State private var openingDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Тип капсулы", selection: $viewModel.selectedType) {
                    ForEach(CapsuleType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Spacer()
                
                VStack {
                    switch viewModel.selectedType {
                    case .text:
                        TextCapsuleView()
                    case .audio:
                        AudioCapsuleView()
                    case .video:
                        VideoCapsuleView()
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    TextField("Название", text: $title)
                        .onSubmit {
                            hideKeyboard()
                        }
                    DatePicker("Дата открытия", selection: $openingDate, displayedComponents: .date)
                    
                    Button("Сохранить капсулу") {
                        viewModel.saveCapsule(
                            title: title,
                            text: viewModel.selectedType == .text ? viewModel.textContent : nil,
                            mediaURL: viewModel.mediaURL,
                            openingDate: openingDate,
                            creationDate: Date(),
                            tag: nil)
                        hideKeyboard()
                    }
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Создание капсулы")
        }
    }
}
