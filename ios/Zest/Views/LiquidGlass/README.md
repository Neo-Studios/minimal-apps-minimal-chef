# Liquid Glass Design System for iOS

This folder contains the Liquid Glass design system implementation for Zest iOS application.

## Files

- `LiquidGlassTheme.swift` - Design tokens (colors, typography, spacing, animations)
- `LiquidGlassComponents.swift` - Pre-built components (cards, buttons, text fields, etc.)
- `LiquidGlassModifier.swift` - View modifier for glass effect
- `LiquidGlassCard.swift` - Basic card component
- `LiquidGlassButton.swift` - Basic button component
- `SpecularHighlight.swift` - Specular highlight effects

## Usage

### Import

```swift
import SwiftUI
```

All Liquid Glass components are available in your SwiftUI views.

### Colors

```swift
// Use adaptive colors
LiquidGlassColors.primary(for: colorScheme)
LiquidGlassColors.secondary(for: colorScheme)
LiquidGlassColors.tertiary(for: colorScheme)
LiquidGlassColors.surface(for: colorScheme)

// Or use specific colors
LiquidGlassColors.primaryLight
LiquidGlassColors.primaryDark
LiquidGlassColors.secondaryLight
LiquidGlassColors.secondaryDark
```

### Typography

```swift
// Display styles
Text("Display Large")
    .font(LiquidGlassTypography.displayLarge)

Text("Display Medium")
    .font(LiquidGlassTypography.displayMedium)

// Headline styles
Text("Headline Large")
    .font(LiquidGlassTypography.headlineLarge)

Text("Headline Medium")
    .font(LiquidGlassTypography.headlineMedium)

// Title styles
Text("Title Large")
    .font(LiquidGlassTypography.titleLarge)

Text("Title Medium")
    .font(LiquidGlassTypography.titleMedium)

// Body styles
Text("Body Large")
    .font(LiquidGlassTypography.bodyLarge)

Text("Body Medium")
    .font(LiquidGlassTypography.bodyMedium)

// Label styles
Text("Label Large")
    .font(LiquidGlassTypography.labelLarge)

Text("Label Medium")
    .font(LiquidGlassTypography.labelMedium)
```

### Spacing

```swift
// Use consistent spacing
VStack(spacing: LiquidGlassSpacing.md) {
    // Content
}

.padding(LiquidGlassSpacing.lg)
.padding(.horizontal, LiquidGlassSpacing.xl)
.padding(.vertical, LiquidGlassSpacing.sm)

// Available spacing
LiquidGlassSpacing.xs   // 4pt
LiquidGlassSpacing.sm   // 8pt
LiquidGlassSpacing.md   // 12pt
LiquidGlassSpacing.lg   // 16pt
LiquidGlassSpacing.xl   // 24pt
LiquidGlassSpacing.xxl  // 32pt
LiquidGlassSpacing.xxxl // 48pt
```

### Corner Radius

```swift
// Apply corner radius
.clipShape(RoundedRectangle(
    cornerRadius: LiquidGlassCornerRadius.large,
    style: .continuous
))

// Available corner radius
LiquidGlassCornerRadius.extraSmall // 8pt
LiquidGlassCornerRadius.small      // 12pt
LiquidGlassCornerRadius.medium     // 16pt
LiquidGlassCornerRadius.large      // 24pt
LiquidGlassCornerRadius.extraLarge // 32pt
LiquidGlassCornerRadius.full       // 9999pt
```

### Materials

```swift
// Apply translucent materials
.background(.ultraThinMaterial)
.background(.thinMaterial)
.background(.regularMaterial)
.background(.thickMaterial)
.background(.ultraThickMaterial)

// Or use enum
.background(LiquidGlassMaterial.regular.material)
```

### Animations

```swift
// Use Liquid Glass animations
withAnimation(LiquidGlassAnimation.spring) {
    isExpanded.toggle()
}

withAnimation(LiquidGlassAnimation.springBouncy) {
    scale = 1.2
}

withAnimation(LiquidGlassAnimation.interactive) {
    offset = newOffset
}

// Available animations
LiquidGlassAnimation.spring         // Standard spring
LiquidGlassAnimation.springBouncy   // Bouncy spring
LiquidGlassAnimation.springSmooth   // Smooth spring
LiquidGlassAnimation.easeInOut      // Ease in/out
LiquidGlassAnimation.easeOut        // Ease out
LiquidGlassAnimation.easeIn         // Ease in
LiquidGlassAnimation.interactive    // Interactive spring
```

### Shadows

```swift
// Apply shadows
.shadow(
    color: LiquidGlassShadow.medium.color,
    radius: LiquidGlassShadow.medium.radius,
    x: LiquidGlassShadow.medium.x,
    y: LiquidGlassShadow.medium.y
)

// Available shadows
LiquidGlassShadow.small
LiquidGlassShadow.medium
LiquidGlassShadow.large
LiquidGlassShadow.extraLarge
```

## Components

### Enhanced Card

```swift
LiquidGlassCardEnhanced(
    material: .regular,
    cornerRadius: LiquidGlassCornerRadius.large,
    shadow: .medium
) {
    VStack(alignment: .leading, spacing: LiquidGlassSpacing.md) {
        Text("Card Title")
            .font(LiquidGlassTypography.titleLarge)
        Text("Card content goes here")
            .font(LiquidGlassTypography.bodyMedium)
    }
}
```

### Button

