import SwiftUI

struct Feature {
    let title: String
    let description: String
    let icon: String // SF Symbols name
}

let features = [
    Feature(
        title: "Welcome to Zest!",
        description: "Your ultimate cooking companion. Let's explore some key features.",
        icon: "fork.knife.circle.fill"
    ),
    Feature(
        title: "Recipe Management",
        description: "Organize, discover, and create your favorite recipes with ease.",
        icon: "book.closed.fill"
    ),
    Feature(
        title: "Meal Planning",
        description: "Plan your meals for the week and generate smart shopping lists.",
        icon: "calendar"
    ),
    Feature(
        title: "AI Assistant",
        description: "Get AI-powered recipe suggestions and cooking assistance.",
        icon: "sparkle.magnifyingglass"
    ),
]

struct FeatureShowcaseView: View {
    @State private var currentIndex = 0
    var onSkip: () -> Void
    var onComplete: () -> Void

    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<features.count, id: \.self) { index in
                    FeatureCard(feature: features[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            HStack {
                Button("Skip") {
                    onSkip()
                }
                Spacer()
                Button(action: {
                    if currentIndex < features.count - 1 {
                        currentIndex += 1
                    } else {
                        onComplete()
                    }
                }) {
                    Text(currentIndex == features.count - 1 ? "Get Started" : "Next")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

struct FeatureCard: View {
    let feature: Feature
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: feature.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.accentColor)
            
            Text(feature.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(feature.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

struct FeatureShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureShowcaseView(onSkip: {}, onComplete: {})
    }
}
