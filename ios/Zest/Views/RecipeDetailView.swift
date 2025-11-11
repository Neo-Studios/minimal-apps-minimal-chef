import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
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
                    
                    HStack {
                        Label("\(recipe.prepTime)m", systemImage: "clock")
                        Label("\(recipe.cookTime)m", systemImage: "flame")
                        Label("\(recipe.servings)", systemImage: "person.2")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(recipe.ingredients.indices, id: \.self) { i in
                        HStack {
                            Text("•")
                            Text("\(recipe.ingredients[i].amount) \(recipe.ingredients[i].unit) \(recipe.ingredients[i].name)")
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
    }
}
