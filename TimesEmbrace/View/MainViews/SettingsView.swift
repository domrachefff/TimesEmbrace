import SwiftUI

struct SettingsView: View {
    
    @AppStorage("appTheme") private var isDarkModeOn = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Тут настройки")
                Toggle("Dark mode", isOn: $isDarkModeOn)
                    .padding()
            }
                .navigationTitle("Настройки")
        }
    }
}

#Preview {
    SettingsView()
}
