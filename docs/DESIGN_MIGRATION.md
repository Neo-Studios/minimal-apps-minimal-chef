# Design System Migration Guide

Guide for migrating existing components to Material 3 Expressive (Web/Android) and Liquid Glass (iOS).

## Web Migration (Material 3 Expressive)

### Step 1: Update Imports

```tsx
// Add to your component
import { expressiveColors, expressiveMotion } from '@/lib/design/material3-expressive'
import { Material3Button, Material3Card, Material3TextField } from '@/components/ui'
```

### Step 2: Replace Legacy Colors

```tsx
// Before
<div className="bg-primary text-white">
  
// After
<div className="bg-m3-primary-main text-m3-on-primary">

// Before
<div style={{ backgroundColor: '#FFA500' }}>
  
// After
<div className="bg-m3-primary-main">
```

### Step 3: Update Buttons

```tsx
// Before
<button className="bg-primary text-white px-6 py-3 rounded-lg">
  Click Me
</button>

// After
<Material3Button variant="filled">
  Click Me
</Material3Button>

// Or with Tailwind
<button className="bg-m3-primary-main text-m3-on-primary px-6 py-3 rounded-medium shadow-elevation-2 transition-emphasized">
  Click Me
</button>
```

### Step 4: Update Cards

```tsx
// Before
<div className="bg-white rounded-lg shadow-md p-4">
  Content
</div>

// After
<Material3Card variant="elevated">
  <div className="p-lg">Content</div>
</Material3Card>

// Or with Tailwind
<div className="bg-m3-surface-container rounded-large shadow-elevation-2 p-lg">
  Content
</div>
```

### Step 5: Update Text Fields

```tsx
// Before
<input
  type="text"
  className="border border-gray-300 rounded px-3 py-2"
  placeholder="Enter text"
/>

// After
<Material3TextField
  label="Label"
  value={value}
  onChange={setValue}
  placeholder="Enter text"
/>
```

### Step 6: Update Animations

```tsx
// Before
<div className="transition-all duration-300">

// After
<div 
  className="transition-all"
  style={{
    transitionDuration: expressiveMotion.duration.medium2,
    transitionTimingFunction: expressiveMotion.easing.emphasized,
  }}
>
```

### Step 7: Update Theme Provider

```tsx
// app/layout.tsx
import { useThemeStore } from '@/lib/stores/themeStore'

export default function RootLayout({ children }) {
  const theme = useThemeStore((state) => state.theme)
  
  return (
    <html lang="en" className={theme === 'dark' ? 'dark' : ''}>
      <body>{children}</body>
    </html>
  )
}
```

## Android Migration (Material 3 Expressive)

### Step 1: Update Theme

```kotlin
// MainActivity.kt or App.kt
import com.neostudios.zest.ui.theme.Material3ExpressiveTheme

@Composable
fun MyApp() {
    Material3ExpressiveTheme(
        darkTheme = isSystemInDarkTheme(),
        dynamicColor = true
    ) {
        // Your app content
    }
}
```

### Step 2: Replace Legacy Colors

```kotlin
// Before
Color(0xFFFFA500)

// After
MaterialTheme.colorScheme.primary

// Before
Color(0xFF00B4D8)

// After
MaterialTheme.colorScheme.secondary
```

### Step 3: Update Buttons

```kotlin
// Before
Button(
    onClick = { },
    colors = ButtonDefaults.buttonColors(
        containerColor = Color(0xFFFFA500)
    )
) {
    Text("Click Me")
}

// After
Button(
    onClick = { },
    colors = ButtonDefaults.buttonColors(
        containerColor = MaterialTheme.colorScheme.primary
    )
) {
    Text("Click Me")
}
```

### Step 4: Update Cards

```kotlin
// Before
Card(
    modifier = Modifier.fillMaxWidth(),
    backgroundColor = Color.White,
    shape = RoundedCornerShape(8.dp)
) {
    // Content
}

// After
Card(
    modifier = Modifier.fillMaxWidth(),
    colors = CardDefaults.cardColors(
        containerColor = MaterialTheme.colorScheme.surfaceContainer
    ),
    shape = MaterialTheme.shapes.large
) {
    // Content
}
```

### Step 5: Update Typography

```kotlin
// Before
Text(
    text = "Title",
    fontSize = 24.sp,
    fontWeight = FontWeight.Bold
)

// After
Text(
    text = "Title",
    style = MaterialTheme.typography.headlineSmall
)
```

### Step 6: Update Text Fields

```kotlin
// Before
OutlinedTextField(
    value = text,
    onValueChange = { text = it },
    label = { Text("Label") }
)

// After
OutlinedTextField(
    value = text,
    onValueChange = { text = it },
    label = { Text("Label") },
    colors = TextFieldDefaults.outlinedTextFieldColors(
        focusedBorderColor = MaterialTheme.colorScheme.primary,
        unfocusedBorderColor = MaterialTheme.colorScheme.outline
    ),
    shape = MaterialTheme.shapes.medium
)
```

