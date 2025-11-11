import SwiftUI

enum ThemeMode: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
}

class ThemeViewModel: ObservableObject {
    @Published var themeMode: ThemeMode = .system
    
    var colorScheme: ColorScheme? {
        switch themeMode {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
}
