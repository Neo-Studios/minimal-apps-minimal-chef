import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ZestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel() // Observe AuthViewModel
    @StateObject private var settingsStore = SettingsStore() // Observe SettingsStore
    @State private var showAppTour = false // State to manage flow between showcase and tour
    @State private var appLanguage: String = Locale.current.identifier // Track current app language
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isAuthenticated && authViewModel.showOnboarding {
                    if showAppTour {
                        AppTourView(
                            onSkip: {
                                if let userId = authViewModel.user?.uid {
                                    authViewModel.completeOnboarding(userId: userId)
                                }
                                showAppTour = false
                            },
                            onComplete: {
                                if let userId = authViewModel.user?.uid {
                                    authViewModel.completeOnboarding(userId: userId)
                                }
                                showAppTour = false
                            }
                        )
                    } else {
                        FeatureShowcaseView(
                            onSkip: {
                                if let userId = authViewModel.user?.uid {
                                    authViewModel.completeOnboarding(userId: userId)
                                }
                                showAppTour = false
                            },
                            onComplete: { showAppTour = true }
                        )
                    }
                } else {
                    TabView {
                        RecipesView()
                            .tabItem {
                                Label(LocalizedStringKey("Recipes"), systemImage: "book.closed.fill")
                            }
                        MealPlanView()
                            .tabItem {
                                Label(LocalizedStringKey("Meal Plan"), systemImage: "calendar")
                            }
                        ShoppingListView()
                            .tabItem {
                                Label(LocalizedStringKey("Shopping"), systemImage: "cart.fill")
                            }
                        MealKitsView()
                            .tabItem {
                                Label(LocalizedStringKey("Meal Kits"), systemImage: "shippingbox.fill")
                            }
                        CollaborativeMealPlansView()
                            .tabItem {
                                Label(LocalizedStringKey("Collab Plans"), systemImage: "person.3.fill")
                            }
                        SettingsView()
                            .tabItem {
                                Label(LocalizedStringKey("Settings"), systemImage: "gearshape.fill")
                            }
                    }
                    .font(.custom("GoogleSansFlex", size: 16))
                }
            }
            .environmentObject(authViewModel) // Provide authViewModel to the environment
            .environmentObject(settingsStore) // Provide settingsStore to the environment
            .onReceive(settingsStore.$language) { newLanguage in
                // This is a simplified approach. For a full language change,
                // the app might need to be restarted or a custom Bundle loaded.
                // For now, we'll just update the appLanguage state to trigger a view refresh.
                appLanguage = newLanguage.rawValue
            }
            .id(appLanguage) // Key to force view hierarchy refresh on language change
            .preferredColorScheme(settingsStore.themeMode == "Light" ? .light : settingsStore.themeMode == "Dark" ? .dark : nil)
        }
    }
}
