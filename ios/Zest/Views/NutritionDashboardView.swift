import SwiftUI

struct NutritionDashboardView: View {
    @StateObject private var viewModel = NutritionViewModel()
    
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
                    ProgressView("Loading nutrition data...")
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
                                await viewModel.loadEntries()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Today's totals
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                NutritionStatCard(label: "Calories", value: "\(viewModel.totalCalories)", color: .orange)
                                NutritionStatCard(label: "Protein", value: "\(Int(viewModel.totalProtein))g", color: .blue)
                                NutritionStatCard(label: "Carbs", value: "\(Int(viewModel.totalCarbs))g", color: .green)
                                NutritionStatCard(label: "Fat", value: "\(Int(viewModel.totalFat))g", color: .purple)
                            }
                            .padding(.horizontal)
                            
                            // Today's entries
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Today's Meals")
                                    .font(.title2)
                                    .bold()
                                    .padding(.horizontal)
                                
                                if viewModel.todayEntries.isEmpty {
                                    Text("No meals logged today")
                                        .foregroundColor(.gray)
                                        .padding()
                                } else {
                                    ForEach(viewModel.todayEntries) { entry in
                                        NutritionEntryRow(entry: entry, viewModel: viewModel)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Nutrition")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Today") {
                        viewModel.goToToday()
                    }
                }
            }
        }
        .task {
            await viewModel.loadEntries()
        }
        .refreshable {
            await viewModel.loadEntries()
        }
    }
}

struct NutritionEntryRow: View {
    let entry: NutritionEntry
    @ObservedObject var viewModel: NutritionViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.recipeName)
                    .font(.headline)
                Text("\(Int(entry.servings)) serving(s)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if let nutrition = entry.nutrition {
                Text("\(nutrition.calories) cal")
                    .font(.subheadline)
                    .bold()
            }
            
            Button {
                if let id = entry.id {
                    Task {
                        await viewModel.deleteEntry(id: id)
                    }
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
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
