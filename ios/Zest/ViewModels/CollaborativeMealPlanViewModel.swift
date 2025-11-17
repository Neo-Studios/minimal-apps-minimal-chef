import Foundation
import Combine
import FirebaseAuth

class CollaborativeMealPlanViewModel: ObservableObject {
    @Published var collaborativeMealPlans: [CollaborativeMealPlan] = []
    @Published var selectedCollaborativeMealPlan: CollaborativeMealPlan?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let firebaseService = FirebaseService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadCollaborativeMealPlans()
    }
    
    func loadCollaborativeMealPlans() {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return
        }
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                self.collaborativeMealPlans = try await firebaseService.getCollaborativeMealPlans(userId: userId)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func loadCollaborativeMealPlanDetail(id: String) {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                self.selectedCollaborativeMealPlan = try await firebaseService.getCollaborativeMealPlan(id: id)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func createCollaborativeMealPlan(name: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return
        }
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                let newPlan = CollaborativeMealPlan(name: name, ownerId: userId, members: [CollaborativeMealPlanMember(userId: userId, role: "owner")], mealPlanIds: [], createdAt: Date(), updatedAt: Date())
                let _ = try await firebaseService.createCollaborativeMealPlan(newPlan)
                self.loadCollaborativeMealPlans()
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func addMemberToCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                try await firebaseService.addMemberToCollaborativeMealPlan(planId: planId, member: member)
                self.loadCollaborativeMealPlanDetail(id: planId)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func removeMemberFromCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                try await firebaseService.removeMemberFromCollaborativeMealPlan(planId: planId, member: member)
                self.loadCollaborativeMealPlanDetail(id: planId)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func addMealPlanToCollaborativePlan(planId: String, mealPlanId: String) {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                try await firebaseService.addMealPlanToCollaborativePlan(planId: planId, mealPlanId: mealPlanId)
                self.loadCollaborativeMealPlanDetail(id: planId)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func removeMealPlanFromCollaborativePlan(planId: String, mealPlanId: String) {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                try await firebaseService.removeMealPlanFromCollaborativePlan(planId: planId, mealPlanId: mealPlanId)
                self.loadCollaborativeMealPlanDetail(id: planId)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
}
