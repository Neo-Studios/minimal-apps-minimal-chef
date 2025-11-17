import SwiftUI
import FirebaseAuth

struct CollaborativeMealPlanDetailView: View {
    @StateObject var viewModel = CollaborativeMealPlanViewModel()
    let planId: String
    @State private var newMemberEmail = ""
    @State private var mealPlanToAddId = ""
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading Plan Details...")
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                    Button("Retry") {
                        viewModel.loadCollaborativeMealPlanDetail(id: planId)
                    }
                }
            } else if let plan = viewModel.selectedCollaborativeMealPlan {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(plan.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Owner: \(plan.ownerId)")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        Divider()
                        
                        Text("Members:")
                            .font(.headline)
                        
                        ForEach(plan.members, id: \.userId) { member in
                            HStack {
                                Text("\(member.userId) (\(member.role))")
                                Spacer()
                                if plan.ownerId == Auth.auth().currentUser?.uid && member.userId != Auth.auth().currentUser?.uid {
                                    Button {
                                        viewModel.removeMemberFromCollaborativeMealPlan(planId: plan.id!, member: member)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        
                        if plan.ownerId == Auth.auth().currentUser?.uid {
                            VStack(alignment: .leading) {
                                TextField("New Member Email", text: $newMemberEmail)
                                    .textFieldStyle(.roundedBorder)
                                Button("Add Member") {
                                    // In a real app, resolve email to userId
                                    let dummyUserId = newMemberEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased().replacingOccurrences(of: "[^a-z0-9]", with: "", options: .regularExpression) + "-id"
                                    let newMember = CollaborativeMealPlanMember(userId: dummyUserId, role: "viewer")
                                    viewModel.addMemberToCollaborativeMealPlan(planId: plan.id!, member: newMember)
                                    newMemberEmail = ""
                                }
                                .disabled(newMemberEmail.isEmpty)
                            }
                        }
                        
                        Divider()
                        
                        Text("Linked Meal Plans:")
                            .font(.headline)
                        
                        ForEach(plan.mealPlanIds, id: \.self) { mealPlanId in
                            HStack {
                                Text("Meal Plan ID: \(mealPlanId)")
                                Spacer()
                                if plan.ownerId == Auth.auth().currentUser?.uid {
                                    Button {
                                        viewModel.removeMealPlanFromCollaborativePlan(planId: plan.id!, mealPlanId: mealPlanId)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        
                        if plan.ownerId == Auth.auth().currentUser?.uid {
                            VStack(alignment: .leading) {
                                TextField("Meal Plan ID to Link", text: $mealPlanToAddId)
                                    .textFieldStyle(.roundedBorder)
                                Button("Link Meal Plan") {
                                    viewModel.addMealPlanToCollaborativePlan(planId: plan.id!, mealPlanId: mealPlanToAddId)
                                    mealPlanToAddId = ""
                                }
                                .disabled(mealPlanToAddId.isEmpty)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(viewModel.selectedCollaborativeMealPlan?.name ?? "Plan Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadCollaborativeMealPlanDetail(id: planId)
        }
    }
}

struct CollaborativeMealPlanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CollaborativeMealPlanDetailView(planId: "sample-id")
    }
}
