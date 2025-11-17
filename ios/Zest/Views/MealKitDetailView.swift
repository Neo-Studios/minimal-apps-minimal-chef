import SwiftUI

struct MealKitDetailView: View {
    @StateObject var viewModel = MealKitViewModel()
    let mealKitId: String
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading Meal Kit...")
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                    Button("Retry") {
                        viewModel.loadMealKitDetail(id: mealKitId)
                    }
                }
            } else if let mealKit = viewModel.selectedMealKit {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        AsyncImage(url: URL(string: mealKit.imageUrl)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 250)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                        }
                        
                        Text(mealKit.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(mealKit.description)
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        Divider()
                        
                        Text("Price: $\(mealKit.price, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Divider()
                        
                        Text("Recipes Included:")
                            .font(.headline)
                        
                        ForEach(mealKit.recipes, id: \.recipeId) { mealKitRecipe in
                            VStack(alignment: .leading) {
                                Text(mealKitRecipe.recipeId) // In a real app, fetch recipe name
                                    .font(.subheadline)
                                Text("Servings: \(mealKitRecipe.servings)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Divider()
                        
                        Text("Available Dates:")
                            .font(.headline)
                        
                        FlowLayout(alignment: .leading, spacing: 8) {
                            ForEach(mealKit.availableDates, id: \.self) { date in
                                Text(date)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Capsule().fill(Color.blue.opacity(0.2)))
                                    .font(.caption)
                            }
                        }
                        
                        Button(action: {
                            // Add to cart logic
                        }) {
                            Text("Add to Cart")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(viewModel.selectedMealKit?.name ?? "Meal Kit")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadMealKitDetail(id: mealKitId)
        }
    }
}

// Helper for FlowLayout (similar to Android's FlowRow)
struct FlowLayout: Layout {
    let alignment: HorizontalAlignment
    let spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let containerWidth = proposal.width ?? 0
        var currentX = 0.0
        var currentY = 0.0
        var lineHeight = 0.0
        var totalHeight = 0.0
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            if currentX + subviewSize.width > containerWidth {
                currentX = 0.0
                totalHeight += lineHeight + spacing
                lineHeight = 0.0
            }
            currentX += subviewSize.width + spacing
            lineHeight = max(lineHeight, subviewSize.height)
        }
        totalHeight += lineHeight
        return CGSize(width: containerWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let containerWidth = bounds.width
        var currentX = bounds.minX
        var currentY = bounds.minY
        var lineHeight = 0.0
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            if currentX + subviewSize.width > containerWidth {
                currentX = bounds.minX
                currentY += lineHeight + spacing
                lineHeight = 0.0
            }
            
            subview.place(at: CGPoint(x: currentX, y: currentY), proposal: ProposedViewSize(subviewSize))
            currentX += subviewSize.width + spacing
            lineHeight = max(lineHeight, subviewSize.height)
        }
    }
}

struct MealKitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealKitDetailView(mealKitId: "sample-id")
    }
}
