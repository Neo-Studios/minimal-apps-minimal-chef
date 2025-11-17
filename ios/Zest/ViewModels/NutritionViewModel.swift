import Foundation
import FirebaseAuth

@MainActor
class NutritionViewModel: ObservableObject {
    @Published var entries: [NutritionEntry] = []
    @Published var selectedDate = Date()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let firebaseService = FirebaseService.shared
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var selectedDateKey: String {
        dateFormatter.string(from: selectedDate)
    }
    
    var todayEntries: [NutritionEntry] {
        entries.filter { $0.date == selectedDateKey }
    }
    
    var totalCalories: Int {
        todayEntries.reduce(0) { $0 + ($1.nutrition?.calories ?? 0) }
    }
    
    var totalProtein: Double {
        todayEntries.reduce(0) { $0 + ($1.nutrition?.protein ?? 0) }
    }
    
    var totalCarbs: Double {
        todayEntries.reduce(0) { $0 + ($1.nutrition?.carbs ?? 0) }
    }
    
    var totalFat: Double {
        todayEntries.reduce(0) { $0 + ($1.nutrition?.fat ?? 0) }
    }
    
    func loadEntries() async {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Load week around selected date
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -3, to: selectedDate) ?? selectedDate
        let endDate = calendar.date(byAdding: .day, value: 3, to: selectedDate) ?? selectedDate
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        do {
            entries = try await firebaseService.getNutritionEntries(
                userId: userId,
                startDate: startDateString,
                endDate: endDateString
            )
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func addEntry(recipeId: String, recipeName: String, servings: Double, nutrition: NutritionInfo) async -> Bool {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return false
        }
        
        let entry = NutritionEntry(
            userId: userId,
            date: selectedDateKey,
            recipeId: recipeId,
            recipeName: recipeName,
            servings: servings,
            nutrition: nutrition,
            createdAt: Date()
        )
        
        do {
            let _ = try await firebaseService.addNutritionEntry(entry)
            await loadEntries()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func deleteEntry(id: String) async -> Bool {
        do {
            try await firebaseService.deleteNutritionEntry(id: id)
            await loadEntries()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func changeDate(by days: Int) {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .day, value: days, to: selectedDate) {
            selectedDate = newDate
            Task {
                await loadEntries()
            }
        }
    }
    
    func goToToday() {
        selectedDate = Date()
        Task {
            await loadEntries()
        }
    }
}
