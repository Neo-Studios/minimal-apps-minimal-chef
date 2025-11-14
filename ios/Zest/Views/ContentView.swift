import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .regular {
            // iPad or larger - use tablet layout
            TabletMainView()
        } else {
            // iPhone - use phone layout
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
