import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    @State private var showingAddItem = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading shopping list...")
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
                                await viewModel.loadItems()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                } else {
                    List {
                        if !viewModel.uncheckedItems.isEmpty {
                            Section("To Buy") {
                                ForEach(viewModel.uncheckedItems) { item in
                                    ShoppingItemRow(item: item, viewModel: viewModel)
                                }
                                .onDelete { indexSet in
                                    for index in indexSet {
                                        if let id = viewModel.uncheckedItems[index].id {
                                            Task {
                                                await viewModel.deleteItem(id: id)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        if !viewModel.checkedItems.isEmpty {
                            Section("Purchased") {
                                ForEach(viewModel.checkedItems) { item in
                                    ShoppingItemRow(item: item, viewModel: viewModel)
                                }
                                .onDelete { indexSet in
                                    for index in indexSet {
                                        if let id = viewModel.checkedItems[index].id {
                                            Task {
                                                await viewModel.deleteItem(id: id)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        if viewModel.items.isEmpty {
                            VStack {
                                Image(systemName: "cart")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray)
                                Text("Shopping list is empty")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Shopping List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !viewModel.checkedItems.isEmpty {
                        Button("Clear Checked") {
                            Task {
                                await viewModel.clearCheckedItems()
                            }
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddItem = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddShoppingItemView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadItems()
        }
        .refreshable {
            await viewModel.loadItems()
        }
    }
}

struct ShoppingItemRow: View {
    let item: ShoppingItem
    @ObservedObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        HStack {
            Button {
                if let id = item.id {
                    Task {
                        await viewModel.toggleItem(id: id)
                    }
                }
            } label: {
                Image(systemName: item.checked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.checked ? .green : .gray)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .strikethrough(item.checked)
                    .foregroundColor(item.checked ? .gray : .primary)
                Text(item.quantity)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if let category = item.category {
                Text(category)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
}

struct AddShoppingItemView: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var quantity = ""
    @State private var category = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Item Details") {
                    TextField("Name", text: $name)
                    TextField("Quantity", text: $quantity)
                    TextField("Category (optional)", text: $category)
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        Task {
                            let success = await viewModel.addItem(
                                name: name,
                                quantity: quantity,
                                category: category.isEmpty ? nil : category
                            )
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(name.isEmpty || quantity.isEmpty)
                }
            }
        }
    }
}
