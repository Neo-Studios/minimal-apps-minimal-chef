# Design Systems

Zest implements platform-specific design languages to provide the best native experience on each platform.

## Overview

- **Web & Android**: Material 3 Expressive
- **iOS**: Liquid Glass

## Material 3 Expressive (Web & Android)

Material 3 Expressive is Google's latest design system featuring enhanced expressiveness, dynamic color, and fluid motion.

### Key Features

- **Expressive Color System**: Rich color palettes with primary, secondary, and tertiary colors
- **Dynamic Theming**: Automatic light/dark mode with adaptive colors
- **Enhanced Motion**: Emphasized easing curves for fluid animations
- **Elevation System**: 5 levels of elevation with consistent shadows
- **Typography Scale**: Complete type system from display to label styles
- **Shape System**: Rounded corners from extra-small (4px) to extra-large (28px)

### Web Implementation

#### Colors

```typescript
import { expressiveColors } from '@/lib/design/material3-expressive'

// Use in components
<div className="bg-m3-primary-main text-m3-on-primary">
  Primary Button
</div>

// CSS Variables
var(--m3-primary)
var(--m3-secondary)
var(--m3-surface)
```

#### Components

```tsx
import { Material3Button, Material3Card, Material3TextField } from '@/components/ui'

// Button variants
<Material3Button variant="filled">Filled</Material3Button>
<Material3Button variant="outlined">Outlined</Material3Button>
<Material3Button variant="tonal">Tonal</Material3Button>

// Card variants
<Material3Card variant="elevated">Content</Material3Card>
<Material3Card variant="filled">Content</Material3Card>
<Material3Card variant="outlined">Content</Material3Card>

// Text field
<Material3TextField
  label="Email"
  value={email}
  onChange={setEmail}
  icon={<MailIcon />}
/>
```

#### Tailwind Classes

```tsx
// Colors
className="bg-m3-primary-main text-m3-on-primary"
className="bg-m3-surface-container text-m3-on-surface"

// Elevation
className="shadow-elevation-1"
className="shadow-elevation-3"

// Border radius
className="rounded-small"  // 8px
className="rounded-medium" // 12px
className="rounded-large"  // 16px

// Spacing
className="p-md"  // 12px
className="gap-lg" // 16px

// Transitions
className="transition-emphasized"
```

### Android Implementation

#### Theme Setup

```kotlin
import com.neostudios.zest.ui.theme.Material3ExpressiveTheme

@Composable
fun MyApp() {
    Material3ExpressiveTheme(
        darkTheme = isSystemInDarkTheme(),
        dynamicColor = true // Enable dynamic color on Android 12+
    ) {
        // Your app content
    }
}
```

#### Colors

```kotlin
// Use Material 3 colors
MaterialTheme.colorScheme.primary
MaterialTheme.colorScheme.secondary
MaterialTheme.colorScheme.tertiary
MaterialTheme.colorScheme.surface
MaterialTheme.colorScheme.error

// Container colors
MaterialTheme.colorScheme.primaryContainer
MaterialTheme.colorScheme.secondaryContainer
MaterialTheme.colorScheme.surfaceContainer
```

#### Typography

```kotlin
// Use expressive typography
Text(
    text = "Display Large",
    style = MaterialTheme.typography.displayLarge
)

Text(
    text = "Headline Medium",
    style = MaterialTheme.typography.headlineMedium
)

Text(
    text = "Body Large",
    style = MaterialTheme.typography.bodyLarge
)
```

#### Components

```kotlin
// Buttons
Button(
    onClick = { },
    colors = ButtonDefaults.buttonColors(
        containerColor = MaterialTheme.colorScheme.primary
    )
) {
    Text("Primary Button")
}

// Cards
Card(
    modifier = Modifier.fillMaxWidth(),
    colors = CardDefaults.cardColors(
        containerColor = MaterialTheme.colorScheme.surfaceContainer
    ),
    shape = MaterialTheme.shapes.large
) {
    // Card content
}

// Text fields
OutlinedTextField(
    value = text,
    onValueChange = { text = it },
    label = { Text("Label") },
    colors = TextFieldDefaults.outlinedTextFieldColors(
        focusedBorderColor = MaterialTheme.colorScheme.primary
    )
)
```

#### Shapes

```kotlin
// Use expressive shapes
MaterialTheme.shapes.extraSmall // 4dp
MaterialTheme.shapes.small      // 8dp
MaterialTheme.shapes.medium     // 12dp
MaterialTheme.shapes.large      // 16dp
MaterialTheme.shapes.extraLarge // 28dp
```

## Liquid Glass (iOS)

Liquid Glass is Apple's design language featuring translucent materials, depth, specular highlights, and fluid animations.

### Key Features