```swift
// Primary button
LiquidGlassButtonEnhanced(
    "Primary Action",
    icon: "star.fill",
    style: .primary
) {
    print("Button tapped")
}

// Secondary button
LiquidGlassButtonEnhanced(
    "Secondary Action",
    style: .secondary
) {
    print("Button tapped")
}

// Tertiary button
LiquidGlassButtonEnhanced(
    "Tertiary Action",
    style: .tertiary
) {
    print("Button tapped")
}

// Ghost button
LiquidGlassButtonEnhanced(
    "Ghost Action",
    style: .ghost
) {
    print("Button tapped")
}
```

### Text Field

```swift
@State private var email = ""

LiquidGlassTextField(
    "Email",
    text: $email,
    icon: "envelope"
)
```

### Badge

```swift
LiquidGlassBadge("New")

LiquidGlassBadge(
    "Premium",
    color: LiquidGlassColors.secondaryLight
)
```

### Divider

```swift
VStack {
    Text("Section 1")
    LiquidGlassDivider()
    Text("Section 2")
}
```

### Surface

```swift
LiquidGlassSurface(elevation: 2) {
    VStack {
        Text("Surface Content")
    }
    .padding(LiquidGlassSpacing.lg)
}
```

### Glass Modifier

```swift
// Apply glass effect to any view
VStack {
    Text("Content")
}
.liquidGlass()
```

## Examples

### Login Form

```swift
VStack(spacing: LiquidGlassSpacing.lg) {
    Text("Welcome Back")
        .font(LiquidGlassTypography.displayMedium)
        .foregroundColor(LiquidGlassColors.primary(for: colorScheme))
    
    LiquidGlassTextField(
        "Email",
        text: $email,
        icon: "envelope"
    )
    
    LiquidGlassTextField(
        "Password",
        text: $password,
        icon: "lock"
    )
    
    LiquidGlassButtonEnhanced(
        "Sign In",
        icon: "arrow.right",
        style: .primary
    ) {
        signIn()
    }
    
    LiquidGlassButtonEnhanced(
        "Create Account",
        style: .ghost
    ) {
        createAccount()
    }
}
.padding(LiquidGlassSpacing.xl)
```

### Recipe Card

```swift
LiquidGlassCardEnhanced(
    material: .regular,
    cornerRadius: LiquidGlassCornerRadius.large,
    shadow: .medium
) {
    VStack(alignment: .leading, spacing: LiquidGlassSpacing.md) {
        AsyncImage(url: recipe.imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(
            cornerRadius: LiquidGlassCornerRadius.medium,
            style: .continuous
        ))
        
        HStack {
            Text(recipe.name)
                .font(LiquidGlassTypography.titleLarge)
            Spacer()
            LiquidGlassBadge(recipe.difficulty)
        }
        
        Text(recipe.description)
            .font(LiquidGlassTypography.bodyMedium)
            .foregroundColor(.secondary)
        
        LiquidGlassDivider()
        
        HStack(spacing: LiquidGlassSpacing.lg) {
            Label("\(recipe.time) min", systemImage: "clock")
            Label("\(recipe.servings)", systemImage: "person.2")
        }
        .font(LiquidGlassTypography.labelMedium)
        .foregroundColor(.secondary)
    }
}
```

### Settings Row

```swift
LiquidGlassCardEnhanced(material: .ultraThin) {
    HStack(spacing: LiquidGlassSpacing.md) {
        Image(systemName: "bell.fill")
            .foregroundColor(LiquidGlassColors.primary(for: colorScheme))
        
        VStack(alignment: .leading, spacing: LiquidGlassSpacing.xs) {
            Text("Notifications")
                .font(LiquidGlassTypography.titleMedium)
            Text("Manage your notification preferences")
                .font(LiquidGlassTypography.bodySmall)
                .foregroundColor(.secondary)
        }
        
        Spacer()
        
        Image(systemName: "chevron.right")
            .foregroundColor(.secondary)
    }
}
```

## Color Palette

### Light Mode
- Primary: #FFA500 (Orange)
- Secondary: #00B4D8 (Blue)
- Tertiary: #4CAF50 (Green)
- Surface: #FFF8E1 (Warm White)

### Dark Mode
- Primary: #FFB733 (Light Orange)
- Secondary: #33C3E3 (Light Blue)
- Tertiary: #6FBF73 (Light Green)
- Surface: #1C1B1F (Dark Gray)

## Best Practices

1. **Use adaptive colors**: Always use `LiquidGlassColors.primary(for: colorScheme)` for automatic light/dark adaptation
2. **Continuous corners**: Use `.continuous` style for smooth, rounded corners
3. **Spring animations**: Prefer spring animations over linear for natural motion
4. **Material hierarchy**: Use appropriate material thickness for depth
5. **Consistent spacing**: Use `LiquidGlassSpacing` tokens for consistent spacing
6. **Specular highlights**: Add gradient borders for glass-like reflections
7. **Accessibility**: Ensure proper contrast and support Dynamic Type

## Resources

- [Liquid Glass Overview](https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass)
- [SwiftUI Materials](https://developer.apple.com/documentation/swiftui/material)
- [Design System Documentation](../../../../docs/DESIGN_SYSTEMS.md)
- [Quick Reference](../../../../docs/DESIGN_QUICK_REFERENCE.md)
- [Migration Guide](../../../../docs/DESIGN_MIGRATION.md)

## Accessibility

All Liquid Glass components support:
- Dynamic Type for text scaling
- VoiceOver for screen readers
- High contrast mode
- Reduced motion preferences
- Minimum touch targets (44x44 points)

Enable accessibility features:

```swift
// Respect reduced motion
@Environment(\.accessibilityReduceMotion) var reduceMotion

if reduceMotion {
    // Use simpler animations or no animations
} else {
    withAnimation(LiquidGlassAnimation.spring) {
        // Animated state change
    }
}

// Support Dynamic Type
Text("Title")
    .font(LiquidGlassTypography.titleLarge)
    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
```
