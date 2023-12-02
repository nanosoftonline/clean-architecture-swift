

import SwiftUI

@main
struct CleanArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                TodoListView()
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
