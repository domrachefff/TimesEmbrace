import SwiftUI

@main
struct TimesEmbraceApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("appTheme") private var isDarkModeOn = false

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
