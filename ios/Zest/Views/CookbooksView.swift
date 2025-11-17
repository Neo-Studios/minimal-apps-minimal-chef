import SwiftUI

struct CookbooksView: View {
    @StateObject private var viewModel = CookbooksViewModel()
    @State private var showingAddCookbook = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading cookbooks...")
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
                                await viewModel.loadCookbooks()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                } else if viewModel.cookbooks.isEmpty {
                    Spacer()
                    VStack {
                        Image(systemName: "book.closed")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No cookbooks yet")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Create your first cookbook to organize recipes")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.cookbooks) { cookbook in
                            NavigationLink(destination: CookbookDetailView(cookbook: cookbook, viewModel: viewModel)) {
                                CookbookRowView(cookbook: cookbook)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                if let id = viewModel.cookbooks[index].id {
                                    Task {
                                        await viewModel.deleteCookbook(id: id)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cookbooks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddCookbook = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddCookbook) {
                AddCookbookView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadCookbooks()
        }
        .refreshable {
            await viewModel.loadCookbooks()
        }
    }
}

struct CookbookRowView: View {
    let cookbook: Cookbook
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(cookbook.name)
                .font(.headline)
            if let description = cookbook.description {
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("\(cookbook.recipeIds.count) recipes")
                    .font(.caption)
                    .foregroundColor(.gray)
                if cookbook.isPublic == true {
                    Image(systemName: "globe")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct CookbookDetailView: View {
    let cookbook: Cookbook
    @ObservedObject var viewModel: CookbooksViewModel
    
    var body: some View {
        List {
            Section("Recipes") {
                if cookbook.recipeIds.isEmpty {
                    Text("No recipes in this cookbook")
                        .foregroundColor(.gray)
                } else {
                    ForEach(cookbook.recipeIds, id: \.self) { recipeId in
                        Text(recipeId)
                    }
                }
            }
        }
        .navigationTitle(cookbook.name)
    }
}

struct AddCookbookView: View {
    @ObservedObject var viewModel: CookbooksViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var description = ""
    @State private var isPublic = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    Toggle("Public", isOn: $isPublic)
                }
            }
            .navigationTitle("New Cookbook")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            let success = await viewModel.createCookbook(
                                name: name,
                                description: description.isEmpty ? nil : description,
                                isPublic: isPublic
                            )
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
