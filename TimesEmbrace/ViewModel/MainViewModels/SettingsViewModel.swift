import Foundation

class SettingsViewModel: ObservableObject {
    @Published var userName: String = "User"
    @Published var selectedLanguage: String = "ru"
    
    func logOut() {
        // Логика выхода из профиля
    }
}
