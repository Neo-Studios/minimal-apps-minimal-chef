import SwiftUI

/// Tablet layout for iPad - uses NavigationSplitView with sidebar
/// NO bottom tab bar on tablets - all navigation in sidebar
struct TabletMainView: View {
    @State private var selectedTab = 0
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // Sidebar - All navigation items visible
            List(selection: $selectedTab) {
                Section {
                    NavigationLink(value: 0) {
                        Label("Recipes", systemImage: "book.fill")
                    }
                    NavigationLink(value: 1) {
                        Label("Meal Plan", systemImage: "calendar")
                    }
                    NavigationLink(value: 2) {
                        Label("Shopping", systemImage: "cart.fill")
                    }
                    NavigationLink(value: 3) {
                        Label("Cookbooks", systemImage: "books.vertical.fill")
                    }
                    NavigationLink(value: 4) {
                        Label("Nutrition", systemImage: "chart.bar.fill")
                    }
                    NavigationLink(value: 5) {
                        Label("Timers", systemImage: "timer")
                    }
                    NavigationLink(value: 6) {
                        Label("AI Assistant", systemImage: "sparkles")
                    }
                }
                
                Section {
                    NavigationLink(value: 7) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("Zest")
            .listStyle(.sidebar)
            .frame(minWidth: 250)
        } content: {
            // Content pane - shows list or grid view
            Group {
                switch selectedTab {
                case 0:
                    RecipesView()
                case 1:
                    MealPlanView()
                case 2:
                    ShoppingListView()
                case 3:
                    CookbooksView()
                case 4:
                    NutritionDashboardView()
                case 5:
                    CookingTimerView()
                case 6:
                    AIRecipeGeneratorView()
                case 7:
                    SettingsView()
                default:
                    ContentUnavailableView(
                        "Select a Section",
                        systemImage: "sidebar.left",
                        description: Text("Choose a section from the sidebar")
                    )
                }
            }
            .frame(minWidth: 300)
        } detail: {
            // Detail pane - shows selected item details
            ContentUnavailableView(
                "No Selection",
                systemImage: "doc.text.magnifyingglass",
                description: Text("Select an item to view details")
            )
            .frame(minWidth: 400)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

// Placeholder views for missing features
struct CookbooksView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Cookbooks",
                systemImage: "books.vertical.fill",
                description: Text("Organize your recipes into collections")
            )
            .navigationTitle("Cookbooks")
        }
    }
}

// Adaptive container that switches between phone and tablet layouts
struct AdaptiveMainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .regular {
            // iPad or larger - use sidebar navigation (NO bottom tab bar)
            TabletMainView()
        } else {
            // iPhone - use bottom tab bar
            MainTabView()
        }
    }
}
