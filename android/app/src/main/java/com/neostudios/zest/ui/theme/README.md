# Material 3 Expressive Theme for Android

This package contains the Material 3 Expressive theme implementation for Zest Android application.

## Files

- `Material3ExpressiveTheme.kt` - Main theme composable with color schemes
- `Type.kt` - Typography scale
- `Shape.kt` - Shape system

## Usage

### Apply Theme

```kotlin
import com.neostudios.zest.ui.theme.Material3ExpressiveTheme

@Composable
fun MyApp() {
    Material3ExpressiveTheme(
        darkTheme = isSystemInDarkTheme(),
        dynamicColor = true // Enable dynamic color on Android 12+
    ) {
        // Your app content
        Surface(
            modifier = Modifier.fillMaxSize(),
            color = MaterialTheme.colorScheme.background
        ) {
            MainScreen()
        }
    }
}
```

### Use Colors

```kotlin
// Primary colors
MaterialTheme.colorScheme.primary
MaterialTheme.colorScheme.onPrimary
MaterialTheme.colorScheme.primaryContainer
MaterialTheme.colorScheme.onPrimaryContainer

// Secondary colors
MaterialTheme.colorScheme.secondary
MaterialTheme.colorScheme.onSecondary
MaterialTheme.colorScheme.secondaryContainer
MaterialTheme.colorScheme.onSecondaryContainer

// Tertiary colors
MaterialTheme.colorScheme.tertiary
MaterialTheme.colorScheme.onTertiary
MaterialTheme.colorScheme.tertiaryContainer
MaterialTheme.colorScheme.onTertiaryContainer

// Surface colors
MaterialTheme.colorScheme.surface
MaterialTheme.colorScheme.onSurface
MaterialTheme.colorScheme.surfaceVariant
MaterialTheme.colorScheme.onSurfaceVariant
MaterialTheme.colorScheme.surfaceContainer

// Error colors
MaterialTheme.colorScheme.error
MaterialTheme.colorScheme.onError
MaterialTheme.colorScheme.errorContainer
MaterialTheme.colorScheme.onErrorContainer

// Outline
MaterialTheme.colorScheme.outline
MaterialTheme.colorScheme.outlineVariant
```

### Use Typography

```kotlin
// Display styles
Text(
    text = "Display Large",
    style = MaterialTheme.typography.displayLarge
)

// Headline styles
Text(
    text = "Headline Medium",
    style = MaterialTheme.typography.headlineMedium
)

// Title styles
Text(
    text = "Title Large",
    style = MaterialTheme.typography.titleLarge
)

// Body styles
Text(
    text = "Body Large",
    style = MaterialTheme.typography.bodyLarge
)

// Label styles
Text(
    text = "Label Medium",
    style = MaterialTheme.typography.labelMedium
)
```

### Use Shapes

```kotlin
// Apply shapes to components
Card(
    shape = MaterialTheme.shapes.large
) {
    // Content
}

Button(
    shape = MaterialTheme.shapes.medium
) {
    Text("Button")
}

// Available shapes
MaterialTheme.shapes.extraSmall // 4dp
MaterialTheme.shapes.small      // 8dp
MaterialTheme.shapes.medium     // 12dp
MaterialTheme.shapes.large      // 16dp
MaterialTheme.shapes.extraLarge // 28dp
```

## Components

### Button

```kotlin
Button(
    onClick = { },
    colors = ButtonDefaults.buttonColors(
        containerColor = MaterialTheme.colorScheme.primary,
        contentColor = MaterialTheme.colorScheme.onPrimary
    ),
    shape = MaterialTheme.shapes.medium
) {
    Icon(Icons.Default.Add, contentDescription = null)
    Spacer(modifier = Modifier.width(8.dp))
    Text("Add Item")
}

// Outlined button
OutlinedButton(
    onClick = { },
    colors = ButtonDefaults.outlinedButtonColors(
        contentColor = MaterialTheme.colorScheme.primary
    )
) {
    Text("Outlined")
}

// Text button
TextButton(onClick = { }) {
    Text("Text Button")
}

// Elevated button
ElevatedButton(onClick = { }) {
    Text("Elevated")
}

// Filled tonal button
FilledTonalButton(onClick = { }) {
    Text("Tonal")
}
```

### Card

