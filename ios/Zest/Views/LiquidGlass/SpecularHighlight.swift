import SwiftUI

struct SpecularHighlight: View {
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(
            colors: [
                .white.opacity(0.6),
                .white.opacity(0.3),
                .white.opacity(0.1),
                .clear
            ],
            startPoint: animateGradient ? .topLeading : .bottomTrailing,
            endPoint: animateGradient ? .bottomTrailing : .topLeading
        )
        .blur(radius: 20)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 3)
                .repeatForever(autoreverses: true)
            ) {
                animateGradient.toggle()
            }
        }
    }
}

extension View {
    func specularHighlight() -> some View {
        self.overlay(SpecularHighlight().allowsHitTesting(false))
    }
}
