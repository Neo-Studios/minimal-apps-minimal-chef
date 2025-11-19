import SwiftUI

struct AppTourView: View {
    var onSkip: () -> Void
    var onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "map.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.accentColor)
            
            Text("App Tour")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Let's take a quick tour of the app to show you around! (This would be a guided tour with highlights of different UI elements)")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack {
                Button("Skip Tour") {
                    onSkip()
                }
                Spacer()
                Button("Start App") {
                    onComplete()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

struct AppTourView_Previews: PreviewProvider {
    static var previews: some View {
        AppTourView(onSkip: {}, onComplete: {})
    }
}