- **Translucent Materials**: Ultra-thin to ultra-thick material hierarchy
- **Specular Highlights**: Reflective surfaces with gradient borders
- **Fluid Animations**: Spring-based animations with natural motion
- **Depth & Layering**: Multi-level elevation system
- **Adaptive Colors**: Dynamic color adaptation for light/dark modes
- **Rounded Design**: Continuous corner radius for smooth edges

### iOS Implementation

#### Theme

```swift
import SwiftUI

// Colors
LiquidGlassColors.primary(for: colorScheme)
LiquidGlassColors.secondary(for: colorScheme)
LiquidGlassColors.tertiary(for: colorScheme)
LiquidGlassColors.surface(for: colorScheme)
```

#### Typography

```swift
// Use Liquid Glass typography
Text("Display Large")
    .font(LiquidGlassTypography.displayLarge)

Text("Headline Medium")
    .font(LiquidGlassTypography.headlineMedium)

Text("Body Large")
    .font(LiquidGlassTypography.bodyLarge)
```

#### Components

```swift
// Enhanced Card
LiquidGlassCardEnhanced(
    material: .regular,
    cornerRadius: LiquidGlassCornerRadius.large,
    shadow: .medium
) {
    VStack {
        Text("Card Content")
    }
}

// Button
LiquidGlassButtonEnhanced(
    "Primary Button",
    icon: "star.fill",
    style: .primary
) {
    // Action
}

// Text Field
LiquidGlassTextField(
    "Email",
    text: $email,
    icon: "envelope"
)

// Badge
LiquidGlassBadge("New", color: LiquidGlassColors.primaryLight)

// Divider
LiquidGlassDivider()
```

#### Materials

```swift
// Apply materials
.background(.ultraThinMaterial)
.background(.thinMaterial)
.background(.regularMaterial)
.background(.thickMaterial)
.background(.ultraThickMaterial)
```

#### Animations

```swift
// Use Liquid Glass animations
withAnimation(LiquidGlassAnimation.spring) {
    // State change
}

withAnimation(LiquidGlassAnimation.springBouncy) {
    // Bouncy animation
}

withAnimation(LiquidGlassAnimation.interactive) {
    // Interactive gesture
}
```

#### Spacing

```swift
// Use consistent spacing
.padding(LiquidGlassSpacing.xs)  // 4pt
.padding(LiquidGlassSpacing.sm)  // 8pt
.padding(LiquidGlassSpacing.md)  // 12pt
.padding(LiquidGlassSpacing.lg)  // 16pt
.padding(LiquidGlassSpacing.xl)  // 24pt
```

#### Shadows

```swift
// Apply shadows
.shadow(
    color: LiquidGlassShadow.medium.color,
    radius: LiquidGlassShadow.medium.radius,
    x: LiquidGlassShadow.medium.x,
    y: LiquidGlassShadow.medium.y
)
```

## Design Tokens

Shared design tokens are located in `shared/design-tokens/` and include:

- **colors.json**: Color palette definitions
- **spacing.json**: Spacing scale
- **typography.json**: Font sizes and weights
- **shadows.json**: Shadow definitions
- **motion.json**: Animation timing and easing

## Best Practices

### Web & Android (Material 3 Expressive)

1. **Use semantic colors**: Always use `primary`, `secondary`, `surface` instead of hardcoded colors
2. **Respect elevation**: Use appropriate elevation levels for component hierarchy
3. **Consistent motion**: Use emphasized easing for important transitions
4. **Dynamic theming**: Support both light and dark modes
5. **Accessibility**: Maintain WCAG AA contrast ratios

### iOS (Liquid Glass)

1. **Material hierarchy**: Use appropriate material thickness for depth
2. **Fluid motion**: Prefer spring animations over linear
3. **Specular highlights**: Add gradient borders for glass effect
4. **Adaptive colors**: Use color scheme-aware colors
5. **Continuous corners**: Use `.continuous` style for rounded corners

## Resources

- [Material 3 Expressive](https://m3.material.io/blog/building-with-m3-expressive)
- [Material 3 Components](https://developer.android.com/reference/kotlin/androidx/compose/material3/package-summary)
- [Liquid Glass](https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass)
- [SwiftUI Materials](https://developer.apple.com/documentation/swiftui/material)

## Migration Guide

### From Legacy to Material 3 Expressive (Web)

```tsx
// Before
<div className="bg-primary text-white">

// After
<div className="bg-m3-primary-main text-m3-on-primary">
```

### From Legacy to Material 3 Expressive (Android)

```kotlin
// Before
Color(0xFFFFA500)

// After
MaterialTheme.colorScheme.primary
```

### Enhancing Liquid Glass (iOS)

```swift
// Before
.background(.ultraThinMaterial)

// After
LiquidGlassCardEnhanced(material: .ultraThin) {
    // Content
}
```