```kotlin
Card(
    modifier = Modifier.fillMaxWidth(),
    colors = CardDefaults.cardColors(
        containerColor = MaterialTheme.colorScheme.surfaceContainer
    ),
    shape = MaterialTheme.shapes.large,
    elevation = CardDefaults.cardElevation(
        defaultElevation = 2.dp
    )
) {
    Column(modifier = Modifier.padding(16.dp)) {
        Text(
            text = "Card Title",
            style = MaterialTheme.typography.titleLarge
        )
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = "Card content goes here",
            style = MaterialTheme.typography.bodyMedium
        )
    }
}

// Outlined card
OutlinedCard(
    modifier = Modifier.fillMaxWidth(),
    shape = MaterialTheme.shapes.large
) {
    // Content
}

// Elevated card
ElevatedCard(
    modifier = Modifier.fillMaxWidth(),
    elevation = CardDefaults.elevatedCardElevation(
        defaultElevation = 6.dp
    )
) {
    // Content
}
```

### Text Field

```kotlin
var text by remember { mutableStateOf("") }

OutlinedTextField(
    value = text,
    onValueChange = { text = it },
    label = { Text("Label") },
    placeholder = { Text("Placeholder") },
    leadingIcon = {
        Icon(Icons.Default.Email, contentDescription = null)
    },
    colors = TextFieldDefaults.outlinedTextFieldColors(
        focusedBorderColor = MaterialTheme.colorScheme.primary,
        unfocusedBorderColor = MaterialTheme.colorScheme.outline
    ),
    shape = MaterialTheme.shapes.medium
)

// Filled text field
TextField(
    value = text,
    onValueChange = { text = it },
    label = { Text("Label") },
    colors = TextFieldDefaults.textFieldColors(
        containerColor = MaterialTheme.colorScheme.surfaceVariant
    )
)
```

### Surface

```kotlin
Surface(
    modifier = Modifier.fillMaxWidth(),
    color = MaterialTheme.colorScheme.surface,
    tonalElevation = 2.dp,
    shape = MaterialTheme.shapes.medium
) {
    // Content
}
```

## Dynamic Color

Material 3 Expressive supports dynamic color on Android 12+ (API 31+):

```kotlin
Material3ExpressiveTheme(
    dynamicColor = true // Automatically uses system colors on Android 12+
) {
    // App content
}
```

Dynamic color will:
- Extract colors from the user's wallpaper
- Apply them to your app's color scheme
- Maintain accessibility and contrast
- Fall back to static colors on older Android versions

## Dark Theme

The theme automatically adapts to system dark mode:

```kotlin
Material3ExpressiveTheme(
    darkTheme = isSystemInDarkTheme()
) {
    // App content
}
```

Or force a specific theme:

```kotlin
Material3ExpressiveTheme(
    darkTheme = true // Always dark
) {
    // App content
}
```

## Color Palette

### Light Theme
- Primary: #FFA500 (Orange)
- Secondary: #00B4D8 (Blue)
- Tertiary: #4CAF50 (Green)
- Surface: #FFF8E1 (Warm White)
- Error: #BA1A1A (Red)

### Dark Theme
- Primary: #FFB733 (Light Orange)
- Secondary: #33C3E3 (Light Blue)
- Tertiary: #6FBF73 (Light Green)
- Surface: #1C1B1F (Dark Gray)
- Error: #FFB4AB (Light Red)

## Resources

- [Material 3 Expressive](https://m3.material.io/blog/building-with-m3-expressive)
- [Compose Material 3](https://developer.android.com/reference/kotlin/androidx/compose/material3/package-summary)
- [Design System Documentation](../../../../../../../docs/DESIGN_SYSTEMS.md)
- [Quick Reference](../../../../../../../docs/DESIGN_QUICK_REFERENCE.md)
- [Migration Guide](../../../../../../../docs/DESIGN_MIGRATION.md)

## Best Practices

1. **Always use MaterialTheme**: Access colors, typography, and shapes through `MaterialTheme`
2. **Semantic colors**: Use semantic color names (primary, surface) instead of hardcoded colors
3. **Respect elevation**: Use appropriate elevation levels for component hierarchy
4. **Support dark mode**: Test your UI in both light and dark themes
5. **Dynamic color**: Enable dynamic color for Android 12+ devices
6. **Accessibility**: Maintain proper contrast ratios and touch target sizes
