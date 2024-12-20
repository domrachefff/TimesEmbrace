import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CapsulesListView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            CreateCapsuleView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
