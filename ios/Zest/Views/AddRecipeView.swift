import SwiftUI

struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var servings = ""
    @State private var ingredients: [Ingredient] = [Ingredient(name: "", amount: "", unit: "")]
    @State private var instructions: [String] = [""]
    
    var onSave: (Recipe) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Info") {
                    TextField("Recipe Name", text: $name)
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
                            TextField("Amount", text: Binding(
                                get: { ingredients[i].amount },
                                set: { ingredients[i].amount = $0 }
                            ))
                            TextField("Unit", text: Binding(
                                get: { ingredients[i].unit },
                                set: { ingredients[i].unit = $0 }
                            ))
                            TextField("Name", text: Binding(
                                get: { ingredients[i].name },
                                set: { ingredients[i].name = $0 }
                            ))
                        }
                    }
                    Button("+ Add Ingredient") {
                        ingredients.append(Ingredient(name: "", amount: "", unit: ""))
                    }
                }
                
                Section("Instructions") {
                    ForEach(instructions.indices, id: \.self) { i in
                        TextField("Step \(i + 1)", text: $instructions[i], axis: .vertical)
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
                        let recipe = Recipe(
                            name: name,
                            userId: "",
                            ingredients: ingredients.filter { !$0.name.isEmpty },
                            instructions: instructions.filter { !$0.isEmpty },
                            prepTime: Int(prepTime) ?? 0,
                            cookTime: Int(cookTime) ?? 0,
                            servings: Int(servings) ?? 1,
                            cuisineType: "",
                            mealType: "",
                            createdAt: Date(),
                            updatedAt: Date()
                        )
                        onSave(recipe)
                        dismiss()
                    }
                }
            }
        }
    }
}
