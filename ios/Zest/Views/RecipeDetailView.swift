import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @StateObject private var viewModel = RecipesViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var servingMultiplier: Double = 1.0
    @State private var showEditSheet = false
    @State private var showDeleteAlert = false
    @State private var showShareSheet = false
    @State private var currentRating: Double = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = recipe.imageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 200)
                    .clipped()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let description = recipe.description {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label("\(recipe.prepTime)m", systemImage: "clock")
                        Label("\(recipe.cookTime)m", systemImage: "flame")
                        Label("\(recipe.servings)", systemImage: "person.2")
                        Spacer()
                        Text(recipe.difficulty.rawValue)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(difficultyColor(recipe.difficulty).opacity(0.2))
                            .foregroundColor(difficultyColor(recipe.difficulty))
                            .cornerRadius(8)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    // Rating
                    HStack {
                        Text("Rating:")
                            .font(.subheadline)
                        StarRatingView(rating: $currentRating, maxRating: 5)
                            .onChange(of: currentRating) { newRating in
                                if let recipeId = recipe.id {
                                    Task {
                                        await viewModel.updateRating(recipeId: recipeId, rating: newRating)
                                    }
                                }
                            }
                        if let rating = recipe.rating {
                            Text(String(format: "%.1f", rating))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Recipe Scaling Card
                LiquidGlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Scale Recipe")
                            .font(.headline)
                        
                        HStack {
                            Button(action: {
                                if servingMultiplier > 0.5 {
                                    servingMultiplier -= 0.5
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("\(Int(Double(recipe.servings) * servingMultiplier)) servings")
                                    .font(.headline)
                                Text("×\(String(format: "%.1f", servingMultiplier))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                servingMultiplier += 0.5
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                            }
                        }
                        
                        if servingMultiplier != 1.0 {
                            Button("Reset") {
                                withAnimation {
                                    servingMultiplier = 1.0
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.orange)
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(recipe.ingredients.indices, id: \.self) { i in
                        HStack {
                            Text("•")
                            let scaledAmount = scaleAmount(recipe.ingredients[i].amount, multiplier: servingMultiplier)
                            Text("\(scaledAmount) \(recipe.ingredients[i].unit) \(recipe.ingredients[i].name)")
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(recipe.instructions.indices, id: \.self) { i in
                        HStack(alignment: .top) {
                            Text("\(i + 1).")
                                .fontWeight(.bold)
                            Text(recipe.instructions[i])
                        }
                        .padding(.bottom, 4)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    NavigationLink(destination: CookingModeView(recipe: recipe)) {
                        Image(systemName: "play.circle.fill")
                    }
                    NavigationLink(destination: ARCookingView(recipe: recipe)) {
                        Image(systemName: "camera.viewfinder")
                    }
                    Menu {
                        Button(action: { showShareSheet = true }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        Button(action: { showEditSheet = true }) {
                            Label("Edit", systemImage: "pencil")
                        }
                        Button(role: .destructive, action: { showDeleteAlert = true }) {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [generateShareText()])
        }
        .sheet(isPresented: $showEditSheet) {
            Text("Edit Recipe - Coming Soon")
        }
        .alert("Delete Recipe", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    if let recipeId = recipe.id {
                        let success = await viewModel.deleteRecipe(id: recipeId)
                        if success {
                            dismiss()
                        }
                    }
                }
            }
        } message: {
            Text("Are you sure you want to delete this recipe? This action cannot be undone.")
        }
        .onAppear {
            currentRating = recipe.rating ?? 0
        }
    }
    
    private func scaleAmount(_ amount: Double, multiplier: Double) -> String {
        let scaled = amount * multiplier
        if scaled.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(scaled))
        } else {
            return String(format: "%.1f", scaled)
        }
    }
    
    private func difficultyColor(_ difficulty: Recipe.Difficulty) -> Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
    
    private func generateShareText() -> String {
        let ingredientsList = recipe.ingredients.enumerated().map { index, ing in
            "• \(ing.amount) \(ing.unit) \(ing.name)"
        }.joined(separator: "\n")
        
        let instructionsList = recipe.instructions.enumerated().map { index, step in
            "\(index + 1). \(step)"
        }.joined(separator: "\n")
        
        return """
        \(recipe.name)
        
        Prep Time: \(recipe.prepTime) min
        Cook Time: \(recipe.cookTime) min
        Servings: \(recipe.servings)
        
        Ingredients:
        \(ingredientsList)
        
        Instructions:
        \(instructionsList)
        """
    }
}
