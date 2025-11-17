import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Double
    let maxRating: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...maxRating, id: \.self) { index in
                Button {
                    rating = Double(index)
                } label: {
                    Image(systemName: starType(for: index))
                        .foregroundColor(.orange)
                        .font(.body)
                }
            }
        }
    }
    
    private func starType(for index: Int) -> String {
        let difference = rating - Double(index)
        
        if difference >= 0 {
            return "star.fill"
        } else if difference > -1 && difference < 0 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
