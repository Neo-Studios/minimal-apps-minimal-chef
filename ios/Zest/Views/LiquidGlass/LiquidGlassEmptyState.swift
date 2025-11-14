import SwiftUI

struct LiquidGlassEmptyState: View {
    let icon: String
    let title: String
    let description: String
    let actionLabel: String?
    let action: (() -> Void)?
    
    init(
        icon: String,
        title: String,
        description: String,
        actionLabel: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.actionLabel = actionLabel
        self.action = action
    }
    
    var body: some View {
        LiquidGlassCardEnhanced(
            material: .ultraThin,
            cornerRadius: LiquidGlassCornerRadius.large,
            shadow: .small
        ) {
            VStack(spacing: LiquidGlassSpacing.lg) {
                Text(icon)
                    .font(.system(size: 60))
                    .scaleEffect(animationScale)
                    .onAppear {
                        withAnimation(
                            Animation.spring(response: 0.6, dampingFraction: 0.5)
                                .repeatForever(autoreverses: true)
                        ) {
                            animationScale = 1.1
                        }
                    }
                
                VStack(spacing: LiquidGlassSpacing.sm) {
                    Text(title)
                        .font(LiquidGlassTypography.titleLarge)
                        .multilineTextAlignment(.center)
                    
                    Text(description)
                        .font(LiquidGlassTypography.bodyMedium)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                if let actionLabel = actionLabel, let action = action {
                    LiquidGlassButtonEnhanced(
                        actionLabel,
                        style: .tertiary
                    ) {
                        action()
                    }
                }
            }
            .padding(LiquidGlassSpacing.xxxl)
        }
    }
    
    @State private var animationScale: CGFloat = 1.0
}
