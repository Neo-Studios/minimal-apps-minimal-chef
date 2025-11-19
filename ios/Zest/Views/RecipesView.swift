import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    @State private var searchText = ""
    @State private var selectedCuisine = "All"
    @State private var selectedDifficulty = "All"
    @State private var showingAddRecipe = false
    
    let cuisines = ["All", "Italian", "Mexican", "Asian", "American", "Mediterranean"] // TODO: Localize these
    let difficulties = ["All", "Easy", "Medium", "Hard"] // TODO: Localize these
    
    var filteredRecipes: [Recipe] {
        viewModel.recipes.filter { recipe in
            (searchText.isEmpty || recipe.name.localizedCaseInsensitiveContains(searchText)) &&
            (selectedCuisine == "All" || recipe.cuisine == selectedCuisine) &&
            (selectedDifficulty == "All" || recipe.difficulty.rawValue == selectedDifficulty)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Offline indicator
                OfflineIndicator()
                
                // Search and filters
                VStack(spacing: 12) {
                    SearchBar(text: $searchText, placeholder: LocalizedStringKey("recipes.searchPlaceholder"))
                    HStack {
                        Picker(LocalizedStringKey("recipes.cuisine"), selection: $selectedCuisine) {
                            ForEach(cuisines, id: \.self) { cuisine in
                                Text(cuisine).tag(cuisine)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        Picker(LocalizedStringKey("recipes.difficulty"), selection: $selectedDifficulty) {
                            ForEach(difficulties, id: \.self) { difficulty in
                                Text(difficulty).tag(difficulty)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()
                
                // Content
                if viewModel.isLoading {
                    Spacer()
                    ProgressView(LocalizedStringKey("recipes.loading"))
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Spacer()
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                        Text(LocalizedStringKey("recipes.error"))
                            .font(.title2)
                            .foregroundColor(.red)
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        Button(LocalizedStringKey("recipes.retry")) {
                            Task {
                                await viewModel.loadRecipes()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                } else if filteredRecipes.isEmpty {
                    Spacer()
                    VStack {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text(LocalizedStringKey("recipes.noRecipesFound"))
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text(LocalizedStringKey("recipes.adjustFilters"))
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                } else {
                    List(filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRowView(recipe: recipe)
                        }
                    }
                }
            }
            .navigationTitle(LocalizedStringKey("recipes.title"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRecipe) {
                AddRecipeView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadRecipes()
        }
        .refreshable {
            await viewModel.loadRecipes()
        }
    }
}

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            // Image
            if let imageUrl = recipe.imageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image(systemName: "photo")
                    .font(.title)
                    .foregroundColor(.gray)
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine) // TODO: Localize cuisine type
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Label(LocalizedStringKey("recipes.time", arguments: [recipe.prepTime + recipe.cookTime]), systemImage: "clock")
                    Label(LocalizedStringKey("recipes.servings", arguments: [recipe.servings]), systemImage: "person.2")
                    if let rating = recipe.rating {
                        Label(String(format: "%.1f", rating), systemImage: "star.fill") // TODO: Localize rating
                            .foregroundColor(.orange)
                    }
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