## iOS Migration (Liquid Glass)

### Step 1: Import Liquid Glass

```swift
// Add to your SwiftUI view
import SwiftUI
```

### Step 2: Replace Legacy Colors

```swift
// Before
.foregroundColor(Color(red: 1.0, green: 0.647, blue: 0.0))

// After
.foregroundColor(LiquidGlassColors.primary(for: colorScheme))
```

### Step 3: Update Buttons

```swift
// Before
Button(action: {}) {
    Text("Click Me")
        .padding()
        .background(Color.orange)
        .foregroundColor(.white)
        .cornerRadius(8)
}

// After
LiquidGlassButtonEnhanced(
    "Click Me",
    icon: "star.fill",
    style: .primary
) {
    // Action
}
```

### Step 4: Update Cards

```swift
// Before
VStack {
    Text("Content")
}
.padding()
.background(Color.white)
.cornerRadius(12)
.shadow(radius: 5)

// After
LiquidGlassCardEnhanced(
    material: .regular,
    cornerRadius: LiquidGlassCornerRadius.large,
    shadow: .medium
) {
    VStack {
        Text("Content")
    }
}
```

### Step 5: Update Text Fields

```swift
// Before
TextField("Placeholder", text: $text)
    .textFieldStyle(RoundedBorderTextFieldStyle())

// After
LiquidGlassTextField(
    "Placeholder",
    text: $text,
    icon: "envelope"
)
```

### Step 6: Update Typography

```swift
// Before
Text("Title")
    .font(.system(size: 24, weight: .bold))

// After
Text("Title")
    .font(LiquidGlassTypography.headlineSmall)
```

### Step 7: Update Animations

```swift
// Before
withAnimation(.easeInOut(duration: 0.3)) {
    // State change
}

// After
withAnimation(LiquidGlassAnimation.spring) {
    // State change
}
```

### Step 8: Add Materials

```swift
// Before
.background(Color.white.opacity(0.8))

// After
.background(.ultraThinMaterial)

// Or use Liquid Glass card
LiquidGlassCardEnhanced(material: .ultraThin) {
    // Content
}
```

## Common Patterns

### Responsive Spacing

```tsx
// Web
<div className="p-md md:p-lg lg:p-xl">

// Android
modifier = Modifier.padding(
    horizontal = if (isTablet) 24.dp else 16.dp
)

// iOS
.padding(
    UIDevice.current.userInterfaceIdiom == .pad 
        ? LiquidGlassSpacing.xl 
        : LiquidGlassSpacing.lg
)
```

### Dark Mode Support

```tsx
// Web - Automatic with Tailwind dark: prefix
<div className="bg-m3-surface text-m3-on-surface dark:bg-m3-surface dark:text-m3-on-surface">

// Android - Automatic with MaterialTheme
MaterialTheme.colorScheme.surface // Adapts automatically

// iOS - Use adaptive colors
LiquidGlassColors.surface(for: colorScheme)
```

### Interactive States

```tsx
// Web
<button className="hover:shadow-elevation-3 active:scale-95 transition-emphasized">

// Android
modifier = Modifier.clickable { }
    .indication(rememberRipple())

// iOS
.scaleEffect(isPressed ? 0.96 : 1.0)
.animation(LiquidGlassAnimation.interactive, value: isPressed)
```

## Testing Checklist

After migration, verify:

- [ ] All colors use design system tokens
- [ ] Typography follows the scale
- [ ] Spacing is consistent
- [ ] Animations use proper easing
- [ ] Dark mode works correctly
- [ ] Accessibility is maintained
- [ ] Touch targets are adequate (44pt/48dp minimum)
- [ ] Contrast ratios meet WCAG AA
- [ ] Reduced motion is respected

## Troubleshooting

### Web

**Issue**: Colors not applying
- Check Tailwind config imports the design system
- Verify CSS variables are defined in globals.css
- Ensure dark mode class is applied to html element

**Issue**: Animations not smooth
- Use emphasized easing curves
- Check transition duration is appropriate
- Verify no conflicting CSS

### Android

**Issue**: Colors not showing
- Verify Material3ExpressiveTheme is wrapping your app
- Check imports are correct
- Ensure using MaterialTheme.colorScheme

**Issue**: Dynamic color not working
- Requires Android 12+ (API 31+)
- Check dynamicColor parameter is true
- Verify device supports dynamic color

### iOS

**Issue**: Materials not translucent
- Check background is not opaque
- Verify material is applied correctly
- Ensure view hierarchy allows transparency

**Issue**: Animations not fluid
- Use spring animations instead of linear
- Check animation parameters
- Verify state changes trigger animations

## Resources

- [Design Systems Documentation](./DESIGN_SYSTEMS.md)
- [Quick Reference](./DESIGN_QUICK_REFERENCE.md)
- [Material 3 Guidelines](https://m3.material.io/)
- [Liquid Glass Documentation](https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass)
