# Settings System

## Overview

Zest includes a comprehensive settings system with persistent storage and real-time application of user preferences.

## Features

### ✅ Theme Settings
- **Light Mode**: Bright, clean interface
- **Dark Mode**: Easy on the eyes
- **System**: Follows OS preference
- **Auto-switching**: Responds to system theme changes

### ✅ Accessibility Settings

#### Font Size
- Small (14px)
- Medium (16px) - Default
- Large (18px)
- Extra Large (20px)

#### Reduced Motion
- Disables animations and transitions
- Improves experience for users with motion sensitivity
- Sets all animations to 0.01ms

#### High Contrast
- Increases contrast ratio
- Thicker borders (2px)
- Enhanced visibility

#### Color Blind Modes
- **None**: Standard colors
- **Protanopia**: Red-blind simulation
- **Deuteranopia**: Green-blind simulation
- **Tritanopia**: Blue-blind simulation
- Uses SVG color matrix filters

#### Screen Reader Optimization
- Switches to OpenDyslexic font
- Increased line height (1.8)
- Increased letter spacing (0.05em)
- Better readability

### ✅ General Settings
- **Notifications**: Enable/disable notifications
- **Offline Mode**: Enable offline data persistence
- **Language**: Multi-language support (21 languages)

## Implementation

### Stores

**Theme Store** (`web/src/lib/stores/themeStore.ts`)
```typescript
const { theme, setTheme } = useThemeStore()
// theme: 'light' | 'dark' | 'system'
```

**Settings Store** (`web/src/lib/stores/settingsStore.ts`)
```typescript
const {
  fontSize,
  setFontSize,
  reducedMotion,
  setReducedMotion,
  highContrast,
  setHighContrast,
  colorBlindMode,
  setColorBlindMode,
  screenReader,
  setScreenReader,
  notifications,
  setNotifications,
  offlineMode,
  setOfflineMode,
  language,
  setLanguage,
} = useSettingsStore()
```

### Providers

**ThemeProvider** (`web/src/components/providers/ThemeProvider.tsx`)
- Applies theme classes to `<html>` element
- Listens for system theme changes
- Automatically updates when theme changes

**SettingsProvider** (`web/src/components/providers/SettingsProvider.tsx`)
- Applies all accessibility settings
- Updates DOM classes and styles
- Real-time application of changes

### Persistence

All settings are persisted using Zustand's persist middleware:
- Stored in localStorage
- Survives page refreshes
- Synced across tabs

**Storage Keys:**
- `theme-storage`: Theme preference
- `settings-storage`: All other settings

## Usage

### In Components

```typescript
import { useThemeStore } from '@/lib/stores/themeStore'
import { useSettingsStore } from '@/lib/stores/settingsStore'

function MyComponent() {
  const { theme, setTheme } = useThemeStore()
  const { fontSize, setFontSize } = useSettingsStore()
  
  return (
    <div>
      <button onClick={() => setTheme('dark')}>
        Dark Mode
      </button>
      <button onClick={() => setFontSize('large')}>
        Large Text
      </button>
    </div>
  )
}
```

### Settings Page

The settings page (`web/src/app/settings/page.tsx`) provides a UI for all settings:
- Theme selector
- Font size selector
- Accessibility toggles
- Language selector
- Account information
- Sign out button

## CSS Classes Applied

### Theme
```css
html.light { /* Light theme styles */ }
html.dark { /* Dark theme styles */ }
```

### Font Size
```css
html.text-sm { font-size: 14px; }
html.text-base { font-size: 16px; }
html.text-lg { font-size: 18px; }
html.text-xl { font-size: 20px; }
```

### Accessibility
```css
html.reduce-motion { /* Disables animations */ }
html.high-contrast { /* Increases contrast */ }
html.protanopia { /* Red-blind filter */ }
html.deuteranopia { /* Green-blind filter */ }
html.tritanopia { /* Blue-blind filter */ }
html.screen-reader-optimized { /* Enhanced readability */ }
```

## Color Blind Filters

SVG color matrix filters are used to simulate color blindness:

```xml
<!-- Protanopia (Red-Blind) -->
<filter id="protanopia-filter">
  <feColorMatrix type="matrix" values="
    0.567, 0.433, 0,     0, 0
    0.558, 0.442, 0,     0, 0
    0,     0.242, 0.758, 0, 0
    0,     0,     0,     1, 0"/>
</filter>
```

These filters are applied via CSS:
```css
.protanopia {
  filter: url('#protanopia-filter');
}
```

## Keyboard Navigation

Enhanced focus indicators for keyboard users:
```css
*:focus-visible {
  outline: 3px solid var(--m3-primary);
  outline-offset: 2px;
}
```

## Testing

### Manual Testing Checklist

**Theme:**
- [ ] Switch to light mode → UI updates
- [ ] Switch to dark mode → UI updates
- [ ] Switch to system → Follows OS preference
- [ ] Change OS theme → App updates automatically

**Font Size:**
- [ ] Small → Text is smaller
- [ ] Medium → Default size
- [ ] Large → Text is larger
- [ ] Extra Large → Text is largest

**Reduced Motion:**
- [ ] Enable → Animations stop
- [ ] Disable → Animations resume

**High Contrast:**
- [ ] Enable → Borders thicker, contrast higher
- [ ] Disable → Normal appearance

**Color Blind Modes:**
- [ ] Protanopia → Red tones adjusted
- [ ] Deuteranopia → Green tones adjusted
- [ ] Tritanopia → Blue tones adjusted
- [ ] None → Normal colors

**Screen Reader:**
- [ ] Enable → Font changes to OpenDyslexic
- [ ] Enable → Line height increases
- [ ] Disable → Normal font

**Persistence:**
- [ ] Change settings → Refresh page → Settings persist
- [ ] Open in new tab → Settings synced

## Browser Support

### LocalStorage
- Required for settings persistence
- Fallback: Settings reset on page refresh

### CSS Filters
- Modern browsers support SVG filters
- Fallback: Color blind modes won't work in old browsers

### prefers-color-scheme
- Modern browsers support system theme detection
- Fallback: Manual theme selection only

## Future Enhancements

- [ ] Custom theme colors
- [ ] Font family selection
- [ ] Compact/comfortable density modes
- [ ] Custom keyboard shortcuts
- [ ] Import/export settings
- [ ] Settings sync across devices (via Firestore)
- [ ] A/B testing for default settings
- [ ] Analytics for most-used settings
- [ ] Preset accessibility profiles
- [ ] Voice control settings

## Troubleshooting

### Settings don't persist
- Check browser localStorage is enabled
- Check for browser extensions blocking storage
- Clear cache and try again

### Theme doesn't change
- Check ThemeProvider is in layout
- Check CSS classes are applied to `<html>`
- Inspect element to verify classes

### Color blind mode doesn't work
- Check SVG filters are in DOM
- Check browser supports CSS filters
- Try different browser

### Font size doesn't change
- Check SettingsProvider is in layout
- Check CSS is loaded
- Inspect `<html>` element for classes

## Accessibility Compliance

The settings system helps achieve:
- ✅ WCAG 2.1 Level AA compliance
- ✅ Section 508 compliance
- ✅ ADA compliance
- ✅ EN 301 549 compliance

Key features:
- Keyboard navigation support
- Screen reader optimization
- Color contrast options
- Motion reduction
- Text resizing
- Color blind support
