import SwiftUI

struct SettingsView: View {
    @State private var themeMode = "Automatic"
    @State private var notifications = true
    @State private var language = "English"
    @State private var offlineMode = true
    @State private var fontSize = "Medium"
    @State private var reducedMotion = false
    @State private var reducedTransparency = false
    @State private var highContrast = false
    @State private var colorBlindMode = "None"
    @State private var voiceOverOptimized = false
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationView {
            List {
                // General
                Section("General") {
                    NavigationLink {
                        ThemeModePickerView(themeMode: $themeMode)
                    } label: {
                        HStack {
                            Label("Theme", systemImage: "paintbrush.fill")
                            Spacer()
                            Text(themeMode)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink {
                        LanguagePickerView(language: $language)
                    } label: {
                        HStack {
                            Label("Language", systemImage: "globe")
                            Spacer()
                            Text(language)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Label("Notifications", systemImage: "bell.fill")
                        Spacer()
                        Toggle("", isOn: $notifications)
                    }
                    
                    HStack {
                        Label("Offline Mode", systemImage: "wifi.slash")
                        Spacer()
                        Toggle("", isOn: $offlineMode)
                    }
                }
                .liquidGlass()
                
                // Accessibility
                Section("Accessibility") {
                    NavigationLink {
                        FontSizePickerView(fontSize: $fontSize)
                    } label: {
                        HStack {
                            Label("Font Size", systemImage: "textformat.size")
                            Spacer()
                            Text(fontSize)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Label("Reduce Motion", systemImage: "figure.walk.motion")
                        Spacer()
                        Toggle("", isOn: $reducedMotion)
                    }
                    
                    HStack {
                        Label("Reduce Transparency", systemImage: "circle.dotted")
                        Spacer()
                        Toggle("", isOn: $reducedTransparency)
                    }
                    
                    HStack {
                        Label("High Contrast", systemImage: "circle.lefthalf.filled")
                        Spacer()
                        Toggle("", isOn: $highContrast)
                    }
                    
                    NavigationLink {
                        ColorBlindModePickerView(colorBlindMode: $colorBlindMode)
                    } label: {
                        HStack {
                            Label("Color Blind Mode", systemImage: "eyeglasses")
                            Spacer()
                            Text(colorBlindMode)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Label("VoiceOver Optimized", systemImage: "speaker.wave.3")
                        Spacer()
                        Toggle("", isOn: $voiceOverOptimized)
                    }
                }
                .liquidGlass()
                
                // Account
                Section("Account") {
                    HStack {
                        Label("Name", systemImage: "person.fill")
                        Spacer()
                        Text(authService.user?.displayName ?? "User")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label("Email", systemImage: "envelope.fill")
                        Spacer()
                        Text(authService.user?.email ?? "")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    Button(action: {
                        Task {
                            await authService.signOut()
                        }
                    }) {
                        Label("Sign Out", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
                .liquidGlass()
                
                // About
                Section("About") {
                    HStack {
                        Label("Version", systemImage: "info.circle")
                        Spacer()
                        Text("2.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label("Developer", systemImage: "hammer")
                        Spacer()
                        Text("Neo Studios")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label("License", systemImage: "doc.text")
                        Spacer()
                        Text("Neo Studios Public Repository License")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                .liquidGlass()
            }
            .navigationTitle("Settings")
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGroupedBackground))
        }
    }
}

struct FontSizePickerView: View {
    @Binding var fontSize: String
    let sizes = ["Small", "Medium", "Large", "Extra Large"]
    
    var body: some View {
        List(sizes, id: \.self) { size in
            Button(action: {
                fontSize = size
            }) {
                HStack {
                    Text(size)
                    Spacer()
                    if fontSize == size {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
            .liquidGlass()
        }
        .navigationTitle("Font Size")
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct ColorBlindModePickerView: View {
    @Binding var colorBlindMode: String
    let modes = [
        "None",
        "Protanopia (Red-Blind)",
        "Deuteranopia (Green-Blind)",
        "Tritanopia (Blue-Blind)"
    ]
    
    var body: some View {
        List(modes, id: \.self) { mode in
            Button(action: {
                colorBlindMode = mode
            }) {
                HStack {
                    Text(mode)
                    Spacer()
                    if colorBlindMode == mode {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
            .liquidGlass()
        }
        .navigationTitle("Color Blind Mode")
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct ThemeModePickerView: View {
    @Binding var themeMode: String
    let modes = ["Light", "Dark", "Automatic"]
    
    var body: some View {
        List(modes, id: \.self) { mode in
            Button(action: {
                themeMode = mode
            }) {
                HStack {
                    Text(mode)
                    Spacer()
                    if themeMode == mode {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
            .liquidGlass()
        }
        .navigationTitle("Theme")
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct LanguagePickerView: View {
    @Binding var language: String
    let languages = ["English", "Español", "Français", "Deutsch", "日本語"]
    
    var body: some View {
        List(languages, id: \.self) { lang in
            Button(action: {
                language = lang
            }) {
                HStack {
                    Text(lang)
                    Spacer()
                    if language == lang {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
            .liquidGlass()
        }
        .navigationTitle("Language")
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
