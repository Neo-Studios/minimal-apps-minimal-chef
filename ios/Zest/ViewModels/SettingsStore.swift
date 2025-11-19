import Foundation
import Combine

class SettingsStore: ObservableObject {
    @Published var themeMode: String {
        didSet {
            UserDefaults.standard.set(themeMode, forKey: "themeMode")
        }
    }
    
    @Published var notifications: Bool {
        didSet {
            UserDefaults.standard.set(notifications, forKey: "notifications")
        }
    }
    
    @Published var language: Language {
        didSet {
            UserDefaults.standard.set(language.rawValue, forKey: "language")
        }
    }
    
    @Published var offlineMode: Bool {
        didSet {
            UserDefaults.standard.set(offlineMode, forKey: "offlineMode")
        }
    }
    
    @Published var fontSize: String {
        didSet {
            UserDefaults.standard.set(fontSize, forKey: "fontSize")
        }
    }
    
    @Published var reducedMotion: Bool {
        didSet {
            UserDefaults.standard.set(reducedMotion, forKey: "reducedMotion")
        }
    }
    
    @Published var reducedTransparency: Bool {
        didSet {
            UserDefaults.standard.set(reducedTransparency, forKey: "reducedTransparency")
        }
    }
    
    @Published var highContrast: Bool {
        didSet {
            UserDefaults.standard.set(highContrast, forKey: "highContrast")
        }
    }
    
    @Published var colorBlindMode: String {
        didSet {
            UserDefaults.standard.set(colorBlindMode, forKey: "colorBlindMode")
        }
    }
    
    @Published var voiceOverOptimized: Bool {
        didSet {
            UserDefaults.standard.set(voiceOverOptimized, forKey: "voiceOverOptimized")
        }
    }
    
    init() {
        self.themeMode = UserDefaults.standard.string(forKey: "themeMode") ?? "Automatic"
        self.notifications = UserDefaults.standard.bool(forKey: "notifications")
        self.language = Language(rawValue: UserDefaults.standard.string(forKey: "language") ?? Language.english.rawValue) ?? .english
        self.offlineMode = UserDefaults.standard.bool(forKey: "offlineMode")
        self.fontSize = UserDefaults.standard.string(forKey: "fontSize") ?? "Medium"
        self.reducedMotion = UserDefaults.standard.bool(forKey: "reducedMotion")
        self.reducedTransparency = UserDefaults.standard.bool(forKey: "reducedTransparency")
        self.highContrast = UserDefaults.standard.bool(forKey: "highContrast")
        self.colorBlindMode = UserDefaults.standard.string(forKey: "colorBlindMode") ?? "None"
        self.voiceOverOptimized = UserDefaults.standard.bool(forKey: "voiceOverOptimized")
    }
}
