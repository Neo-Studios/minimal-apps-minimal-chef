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
    @State private var showAppTour = false // State to manage flow between showcase and tour
    
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
                                Label("Recipes", systemImage: "book.closed.fill")
                            }
                        MealPlanView()
                            .tabItem {
                                Label("Meal Plan", systemImage: "calendar")
                            }
                        ShoppingListView()
                            .tabItem {
                                Label("Shopping", systemImage: "cart.fill")
                            }
                        MealKitsView()
                            .tabItem {
                                Label("Meal Kits", systemImage: "shippingbox.fill")
                            }
                        CollaborativeMealPlansView()
                            .tabItem {
                                Label("Collab Plans", systemImage: "person.3.fill")
                            }
                        SettingsView()
                            .tabItem {
                                Label("Settings", systemImage: "gearshape.fill")
                            }
                    }
                    .font(.custom("GoogleSansFlex", size: 16))
                }
            }
            .environmentObject(authViewModel) // Provide authViewModel to the environment
        }
    }
}
