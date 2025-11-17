import SwiftUI

struct MealKitsView: View {
    @StateObject var viewModel = MealKitViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Meal Kits...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.loadMealKits()
                        }
                    }
                } else if viewModel.mealKits.isEmpty {
                    ContentUnavailableView("No Meal Kits Available", systemImage: "shippingbox")
                } else {
                    List(viewModel.mealKits) { mealKit in
                        NavigationLink(destination: MealKitDetailView(mealKitId: mealKit.id ?? "")) {
                            MealKitRow(mealKit: mealKit)
                        }
                    }
                }
            }
            .navigationTitle("Meal Kits")
        }
    }
}

struct MealKitRow: View {
    let mealKit: MealKit
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: mealKit.imageUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(mealKit.name)
                    .font(.headline)
                Text(mealKit.description)
                    .font(.subheadline)
                    .lineLimit(2)
                Text("$\(mealKit.price, specifier: "%.2f")")
                    .font(.caption)
                    .fontWeight(.bold)
            }
        }
    }
}

struct MealKitsView_Previews: PreviewProvider {
    static var previews: some View {
        MealKitsView()
    }
}
