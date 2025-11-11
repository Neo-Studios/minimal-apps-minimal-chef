import SwiftUI

struct NutritionDashboardView: View {
    let weeklyData: [DailyNutrition]
    
    var averages: NutritionInfo {
        let total = weeklyData.reduce(NutritionInfo(calories: 0, protein: 0, carbs: 0, fat: 0)) { result, day in
            NutritionInfo(
                calories: result.calories + day.nutrition.calories,
                protein: result.protein + day.nutrition.protein,
                carbs: result.carbs + day.nutrition.carbs,
                fat: result.fat + day.nutrition.fat
            )
        }
        
        let count = Double(weeklyData.count)
        return NutritionInfo(
            calories: Int(Double(total.calories) / count),
            protein: round(total.protein / count * 10) / 10,
            carbs: round(total.carbs / count * 10) / 10,
            fat: round(total.fat / count * 10) / 10
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Nutrition Dashboard")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    NutritionStatCard(label: "Avg Calories", value: "\(averages.calories)", color: .orange)
                    NutritionStatCard(label: "Avg Protein", value: "\(averages.protein)g", color: .blue)
                    NutritionStatCard(label: "Avg Carbs", value: "\(averages.carbs)g", color: .green)
                    NutritionStatCard(label: "Avg Fat", value: "\(averages.fat)g", color: .purple)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Weekly Breakdown")
                        .font(.title2)
                        .bold()
                    
                    ForEach(weeklyData) { day in
                        HStack {
                            Text(day.date)
                            Spacer()
                            Text("\(day.nutrition.calories) cal")
                                .bold()
                        }
                        .padding()
                        .liquidGlass()
                    }
                }
            }
            .padding()
        }
    }
}

struct DailyNutrition: Identifiable {
    let id = UUID()
    let date: String
    let nutrition: NutritionInfo
}

struct NutritionStatCard: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title)
                .bold()
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}
