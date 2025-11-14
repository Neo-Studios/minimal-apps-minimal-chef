import SwiftUI

struct LiquidGlassChip: View {
    let label: String
    let selected: Bool
    let icon: String?
    let onTap: (() -> Void)?
    let onDelete: (() -> Void)?
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed = false
    
    init(
        _ label: String,
        selected: Bool = false,
        icon: String? = nil,
        onTap: (() -> Void)? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self.label = label
        self.selected = selected
        self.icon = icon
        self.onTap = onTap
        self.onDelete = onDelete
    }
    
    var body: some View {
        HStack(spacing: LiquidGlassSpacing.sm) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(LiquidGlassTypography.labelSmall)
            }
            
            Text(label)
                .font(LiquidGlassTypography.labelMedium)
            
            if let onDelete = onDelete {
                Button(action: onDelete) {
                    Image(systemName: "xmark")
                        .font(.system(size: 10, weight: .medium))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, LiquidGlassSpacing.md)
        .padding(.vertical, LiquidGlassSpacing.sm)
        .background(
            selected 
                ? LiquidGlassColors.primary(for: colorScheme).opacity(0.2)
                : Material.ultraThin
        )
        .foregroundColor(
            selected 
                ? LiquidGlassColors.primary(for: colorScheme)
                : .primary
        )
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(
                    selected 
                        ? LiquidGlassColors.primary(for: colorScheme)
                        : Color.secondary.opacity(0.3),
                    lineWidth: selected ? 2 : 1
                )
        )
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .onTapGesture {
            if let onTap = onTap {
                withAnimation(LiquidGlassAnimation.springSmooth) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(LiquidGlassAnimation.springSmooth) {
                        isPressed = false
                    }
                }
                onTap()
            }
        }
        .animation(LiquidGlassAnimation.springSmooth, value: selected)
        .animation(LiquidGlassAnimation.interactive, value: isPressed)
    }
}
