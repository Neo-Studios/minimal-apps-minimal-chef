import SwiftUI

struct MealPlanView: View {
    @StateObject private var viewModel = MealPlanViewModel()
    @State private var showingAddMeal = false
    @State private var selectedMealType = "breakfast"
    
    let mealTypes = ["breakfast", "lunch", "dinner", "snacks"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Date navigation
                HStack {
                    Button {
                        viewModel.changeDate(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Text(viewModel.selectedDate, style: .date)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        viewModel.changeDate(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding()
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading meal plan...")
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Spacer()
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                        Text("Error")
                            .font(.title2)
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Button("Retry") {
                            Task {
                                await viewModel.loadMealPlans()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(mealTypes, id: \.self) { mealType in
                                MealSection(
                                    title: mealType.capitalized,
                                    recipeIds: viewModel.currentMealPlan?.meals[mealType] ?? [],
                                    onAdd: {
                                        selectedMealType = mealType
                                        showingAddMeal = true
                                    },
                                    onRemove: { recipeId in
                                        Task {
                                            await viewModel.removeMeal(mealType: mealType, recipeId: recipeId)
                                        }
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Meal Plan")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Today") {
                        viewModel.goToToday()
                    }
                }
            }
        }
        .task {
            await viewModel.loadMealPlans()
        }
        .refreshable {
            await viewModel.loadMealPlans()
        }
    }
}

struct MealSection: View {
    let title: String
    let recipeIds: [String]
    let onAdd: () -> Void
    let onRemove: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Button {
                    onAdd()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            
            if recipeIds.isEmpty {
                Text("No meals planned")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.vertical, 8)
            } else {
                ForEach(recipeIds, id: \.self) { recipeId in
                    HStack {
                        Text(recipeId)
                            .font(.body)
                        Spacer()
                        Button {
                            onRemove(recipeId)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct AddMealView: View {
    let mealType: String
    let onAdd: (String) -> Void
    @Environment(\.dismiss) var dismiss
    @State private var selectedRecipeId = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add meal to \(mealType)")
                    .font(.headline)
                    .padding()
                
                TextField("Recipe ID", text: $selectedRecipeId)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Add") {
                    onAdd(selectedRecipeId)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedRecipeId.isEmpty)
                
                Spacer()
            }
            .navigationTitle("Add Meal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
