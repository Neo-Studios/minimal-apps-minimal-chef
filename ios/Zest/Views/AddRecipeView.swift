import SwiftUI

struct AddRecipeView: View {
    @ObservedObject var viewModel: RecipesViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var description = ""
    @State private var cuisine = "Italian"
    @State private var difficulty = Recipe.Difficulty.easy
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var servings = ""
    @State private var ingredients: [IngredientInput] = [IngredientInput()]
    @State private var instructions: [String] = [""]
    @State private var selectedImage: UIImage?
    @State private var isUploading = false
    
    let cuisines = ["Italian", "Mexican", "Asian", "American", "Mediterranean", "French", "Indian", "Thai"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Image") {
                    HStack {
                        Spacer()
                        ImagePicker(selectedImage: $selectedImage)
                        Spacer()
                    }
                }
                
                Section("Basic Info") {
                    TextField("Recipe Name", text: $name)
                    TextField("Description", text: $description, axis: .vertical)
                    Picker("Cuisine", selection: $cuisine) {
                        ForEach(cuisines, id: \.self) { cuisine in
                            Text(cuisine).tag(cuisine)
                        }
                    }
                    Picker("Difficulty", selection: $difficulty) {
                        ForEach(Recipe.Difficulty.allCases, id: \.self) { diff in
                            Text(diff.rawValue).tag(diff)
                        }
                    }
                }
                
                Section("Time & Servings") {
                    HStack {
                        TextField("Prep (min)", text: $prepTime)
                            .keyboardType(.numberPad)
                        TextField("Cook (min)", text: $cookTime)
                            .keyboardType(.numberPad)
                        TextField("Servings", text: $servings)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section("Ingredients") {
                    ForEach(ingredients.indices, id: \.self) { i in
                        HStack {
                            TextField("Amount", text: $ingredients[i].amount)
                                .keyboardType(.decimalPad)
                                .frame(width: 60)
                            TextField("Unit", text: $ingredients[i].unit)
                                .frame(width: 60)
                            TextField("Name", text: $ingredients[i].name)
                        }
                    }
                    Button("+ Add Ingredient") {
                        ingredients.append(IngredientInput())
                    }
                }
                
                Section("Instructions") {
                    ForEach(instructions.indices, id: \.self) { i in
                        TextField("Step \(i + 1)", text: $instructions[i], axis: .vertical)
                            .lineLimit(3...6)
                    }
                    Button("+ Add Step") {
                        instructions.append("")
                    }
                }
            }
            .navigationTitle("Add Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            isUploading = true
                            
                            var recipe = Recipe(
                                name: name,
                                description: description.isEmpty ? nil : description,
                                cuisine: cuisine,
                                prepTime: Int(prepTime) ?? 0,
                                cookTime: Int(cookTime) ?? 0,
                                servings: Int(servings) ?? 1,
                                difficulty: difficulty,
                                ingredients: ingredients.compactMap { input in
                                    guard !input.name.isEmpty,
                                          let amount = Double(input.amount) else { return nil }
                                    return Ingredient(name: input.name, amount: amount, unit: input.unit)
                                },
                                instructions: instructions.filter { !$0.isEmpty },
                                userId: "" // Will be set by ViewModel
                            )
                            
                            let success = await viewModel.createRecipe(recipe)
                            
                            // Upload image if selected and recipe was created
                            if success, let image = selectedImage, let recipeId = viewModel.recipes.last?.id {
                                do {
                                    let imageUrl = try await ImageUploadService.shared.uploadRecipeImage(image, recipeId: recipeId)
                                    recipe.imageUrl = imageUrl
                                    await viewModel.updateRecipe(id: recipeId, recipe)
                                } catch {
                                    print("Failed to upload image: \(error)")
                                }
                            }
                            
                            isUploading = false
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(name.isEmpty || ingredients.isEmpty || instructions.isEmpty || isUploading)
                }
            }
            .overlay {
                if isUploading {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                        VStack {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Uploading...")
                                .foregroundColor(.white)
                                .padding(.top)
                        }
                    }
                }
            }
        }
    }
}

struct IngredientInput {
    var name = ""
    var amount = ""
    var unit = ""
}
