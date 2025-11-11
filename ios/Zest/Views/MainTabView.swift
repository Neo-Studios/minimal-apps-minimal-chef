import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            MealPlanView()
                .tabItem {
                    Label("Meal Plan", systemImage: "calendar")
                }
            
            ShoppingListView()
                .tabItem {
                    Label("Shopping", systemImage: "cart")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.filteredRecipes) { recipe in
                        LiquidGlassCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recipe.name)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.orange, .orange.opacity(0.8)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                
                                Text(recipe.cuisineType)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    Label("\(recipe.prepTime + recipe.cookTime) min", systemImage: "clock")
                                    Spacer()
                                    Label("\(recipe.servings)", systemImage: "person.2")
                                }
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(.ultraThinMaterial)
            .searchable(text: $viewModel.searchText, prompt: "Search recipes")
            .navigationTitle("Recipes")
            .task {
                await viewModel.loadRecipes()
            }
        }
    }
}

struct MealPlanView: View {
    @State private var selectedDate = Date()
    @State private var meals: [String: [String]] = [:]
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                List {
                    Section("Meals for \(selectedDate.formatted(date: .abbreviated, time: .omitted))") {
                        if let dayMeals = meals[dateKey(selectedDate)], !dayMeals.isEmpty {
                            ForEach(dayMeals, id: \.self) { meal in
                                Text(meal)
                            }
                        } else {
                            Text("No meals planned")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Meal Plan")
        }
    }
    
    private func dateKey(_ date: Date) -> String {
        date.formatted(date: .numeric, time: .omitted)
    }
}

struct ShoppingListView: View {
    @State private var items: [(String, Bool)] = []
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.clear
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    HStack {
                        TextField("Add item...", text: $newItem)
                            .textFieldStyle(.plain)
                            .padding(12)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onSubmit { addItem() }
                        
                        LiquidGlassButton(title: "Add") { addItem() }
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(items.indices, id: \.self) { i in
                                LiquidGlassCard {
                                    HStack {
                                        Button(action: { 
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                                items[i].1.toggle()
                                            }
                                        }) {
                                            Image(systemName: items[i].1 ? "checkmark.circle.fill" : "circle")
                                                .font(.title2)
                                                .foregroundStyle(items[i].1 ? .green : .secondary)
                                        }
                                        
                                        Text(items[i].0)
                                            .strikethrough(items[i].1)
                                            .foregroundColor(items[i].1 ? .secondary : .primary)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Shopping")
        }
    }
    
    private func addItem() {
        guard !newItem.isEmpty else { return }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            items.append((newItem, false))
            newItem = ""
        }
    }
}

struct SettingsView: View {
    @StateObject private var themeViewModel = ThemeViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Profile") {
                    Text("User profile information")
                }
                
                Section("Appearance") {
                    Picker("Theme", selection: $themeViewModel.themeMode) {
                        ForEach(ThemeMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                }
                
                Section {
                    Button("Sign Out", role: .destructive) {
                        // Sign out action
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
