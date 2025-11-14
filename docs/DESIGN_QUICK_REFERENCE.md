# Design System Quick Reference

Quick reference for implementing Material 3 Expressive and Liquid Glass design systems.

## Color Palette

### Material 3 Expressive (Web & Android)

| Color | Light | Dark | Usage |
|-------|-------|------|-------|
| Primary | `#FFA500` | `#FFB733` | Main brand color, primary actions |
| Secondary | `#00B4D8` | `#33C3E3` | Secondary actions, accents |
| Tertiary | `#4CAF50` | `#6FBF73` | Tertiary actions, highlights |
| Surface | `#FFF8E1` | `#1C1B1F` | Background surfaces |
| Error | `#BA1A1A` | `#FFB4AB` | Error states, warnings |

### Liquid Glass (iOS)

Same color palette with adaptive rendering for light/dark modes using translucent materials.

## Typography Scale

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| Display Large | 57px | Regular | Hero text |
| Display Medium | 45px | Regular | Large headings |
| Display Small | 36px | Regular | Section headings |
| Headline Large | 32px | Regular/Semibold | Page titles |
| Headline Medium | 28px | Regular/Semibold | Card titles |
| Headline Small | 24px | Regular/Semibold | List headers |
| Title Large | 22px | Medium | Prominent text |
| Title Medium | 16px | Medium | Subtitles |
| Title Small | 14px | Medium | Small titles |
| Body Large | 16px | Regular | Main content |
| Body Medium | 14px | Regular | Secondary content |
| Body Small | 12px | Regular | Captions |
| Label Large | 14px | Medium | Button text |
| Label Medium | 12px | Medium | Small buttons |
| Label Small | 11px | Medium | Badges, chips |

## Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| xs | 4px | Tight spacing |
| sm | 8px | Compact spacing |
| md | 12px | Default spacing |
| lg | 16px | Comfortable spacing |
| xl | 24px | Loose spacing |
| 2xl | 32px | Section spacing |
| 3xl | 48px | Large gaps |
| 4xl | 64px | Extra large gaps |

## Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| Extra Small | 4px | Chips, badges |
| Small | 8px | Small buttons |
| Medium | 12px | Text fields, cards |
| Large | 16px | Large cards |
| Extra Large | 28px | Dialogs, sheets |
| Full | 9999px | Pills, circular buttons |

## Elevation Levels

| Level | Usage | Shadow |
|-------|-------|--------|
| 0 | Flat surfaces | None |
| 1 | Slightly raised | Subtle shadow |
| 2 | Cards, buttons | Medium shadow |
| 3 | Floating elements | Prominent shadow |
| 4 | Dialogs | Strong shadow |
| 5 | Modal overlays | Maximum shadow |

## Animation Timing

| Duration | Value | Usage |
|----------|-------|-------|
| Short 1-4 | 50-200ms | Micro-interactions |
| Medium 1-4 | 250-400ms | Standard transitions |
| Long 1-4 | 450-600ms | Complex animations |
| Extra Long 1-4 | 700-1000ms | Page transitions |

## Easing Curves

| Curve | Usage |
|-------|-------|
| Emphasized | Important state changes |
| Emphasized Decelerate | Entering elements |
| Emphasized Accelerate | Exiting elements |
| Standard | Default transitions |

## Component Variants

### Buttons

| Variant | Usage |
|---------|-------|
| Filled | Primary actions |
| Outlined | Secondary actions |
| Text | Tertiary actions |
| Elevated | Floating actions |
| Tonal | Subtle emphasis |

### Cards

| Variant | Usage |
|---------|-------|
| Elevated | Default cards |
| Filled | Emphasized cards |
| Outlined | Subtle cards |

### Text Fields

| Variant | Usage |
|---------|-------|
| Filled | Default input |
| Outlined | Prominent input |

## Platform-Specific Features

### Web (Material 3 Expressive)

```tsx
// Tailwind classes
className="bg-m3-primary-main text-m3-on-primary"
className="shadow-elevation-2 rounded-large"
className="transition-emphasized duration-medium2"
```

### Android (Material 3 Expressive)

```kotlin
// Material Theme
MaterialTheme.colorScheme.primary
MaterialTheme.typography.headlineMedium
MaterialTheme.shapes.large
```

### iOS (Liquid Glass)

```swift
// Liquid Glass
LiquidGlassColors.primary(for: colorScheme)
LiquidGlassTypography.headlineMedium
LiquidGlassCornerRadius.large
LiquidGlassAnimation.spring
```

## Accessibility

### Contrast Ratios (WCAG AA)

- Normal text: 4.5:1 minimum
- Large text (18pt+): 3:1 minimum
- UI components: 3:1 minimum

### Touch Targets

- Minimum: 44x44 points (iOS), 48x48 dp (Android)
- Recommended: 48x48 points/dp

### Motion

- Respect `prefers-reduced-motion`
- Provide alternatives to motion-based interactions
- Keep animations under 400ms for accessibility

## Resources

- Full documentation: [DESIGN_SYSTEMS.md](./DESIGN_SYSTEMS.md)
- Material 3: https://m3.material.io/
- Liquid Glass: https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass
