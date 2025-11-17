import SwiftUI

struct CollaborativeMealPlansView: View {
    @StateObject var viewModel = CollaborativeMealPlanViewModel()
    @State private var showingCreateSheet = false
    @State private var newPlanName = ""
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Collaborative Meal Plans...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.loadCollaborativeMealPlans()
                        }
                    }
                } else if viewModel.collaborativeMealPlans.isEmpty {
                    ContentUnavailableView("No Collaborative Meal Plans Available", systemImage: "person.3")
                } else {
                    List(viewModel.collaborativeMealPlans) { plan in
                        NavigationLink(destination: CollaborativeMealPlanDetailView(planId: plan.id ?? "")) {
                            CollaborativeMealPlanRow(plan: plan)
                        }
                    }
                }
            }
            .navigationTitle("Collaborative Plans")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingCreateSheet = true
                    } label: {
                        Label("Create New Plan", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingCreateSheet) {
                CreateCollaborativeMealPlanSheet(
                    newPlanName: $newPlanName,
                    onDismiss: { showingCreateSheet = false },
                    onCreate: {
                        viewModel.createCollaborativeMealPlan(name: newPlanName)
                        showingCreateSheet = false
                        newPlanName = ""
                    }
                )
            }
        }
    }
}

struct CollaborativeMealPlanRow: View {
    let plan: CollaborativeMealPlan
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(plan.name)
                .font(.headline)
            Text("Owner: \(plan.ownerId)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(plan.members.count) members")
                .font(.caption)
        }
    }
}

struct CreateCollaborativeMealPlanSheet: View {
    @Binding var newPlanName: String
    var onDismiss: () -> Void
    var onCreate: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Plan Details") {
                    TextField("Plan Name", text: $newPlanName)
                }
                Button("Create Plan") {
                    onCreate()
                }
                .disabled(newPlanName.isEmpty)
            }
            .navigationTitle("Create New Plan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onDismiss()
                    }
                }
            }
        }
    }
}

struct CollaborativeMealPlansView_Previews: PreviewProvider {
    static var previews: some View {
        CollaborativeMealPlansView()
    }
}
