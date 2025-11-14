# Adaptive Layouts

Zest implements responsive, adaptive layouts that optimize the user experience for different screen sizes across all platforms.

## Layout Strategy

### Phone (Compact)
- **Bottom Navigation Bar**: 4 main sections
- **Hamburger Menu**: Access to all 8 sections
- **Single Column**: Content stacks vertically
- **Full Screen**: Maximize content area

### Tablet (Medium/Large)
- **Sidebar Navigation**: All 8 sections always visible
- **NO Bottom Navigation**: Clean, desktop-like experience
- **Multi-Column**: Content uses available space
- **Split Views**: Master-detail patterns

## Platform Implementations

### Web

#### Breakpoints
- **Mobile**: < 768px (Compact)
- **Tablet**: ≥ 768px (Medium/Large)
- **Desktop**: ≥ 1024px (Extra Large)

#### Mobile Layout (< 768px)
```
┌─────────────────────┐
│  [☰] Zest      [ ]  │ ← Top bar with menu
├─────────────────────┤
│                     │
│                     │
│   Main Content      │
│                     │
│                     │
├─────────────────────┤
│ 📖  📅  🛒  ⚙️     │ ← Bottom nav (4 items)
└─────────────────────┘
```

**Features:**
- Hamburger menu opens drawer with all 8 sections
- Bottom navigation shows 4 main sections
- Content area has bottom padding for nav bar
- Drawer overlays content when open

#### Tablet Layout (≥ 768px)
```
┌──────┬──────────────────────────┐
│ Zest │                          │
├──────┤                          │
│ 📖   │                          │
│ 📅   │                          │
│ 🛒   │    Main Content          │
│ 📚   │                          │
│ 📊   │                          │
│ ⏱️   │                          │
│ 🤖   │                          │
│ ⚙️   │                          │
├──────┤                          │
│  U   │                          │
└──────┴──────────────────────────┘
```

**Features:**
- Permanent sidebar (collapsible)
- All 8 sections visible
- NO bottom navigation bar
- User profile at bottom of sidebar
- Content uses full height

### Android

#### Size Classes
- **Compact**: < 600dp (Phone)
- **Medium**: 600-839dp (Small tablet, portrait)
- **Expanded**: ≥ 840dp (Large tablet, landscape)

#### Compact Layout (Phone)
```
┌─────────────────────┐
│ [☰] Zest            │ ← Top app bar
├─────────────────────┤
│                     │
│                     │
│   Main Content      │
│                     │
│                     │
├─────────────────────┤
│ 📖  📅  🛒  ⚙️     │ ← Bottom nav
└─────────────────────┘
```

**Features:**
- Modal navigation drawer with all 8 sections
- Top app bar with menu button
- Bottom navigation bar with 4 main sections
- Material 3 Expressive design

#### Medium Layout (Small Tablet)
```
┌─┬────────────────────┐
│📖│                    │
│📅│                    │
│🛒│                    │
│📚│   Main Content     │
│📊│                    │
│⏱️│                    │
│🤖│                    │
│⚙️│                    │
└─┴────────────────────┘
```

**Features:**
- Navigation rail (compact sidebar)
- Icons with labels
- All 8 sections visible
- NO bottom navigation bar
- Full height content

#### Expanded Layout (Large Tablet)
```
┌────────┬─────────────────────┐
│  Zest  │                     │
├────────┤                     │
│ 📖 Rec │                     │
│ 📅 Mea │                     │
│ 🛒 Sho │   Main Content      │
│ 📚 Coo │                     │
│ 📊 Nut │                     │
│ ⏱️ Tim │                     │
│ 🤖 AI  │                     │
│ ⚙️ Set │                     │
├────────┤                     │
│   U    │                     │
└────────┴─────────────────────┘
```

**Features:**
- Permanent navigation drawer
- Full labels with icons
- All 8 sections visible
- NO bottom navigation bar
- User profile at bottom
- Full height content

### iOS

#### Size Classes
- **Compact**: iPhone (all sizes)
- **Regular**: iPad (all sizes)

#### Compact Layout (iPhone)
```
┌─────────────────────┐
│                     │
│                     │
│   Main Content      │
│                     │
│                     │
├─────────────────────┤
│ 📖  📅  🛒  ⚙️     │ ← Tab bar
└─────────────────────┘
```

**Features:**
- TabView with 4 main tabs
- Additional sections in "More" tab
- Native iOS tab bar
- Liquid Glass design

#### Regular Layout (iPad)
```
┌────────┬──────────┬────────────┐
│  Zest  │          │            │
├────────┤          │            │
│ 📖 Rec │          │            │
│ 📅 Mea │  List/   │   Detail   │
│ 🛒 Sho │  Grid    │   View     │
│ 📚 Coo │  View    │            │
│ 📊 Nut │          │            │
│ ⏱️ Tim │          │            │
│ 🤖 AI  │          │            │
│ ⚙️ Set │          │            │
└────────┴──────────┴────────────┘
```

