import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var settingsStore: SettingsStore
    
    var body: some View {
        NavigationView {
            List {
                // General
                Section(LocalizedStringKey("settings.general")) {
                    NavigationLink {
                        ThemeModePickerView(themeMode: $settingsStore.themeMode)
                    } label: {
                        HStack {
                            Label(LocalizedStringKey("settings.theme"), systemImage: "paintbrush.fill")
                            Spacer()
                            Text(settingsStore.themeMode)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink {
                        LanguagePickerView()
                    } label: {
                        HStack {
                            Label(LocalizedStringKey("settings.language"), systemImage: "globe")
                            Spacer()
                            Text(settingsStore.language.displayName)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.notifications"), systemImage: "bell.fill")
                        Spacer()
                        Toggle("", isOn: $settingsStore.notifications)
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.offlineMode"), systemImage: "wifi.slash")
                        Spacer()
                        Toggle("", isOn: $settingsStore.offlineMode)
                    }
                }
                .liquidGlass()
                
                // Accessibility
                Section(LocalizedStringKey("settings.accessibility")) {
                    NavigationLink {
                        FontSizePickerView(fontSize: $settingsStore.fontSize)
                    } label: {
                        HStack {
                            Label(LocalizedStringKey("settings.fontSize"), systemImage: "textformat.size")
                            Spacer()
                            Text(settingsStore.fontSize)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.reduceMotion"), systemImage: "figure.walk.motion")
                        Spacer()
                        Toggle("", isOn: $settingsStore.reducedMotion)
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.reduceTransparency"), systemImage: "circle.dotted")
                        Spacer()
                        Toggle("", isOn: $settingsStore.reducedTransparency)
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.highContrast"), systemImage: "circle.lefthalf.filled")
                        Spacer()
                        Toggle("", isOn: $settingsStore.highContrast)
                    }
                    
                    NavigationLink {
                        ColorBlindModePickerView(colorBlindMode: $settingsStore.colorBlindMode)
                    } label: {
                        HStack {
                            Label(LocalizedStringKey("settings.colorBlindMode"), systemImage: "eyeglasses")
                            Spacer()
                            Text(settingsStore.colorBlindMode)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.voiceOverOptimized"), systemImage: "speaker.wave.3")
                        Spacer()
                        Toggle("", isOn: $settingsStore.voiceOverOptimized)
                    }
                }
                .liquidGlass()
                
                // Account
                Section(LocalizedStringKey("settings.account")) {
                    HStack {
                        Label(LocalizedStringKey("settings.account.name"), systemImage: "person.fill")
                        Spacer()
                        Text(authService.user?.displayName ?? LocalizedStringKey("settings.account.user"))
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.account.email"), systemImage: "envelope.fill")
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
                        Label(LocalizedStringKey("settings.account.signOut"), systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
                .liquidGlass()
                
                // About
                Section(LocalizedStringKey("settings.about")) {
                    HStack {
                        Label(LocalizedStringKey("settings.about.version"), systemImage: "info.circle")
                        Spacer()
                        Text("2.0.0") // TODO: Get actual version
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.about.developer"), systemImage: "hammer")
                        Spacer()
                        Text("Neo Studios")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label(LocalizedStringKey("settings.about.license"), systemImage: "doc.text")
                        Spacer()
                        Text("Neo Studios Public Repository License")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                .liquidGlass()
            }
            .navigationTitle(LocalizedStringKey("settings.title"))
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
        .navigationTitle(LocalizedStringKey("settings.fontSize"))
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
        .navigationTitle(LocalizedStringKey("settings.colorBlindMode"))
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct ThemeModePickerView: View {
    @EnvironmentObject var settingsStore: SettingsStore
    let modes = ["Light", "Dark", "Automatic"]
    
    var body: some View {
        List(modes, id: \.self) { mode in
            Button(action: {
                settingsStore.themeMode = mode
            }) {
                HStack {
                    Text(LocalizedStringKey(mode))
                    Spacer()
                    if settingsStore.themeMode == mode {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
            .liquidGlass()
        }
        .navigationTitle(LocalizedStringKey("settings.theme"))
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct LanguagePickerView: View {
    @EnvironmentObject var settingsStore: SettingsStore
    
    var body: some View {
        List(Language.allCases, id: \.self) { lang in
            Button(action: {
                settingsStore.language = lang
            }) {
                HStack {
                    Text(lang.displayName)
                    Spacer()
                    if settingsStore.language == lang {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
            .liquidGlass()
        }
        .navigationTitle(LocalizedStringKey("settings.language"))
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
