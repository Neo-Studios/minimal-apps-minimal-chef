import SwiftUI

// MARK: - Enhanced Liquid Glass Card
struct LiquidGlassCardEnhanced<Content: View>: View {
    let content: Content
    let material: LiquidGlassMaterial
    let cornerRadius: CGFloat
    let shadow: LiquidGlassShadow
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed = false
    
    init(
        material: LiquidGlassMaterial = .regular,
        cornerRadius: CGFloat = LiquidGlassCornerRadius.large,
        shadow: LiquidGlassShadow = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.material = material
        self.cornerRadius = cornerRadius
        self.shadow = shadow
    }
    
    var body: some View {
        content
            .padding(LiquidGlassSpacing.lg)
            .background(material.material)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.3 : 0.6),
                                .white.opacity(colorScheme == .dark ? 0.05 : 0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
            .shadow(
                color: shadow.color,
                radius: shadow.radius,
                x: shadow.x,
                y: shadow.y
            )
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(LiquidGlassAnimation.springSmooth, value: isPressed)
    }
}

// MARK: - Liquid Glass Button
struct LiquidGlassButtonEnhanced: View {
    let title: String
    let icon: String?
    let action: () -> Void
    let style: ButtonStyle
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed = false
    
    enum ButtonStyle {
        case primary
        case secondary
        case tertiary
        case ghost
    }
    
    init(
        _ title: String,
        icon: String? = nil,
        style: ButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.action = action
        self.style = style
    }
    
    var body: some View {
        Button(action: {
            withAnimation(LiquidGlassAnimation.spring) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(LiquidGlassAnimation.spring) {
                    isPressed = false
                }
            }
            action()
        }) {
            HStack(spacing: LiquidGlassSpacing.sm) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(LiquidGlassTypography.labelLarge)
                }
                Text(title)
                    .font(LiquidGlassTypography.labelLarge)
            }
            .padding(.horizontal, LiquidGlassSpacing.xl)
            .padding(.vertical, LiquidGlassSpacing.md)
            .background(backgroundForStyle)
            .foregroundColor(foregroundForStyle)
            .clipShape(RoundedRectangle(cornerRadius: LiquidGlassCornerRadius.medium, style: .continuous))
            .overlay(overlayForStyle)
            .shadow(
                color: shadowColorForStyle,
                radius: isPressed ? 4 : 8,
                x: 0,
                y: isPressed ? 2 : 4
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(LiquidGlassAnimation.interactive, value: isPressed)
    }
    
    private var backgroundForStyle: some View {
        Group {
            switch style {
            case .primary:
                LiquidGlassColors.primary(for: colorScheme)
            case .secondary:
                LiquidGlassColors.secondary(for: colorScheme)
            case .tertiary:
                LiquidGlassColors.tertiary(for: colorScheme)
            case .ghost:
                Material.ultraThinMaterial
            }
        }
    }
    
    private var foregroundForStyle: Color {
        switch style {
        case .primary, .secondary, .tertiary:
            return .white
        case .ghost:
            return LiquidGlassColors.primary(for: colorScheme)
        }
    }
    
    private var overlayForStyle: some View {
        Group {
            if style == .ghost {
                RoundedRectangle(cornerRadius: LiquidGlassCornerRadius.medium, style: .continuous)
                    .strokeBorder(
                        LiquidGlassColors.primary(for: colorScheme).opacity(0.5),
                        lineWidth: 1.5
                    )
            }
        }
    }
    
    private var shadowColorForStyle: Color {
        switch style {
        case .primary:
            return LiquidGlassColors.primary(for: colorScheme).opacity(0.3)
        case .secondary:
            return LiquidGlassColors.secondary(for: colorScheme).opacity(0.3)
        case .tertiary:
            return LiquidGlassColors.tertiary(for: colorScheme).opacity(0.3)
        case .ghost:
            return .black.opacity(0.1)
        }
    }
}

// MARK: - Liquid Glass Surface
struct LiquidGlassSurface<Content: View>: View {
    let content: Content
    let elevation: Int
    
    @Environment(\.colorScheme) var colorScheme
    
    init(elevation: Int = 1, @ViewBuilder content: () -> Content) {
        self.elevation = elevation
        self.content = content()
    }
    
    var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: LiquidGlassCornerRadius.medium, style: .continuous)
                    .fill(LiquidGlassColors.surface(for: colorScheme))
                    .shadow(
                        color: .black.opacity(Double(elevation) * 0.05),
                        radius: CGFloat(elevation * 4),
                        x: 0,
                        y: CGFloat(elevation * 2)
                    )
            )
    }
}

// MARK: - Liquid Glass Divider
struct LiquidGlassDivider: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        .clear,
                        .white.opacity(colorScheme == .dark ? 0.2 : 0.3),
                        .clear
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 1)
    }
}

// MARK: - Liquid Glass Badge
struct LiquidGlassBadge: View {
    let text: String
    let color: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    init(_ text: String, color: Color = LiquidGlassColors.primaryLight) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        Text(text)
            .font(LiquidGlassTypography.labelSmall)
            .foregroundColor(.white)
            .padding(.horizontal, LiquidGlassSpacing.sm)
            .padding(.vertical, LiquidGlassSpacing.xs)
            .background(
                Capsule()
                    .fill(color)
                    .shadow(
                        color: color.opacity(0.3),
                        radius: 4,
                        x: 0,
                        y: 2
                    )
            )
    }
}

// MARK: - Liquid Glass Input Field
struct LiquidGlassTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String?
    
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isFocused: Bool
    
    init(_ placeholder: String, text: Binding<String>, icon: String? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.icon = icon
    }
    
    var body: some View {
        HStack(spacing: LiquidGlassSpacing.md) {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(LiquidGlassColors.primary(for: colorScheme))
                    .font(LiquidGlassTypography.bodyMedium)
            }
            
            TextField(placeholder, text: $text)
                .font(LiquidGlassTypography.bodyMedium)
                .focused($isFocused)
        }
        .padding(LiquidGlassSpacing.md)
        .background(Material.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: LiquidGlassCornerRadius.medium, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: LiquidGlassCornerRadius.medium, style: .continuous)
                .strokeBorder(
                    isFocused
                        ? LiquidGlassColors.primary(for: colorScheme)
                        : Color.white.opacity(colorScheme == .dark ? 0.2 : 0.4),
                    lineWidth: isFocused ? 2 : 1
                )
        )
        .animation(LiquidGlassAnimation.springSmooth, value: isFocused)
    }
}
