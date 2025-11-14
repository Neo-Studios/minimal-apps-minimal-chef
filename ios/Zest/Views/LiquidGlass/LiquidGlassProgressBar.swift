import SwiftUI

struct LiquidGlassProgressBar: View {
    let value: Double
    let total: Double
    let label: String?
    let showPercentage: Bool
    let color: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    init(
        value: Double,
        total: Double = 100,
        label: String? = nil,
        showPercentage: Bool = false,
        color: Color? = nil
    ) {
        self.value = value
        self.total = total
        self.label = label
        self.showPercentage = showPercentage
        self.color = color ?? LiquidGlassColors.primaryLight
    }
    
    private var percentage: Double {
        min((value / total) * 100, 100)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: LiquidGlassSpacing.xs) {
            if label != nil || showPercentage {
                HStack {
                    if let label = label {
                        Text(label)
                            .font(LiquidGlassTypography.bodySmall)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    if showPercentage {
                        Text("\(Int(percentage))%")
                            .font(LiquidGlassTypography.labelMedium)
                            .fontWeight(.medium)
                    }
                }
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    Capsule()
                        .fill(Color.secondary.opacity(0.2))
                    
                    // Progress
                    Capsule()
                        .fill(color)
                        .frame(width: geometry.size.width * CGFloat(percentage / 100))
                        .animation(LiquidGlassAnimation.spring, value: percentage)
                }
            }
            .frame(height: 8)
        }
    }
}
