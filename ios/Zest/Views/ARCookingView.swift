import SwiftUI
import RealityKit

struct ARCookingView: View {
    let recipe: Recipe
    @State private var currentStep = 0

    var body: some View {
        ZStack {
            ARViewContainer(recipe: recipe, currentStep: $currentStep)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Text("Step \(currentStep + 1): \(recipe.instructions[currentStep])")
                    .font(.title)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                HStack {
                    Button(action: {
                        if currentStep > 0 {
                            currentStep -= 1
                        }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .disabled(currentStep == 0)

                    Button(action: {
                        if currentStep < recipe.instructions.count - 1 {
                            currentStep += 1
                        }
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .disabled(currentStep == recipe.instructions.count - 1)
                }
                .padding()
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    let recipe: Recipe
    @Binding var currentStep: Int

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Create a placeholder for the ingredient
        let anchor = AnchorEntity()
        let box = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .red, isMetallic: false)
        let entity = ModelEntity(mesh: box, materials: [material])
        anchor.addChild(entity)
        arView.scene.addAnchor(anchor)
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the view
    }
}
