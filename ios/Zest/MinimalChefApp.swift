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
    
    var body: some Scene {
        WindowGroup {
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
        }
    }
}
