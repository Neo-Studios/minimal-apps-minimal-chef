# Material 3 Expressive Design System

This folder contains the Material 3 Expressive design system implementation for Zest web application.

## Files

- `material3-expressive.ts` - Complete design token system

## Usage

### Import Design Tokens

```typescript
import {
  expressiveColors,
  expressiveColorsDark,
  expressiveTypography,
  expressiveElevation,
  expressiveMotion,
  expressiveShape,
  expressiveSpacing,
} from '@/lib/design/material3-expressive'
```

### Use in Components

```tsx
// Colors
<div style={{ backgroundColor: expressiveColors.primary.main }}>

// Typography
<p style={{ ...expressiveTypography.headline.large }}>

// Elevation
<div style={{ boxShadow: expressiveElevation.level2 }}>

// Motion
<div style={{
  transitionDuration: expressiveMotion.duration.medium2,
  transitionTimingFunction: expressiveMotion.easing.emphasized,
}}>

// Shape
<div style={{ borderRadius: expressiveShape.corner.large }}>

// Spacing
<div style={{ padding: expressiveSpacing.lg }}>
```

### Use with Tailwind

The design tokens are integrated into Tailwind CSS configuration. Use Tailwind classes:

```tsx
// Colors
<div className="bg-m3-primary-main text-m3-on-primary">

// Elevation
<div className="shadow-elevation-2">

// Border Radius
<div className="rounded-large">

// Spacing
<div className="p-lg gap-md">

// Transitions
<div className="transition-emphasized duration-medium2">
```

## Design Tokens

### Colors

- **Primary**: Orange (#FFA500 light, #FFB733 dark)
- **Secondary**: Blue (#00B4D8 light, #33C3E3 dark)
- **Tertiary**: Green (#4CAF50 light, #6FBF73 dark)
- **Surface**: Warm white (#FFF8E1 light, #1C1B1F dark)
- **Error**: Red (#BA1A1A light, #FFB4AB dark)

### Typography Scale

- Display: 57px, 45px, 36px
- Headline: 32px, 28px, 24px
- Title: 22px, 16px, 14px
- Body: 16px, 14px, 12px
- Label: 14px, 12px, 11px

### Elevation Levels

- Level 0: No shadow
- Level 1: Subtle shadow
- Level 2: Medium shadow
- Level 3: Prominent shadow
- Level 4: Strong shadow
- Level 5: Maximum shadow

### Motion

**Durations**: 50ms - 1000ms
**Easing**: Emphasized, Standard, Legacy (with accelerate/decelerate variants)

### Shapes

**Corner Radius**: 0px, 4px, 8px, 12px, 16px, 28px, 9999px

### Spacing

**Scale**: 4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px

## Components

Pre-built Material 3 components are available in `@/components/ui`:

- `Material3Button` - 5 variants (filled, outlined, text, elevated, tonal)
- `Material3Card` - 3 variants (elevated, filled, outlined)
- `Material3TextField` - Accessible input with icons

## Resources

- [Material 3 Expressive Blog](https://m3.material.io/blog/building-with-m3-expressive)
- [Material 3 Guidelines](https://m3.material.io/)
- [Design System Documentation](../../../../docs/DESIGN_SYSTEMS.md)
- [Quick Reference](../../../../docs/DESIGN_QUICK_REFERENCE.md)
- [Migration Guide](../../../../docs/DESIGN_MIGRATION.md)

## Showcase

View all components and design tokens in action:
- Navigate to `/design-showcase` in your browser
- See live examples of colors, buttons, cards, text fields, typography, elevation, and spacing
