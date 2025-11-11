import SwiftUI

@available(iOS 18.0, *)
struct AIRecipeGeneratorView: View {
    @State private var ingredients: [String] = []
    @State private var currentIngredient = ""
    @State private var generatedRecipe: String?
    @State private var isGenerating = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("AI Recipe Generator")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Ingredient input
                HStack {
                    TextField("Add ingredient", text: $currentIngredient)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            addIngredient()
                        }
                    
                    Button(action: addIngredient) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(currentIngredient.isEmpty)
                }
                
                // Ingredients list
                if !ingredients.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients:")
                            .font(.headline)
                        
                        ForEach(ingredients, id: \.self) { ingredient in
                            HStack {
                                Text("• \(ingredient)")
                                Spacer()
                                Button(action: {
                                    ingredients.removeAll { $0 == ingredient }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .padding()
                    .liquidGlass()
                }
                
                // Generate button
                Button(action: generateRecipe) {
                    HStack {
                        if isGenerating {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Image(systemName: "sparkles")
                        }
                        Text(isGenerating ? "Generating..." : "Generate Recipe with AI")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ingredients.isEmpty || isGenerating ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(ingredients.isEmpty || isGenerating || !AIManager.shared.isAIAvailable())
                
                // Generated recipe
                if let recipe = generatedRecipe {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Generated Recipe")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Button(action: { generatedRecipe = nil }) {
                                Image(systemName: "xmark.circle.fill")
                            }
                        }
                        
                        Text(recipe)
                            .font(.body)
                        
                        Button(action: saveRecipe) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Save Recipe")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("AI Recipe Generator")
    }
    
    func addIngredient() {
        guard !currentIngredient.isEmpty else { return }
        ingredients.append(currentIngredient)
        currentIngredient = ""
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func generateRecipe() {
        isGenerating = true
        Task {
            let recipe = await AIManager.shared.generateRecipeSuggestion(ingredients: ingredients)
            await MainActor.run {
                generatedRecipe = recipe
                isGenerating = false
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
        }
    }
    
    func saveRecipe() {
        // TODO: Save recipe to Firestore
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
