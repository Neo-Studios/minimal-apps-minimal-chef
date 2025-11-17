import Foundation
import Combine

class MealKitViewModel: ObservableObject {
    @Published var mealKits: [MealKit] = []
    @Published var selectedMealKit: MealKit?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let firebaseService = FirebaseService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMealKits()
    }
    
    func loadMealKits() {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                self.mealKits = try await firebaseService.getMealKits()
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func loadMealKitDetail(id: String) {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                self.selectedMealKit = try await firebaseService.getMealKit(id: id)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
}