**Features:**
- NavigationSplitView (3 columns)
- Sidebar: All 8 sections
- Content: List/grid view
- Detail: Item details
- NO bottom tab bar
- Adapts to portrait/landscape
- Supports slide-over and split-view

## Navigation Sections

All platforms include these 8 sections:

1. **📖 Recipes** - Browse and manage recipes
2. **📅 Meal Plan** - Calendar-based meal planning
3. **🛒 Shopping** - Shopping lists
4. **📚 Cookbooks** - Recipe collections
5. **📊 Nutrition** - Nutrition tracking dashboard
6. **⏱️ Timers** - Cooking timers
7. **🤖 AI Assistant** - AI recipe generator
8. **⚙️ Settings** - App settings

### Phone Navigation
- **Bottom Bar**: Recipes, Meal Plan, Shopping, Settings (4 most used)
- **Menu/Drawer**: All 8 sections accessible

### Tablet Navigation
- **Sidebar**: All 8 sections always visible
- **NO Bottom Bar**: Clean, uncluttered interface

## Responsive Behavior

### Web
```typescript
// Automatically switches layout based on screen width
const isTablet = useMediaQuery('(min-width: 768px)')

if (isTablet) {
  return <TabletLayout>{children}</TabletLayout>
} else {
  return <MobileLayout>{children}</MobileLayout>
}
```

### Android
```kotlin
// Uses WindowSizeClass to determine layout
when (windowSizeClass.widthSizeClass) {
    WindowWidthSizeClass.Compact -> CompactLayout()
    WindowWidthSizeClass.Medium -> TabletLayout(isExpanded = false)
    WindowWidthSizeClass.Expanded -> TabletLayout(isExpanded = true)
}
```

### iOS
```swift
// Uses horizontalSizeClass environment value
@Environment(\.horizontalSizeClass) var horizontalSizeClass

if horizontalSizeClass == .regular {
    TabletMainView() // iPad - sidebar only
} else {
    MainTabView() // iPhone - tab bar
}
```

## Design Principles

### 1. Context-Aware Navigation
- **Phone**: Prioritize most-used features in bottom nav
- **Tablet**: Show all features for quick access

### 2. Maximize Content Area
- **Phone**: Bottom nav is compact (16px/48dp/44pt)
- **Tablet**: Sidebar is collapsible, no bottom nav

### 3. Consistent Patterns
- Same navigation order across all platforms
- Same icons and labels
- Same color coding and states

### 4. Platform Native
- **Web**: Material 3 Expressive
- **Android**: Material 3 Expressive with dynamic color
- **iOS**: Liquid Glass with native components

### 5. Accessibility
- Minimum touch targets (44pt/48dp/44px)
- Clear focus indicators
- Screen reader support
- Keyboard navigation (Web)

## Breakpoint Reference

| Platform | Phone | Small Tablet | Large Tablet | Desktop |
|----------|-------|--------------|--------------|---------|
| **Web** | < 768px | 768-1023px | 1024-1439px | ≥ 1440px |
| **Android** | < 600dp | 600-839dp | ≥ 840dp | N/A |
| **iOS** | Compact | N/A | Regular | N/A |

## Layout Components

### Web
- `MobileLayout.tsx` - Phone layout with bottom nav
- `TabletLayout.tsx` - Tablet layout with sidebar only
- `AdaptiveLayout.tsx` - Switches between layouts
- `useMediaQuery.ts` - Responsive hooks

### Android
- `AdaptiveNavigation.kt` - Main adaptive component
- `CompactLayout()` - Phone with bottom nav
- `TabletLayout()` - Tablet with rail/drawer only
- `WindowSizeClass` - Size detection

### iOS
- `MainTabView.swift` - Phone with tab bar
- `TabletMainView.swift` - iPad with sidebar only
- `ContentView.swift` - Adaptive switcher
- `horizontalSizeClass` - Size detection

## Testing Layouts

### Web
```bash
# Test different screen sizes
npm run dev

# Open browser DevTools
# Toggle device toolbar (Cmd/Ctrl + Shift + M)
# Test: iPhone SE, iPad, Desktop
```

### Android
```bash
# Test on different devices
./gradlew installDebug

# Use Android Studio device manager
# Test: Phone, 7" tablet, 10" tablet
```

### iOS
```bash
# Test on different simulators
# Xcode > Product > Destination
# Test: iPhone 15, iPad Pro 11", iPad Pro 12.9"
```

## Best Practices

1. **Always test on real devices** - Simulators don't show real performance
2. **Test orientation changes** - Portrait and landscape
3. **Test with different content** - Empty states, full lists, long text
4. **Test accessibility** - Screen readers, voice control, keyboard
5. **Test edge cases** - Very small phones, very large tablets

## Resources

- [Material 3 Adaptive Layouts](https://m3.material.io/foundations/layout/applying-layout/window-size-classes)
- [iOS Human Interface Guidelines - Layout](https://developer.apple.com/design/human-interface-guidelines/layout)
- [Responsive Web Design](https://web.dev/responsive-web-design-basics/)
