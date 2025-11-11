import SwiftUI

@available(iOS 18.0, *)
struct AIAssistantView: View {
    @State private var isAIAvailable = AIManager.shared.isAIAvailable()
    @State private var selectedAction: AIAction?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // AI Status Banner
                if !isAIAvailable {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text("AI features require Apple Intelligence (iOS 18+ on compatible devices)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                } else {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("AI powered by Apple Intelligence (On-Device)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                }
                
                Text("AI Chef Assistant")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    AIActionCard(
                        title: "Recipe Suggestions",
                        description: "Get recipe ideas from ingredients",
                        icon: "fork.knife",
                        enabled: isAIAvailable
                    ) {
                        selectedAction = .recipeSuggestions
                    }
                    
                    AIActionCard(
                        title: "Analyze Recipe Photo",
                        description: "Extract recipe from image",
                        icon: "camera.fill",
                        enabled: isAIAvailable
                    ) {
                        selectedAction = .analyzePhoto
                    }
                    
                    AIActionCard(
                        title: "Generate Instructions",
                        description: "AI-generated cooking steps",
                        icon: "list.bullet",
                        enabled: isAIAvailable
                    ) {
                        selectedAction = .generateInstructions
                    }
                    
                    AIActionCard(
                        title: "Ingredient Substitutions",
                        description: "Find alternatives for ingredients",
                        icon: "arrow.left.arrow.right",
                        enabled: isAIAvailable
                    ) {
                        selectedAction = .substitutions
                    }
                    
                    AIActionCard(
                        title: "Summarize Recipe",
                        description: "Get quick recipe overview",
                        icon: "doc.text.fill",
                        enabled: isAIAvailable
                    ) {
                        selectedAction = .summarize
                    }
                }
            }
            .padding()
        }
        .navigationTitle("AI Assistant")
        .sheet(item: $selectedAction) { action in
            AIActionSheet(action: action)
        }
    }
}

enum AIAction: Identifiable {
    case recipeSuggestions
    case analyzePhoto
    case generateInstructions
    case substitutions
    case summarize
    
    var id: String {
        switch self {
        case .recipeSuggestions: return "suggestions"
        case .analyzePhoto: return "photo"
        case .generateInstructions: return "instructions"
        case .substitutions: return "substitutions"
        case .summarize: return "summarize"
        }
    }
}

struct AIActionCard: View {
    let title: String
    let description: String
    let icon: String
    let enabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundColor(enabled ? .blue : .gray)
                    .frame(width: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(enabled ? .primary : .gray)
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .liquidGlass()
        }
        .disabled(!enabled)
    }
}

@available(iOS 18.0, *)
struct AIActionSheet: View {
    let action: AIAction
    @State private var result: String = ""
    @State private var isLoading = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Processing with Apple Intelligence...")
                        .padding()
                } else if !result.isEmpty {
                    ScrollView {
                        Text(result)
                            .padding()
                    }
                } else {
                    Text("Ready to process")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .navigationTitle(action.id.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
