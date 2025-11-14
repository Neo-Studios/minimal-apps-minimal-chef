import SwiftUI

struct LiquidGlassSearchBar: View {
    @Binding var text: String
    let placeholder: String
    @FocusState private var isFocused: Bool
    @Environment(\.colorScheme) var colorScheme
    
    init(_ placeholder: String = "Search...", text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        HStack(spacing: LiquidGlassSpacing.md) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    isFocused 
                        ? LiquidGlassColors.primary(for: colorScheme)
                        : Color.secondary
                )
                .font(LiquidGlassTypography.bodyMedium)
            
            TextField(placeholder, text: $text)
                .font(LiquidGlassTypography.bodyMedium)
                .focused($isFocused)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(LiquidGlassTypography.bodySmall)
                }
            }
        }
        .padding(LiquidGlassSpacing.md)
        .background(
            isFocused 
                ? Material.regular 
                : Material.ultraThin
        )
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(
                    isFocused
                        ? LiquidGlassColors.primary(for: colorScheme)
                        : Color.clear,
                    lineWidth: 2
                )
        )
        .shadow(
            color: isFocused 
                ? LiquidGlassShadow.medium.color 
                : LiquidGlassShadow.small.color,
            radius: isFocused 
                ? LiquidGlassShadow.medium.radius 
                : LiquidGlassShadow.small.radius,
            x: 0,
            y: isFocused 
                ? LiquidGlassShadow.medium.y 
                : LiquidGlassShadow.small.y
        )
        .animation(LiquidGlassAnimation.springSmooth, value: isFocused)
    }
}
