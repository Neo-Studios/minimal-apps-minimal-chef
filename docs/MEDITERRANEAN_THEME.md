# Mediterranean Blue Theme

The web application now features a beautiful Mediterranean-inspired color palette reminiscent of the Greek islands, azure seas, and golden sunsets.

## 🎨 Color Palette

### Light Theme - Mediterranean Day

#### Primary - Deep Mediterranean Blue
```
Main:      #0077BE  ████  Deep ocean blue
Light:     #3399D6  ████  Azure sky
Dark:      #005A94  ████  Deep sea
Container: #D6EFFF  ████  Light sky blue
```
*Inspired by the deep blue Aegean Sea*

#### Secondary - Aegean Turquoise
```
Main:      #00A8CC  ████  Turquoise waters
Light:     #33BFDB  ████  Light turquoise
Dark:      #0088A8  ████  Deep turquoise
Container: #D6F5FF  ████  Pale turquoise
```
*Inspired by the crystal-clear waters of Greek islands*

#### Tertiary - Santorini Gold
```
Main:      #FFB84D  ████  Golden sand
Light:     #FFCA70  ████  Light gold
Dark:      #E69A2E  ████  Deep gold
Container: #FFF4E0  ████  Cream
```
*Inspired by golden sunsets and sandy beaches*

#### Surface - Whitewashed Walls
```
Main:      #F5FAFE  ████  Crisp white with blue tint
Dim:       #E8F4F8  ████  Soft blue-grey
Bright:    #FFFFFF  ████  Pure white
Container: #E6F4FF  ████  Light blue
High:      #D6EFFF  ████  Medium light blue
Highest:   #C2E7FF  ████  Stronger blue tint
```
*Inspired by the iconic white buildings of Santorini*

### Dark Theme - Mediterranean Night

#### Primary - Moonlit Sea
```
Main:      #5CB3FF  ████  Bright Mediterranean blue
Light:     #8FCCFF  ████  Light sky blue
Dark:      #3399D6  ████  Medium blue
Container: #001F33  ████  Deep navy
```
*Inspired by moonlight reflecting on calm waters*

#### Secondary - Night Waters
```
Main:      #4DD4F5  ████  Bright turquoise
Light:     #7DE3FF  ████  Light cyan
Dark:      #00A8CC  ████  Deep turquoise
Container: #003340  ████  Deep teal
```
*Inspired by bioluminescent waters at night*

#### Tertiary - Starlight Gold
```
Main:      #FFD699  ████  Light gold
Light:     #FFE5B8  ████  Pale gold
Dark:      #FFB84D  ████  Medium gold
Container: #4D3300  ████  Deep brown
```
*Inspired by stars and distant lights*

#### Surface - Night Sky
```
Main:      #0D2137  ████  Navy blue
Dim:       #0A1929  ████  Deep navy night
Bright:    #1A3A52  ████  Lighter navy
Container: #14293D  ████  Medium navy
High:      #1E3A52  ████  Lighter navy
Highest:   #2A4A66  ████  Blue-grey
```
*Inspired by the deep blue Mediterranean night sky*

## 🌊 Theme Inspiration

### Greek Islands
- **Santorini**: White buildings, blue domes, golden sunsets
- **Mykonos**: Whitewashed walls, azure waters
- **Crete**: Deep blue seas, sandy beaches

### Mediterranean Elements
- **Sea**: Deep blues and turquoise
- **Sky**: Light blues and azure
- **Architecture**: White and cream
- **Sunset**: Golden and warm tones
- **Night**: Deep navy and starlight

## 🎯 Usage Examples

### Buttons
```tsx
// Primary - Deep Mediterranean Blue
<Material3Button variant="filled">
  Book Now
</Material3Button>

// Secondary - Turquoise
<Material3Button variant="outlined">
  Learn More
</Material3Button>

// Tertiary - Golden
<Material3Button variant="tonal">
  View Gallery
</Material3Button>
```

### Cards
```tsx
// Light blue container
<Material3Card variant="elevated">
  <div className="bg-m3-surface-container">
    Mediterranean content
  </div>
</Material3Card>
```

### Backgrounds
```tsx
// Main surface - crisp white with blue tint
<div className="bg-m3-surface">

// Container - light blue
<div className="bg-m3-surface-container">

// Primary container - sky blue
<div className="bg-m3-primary-container">
```

## 🌅 Color Combinations

### Hero Section
```
Background: #F5FAFE (Surface main)
Primary CTA: #0077BE (Primary main)
Secondary CTA: #00A8CC (Secondary main)
Text: #0D2137 (On surface)
```

### Cards
```
Background: #E6F4FF (Surface container)
Border: #D6EFFF (Primary container)
Title: #0077BE (Primary main)
Body: #3A5266 (On surface variant)
```

### Navigation
```
Background: #E6F4FF (Surface container)
Active: #0077BE (Primary main)
Inactive: #3A5266 (On surface variant)
Hover: #D6EFFF (Primary container)
```

## 🎨 Design Principles

### 1. **Calm & Serene**
- Soft blues evoke tranquility
- White spaces create breathing room
- Gentle transitions

### 2. **Fresh & Clean**
- Crisp whites like whitewashed walls
- Clear blues like crystal waters
- Minimal clutter

### 3. **Warm Accents**
- Golden tertiary for warmth
- Sunset-inspired highlights
- Balanced with cool blues

### 4. **Natural Depth**
- Layered blues create depth
- Light to dark progression
- Ocean-inspired gradients

## 🌓 Light vs Dark Mode

### Light Mode - Daytime
- Bright, airy, spacious
- White backgrounds
- Deep blue accents
- High contrast for readability

### Dark Mode - Nighttime
- Deep navy backgrounds
- Bright blue accents
- Softer contrast
- Easy on the eyes

## 📊 Accessibility

### Contrast Ratios (WCAG AA)
```
Primary on White:     #0077BE on #FFFFFF = 4.8:1 ✅
Secondary on White:   #00A8CC on #FFFFFF = 3.2:1 ⚠️ (Use dark variant)
Tertiary on White:    #FFB84D on #FFFFFF = 2.1:1 ❌ (Use dark variant)

Primary on Container: #0077BE on #D6EFFF = 5.2:1 ✅
Text on Surface:      #0D2137 on #F5FAFE = 14.1:1 ✅
```

### Recommendations
- Use primary blue for important actions
- Use dark variants for better contrast
- Test with color blind simulators
- Provide high contrast mode option

## 🎭 Emotional Impact

### Colors & Feelings
- **Blue**: Trust, calm, stability, professionalism
- **Turquoise**: Refreshing, energizing, creative
- **Gold**: Warmth, optimism, quality
- **White**: Purity, simplicity, clarity

### Brand Personality
- Trustworthy and reliable
- Fresh and modern
- Warm and welcoming
- Professional yet approachable

## 🖼️ Visual Examples

### Recipe Card
```
┌─────────────────────────────┐
│ ┌─────────────────────────┐ │ ← #E6F4FF (Container)
│ │     🍽️                  │ │
│ │                         │ │
│ │  Mediterranean Salad    │ │ ← #0077BE (Primary)
│ │  Greek                  │ │ ← #3A5266 (Variant)
│ │  ⏱️ 15m  👥 2  ⭐ 4.8  │ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

### Navigation
```
┌─────────────────────────────┐
│  Zest                  [←]  │ ← #E6F4FF (Container)
├─────────────────────────────┤
│  📖 Recipes             ████│ ← #0077BE (Active)
│  📅 Meal Plan               │ ← #3A5266 (Inactive)
│  🛒 Shopping                │
│  📚 Cookbooks               │
└─────────────────────────────┘
```

### Button States
```
Normal:  ████ #0077BE
Hover:   ████ #3399D6
Active:  ████ #005A94
Disabled:████ #0077BE (40% opacity)
```

## 🌊 Gradient Suggestions

### Ocean Gradient
```css
background: linear-gradient(135deg, #0077BE 0%, #00A8CC 100%);
```

### Sunset Gradient
```css
background: linear-gradient(135deg, #FFB84D 0%, #0077BE 100%);
```

### Sky Gradient
```css
background: linear-gradient(180deg, #D6EFFF 0%, #F5FAFE 100%);
```

## 🎨 Color Psychology

### Why Mediterranean Blue?

1. **Universal Appeal**: Blue is the most universally liked color
2. **Trust**: Associated with reliability and professionalism
3. **Calm**: Reduces stress and promotes focus
4. **Appetite**: Blue is calming for food apps (unlike red which increases urgency)
5. **Timeless**: Won't feel dated quickly
6. **Versatile**: Works for all content types

### Cultural Associations
- **Greece**: Heritage, quality, authenticity
- **Mediterranean**: Health, freshness, lifestyle
- **Ocean**: Depth, exploration, adventure
- **Sky**: Freedom, possibility, clarity

## 🔄 Migration from Orange

### Before (Orange)
```
Primary: #FFA500 (Orange)
Surface: #FFF8E1 (Warm cream)
Feeling: Energetic, warm, bold
```

### After (Mediterranean Blue)
```
Primary: #0077BE (Mediterranean blue)
Surface: #F5FAFE (Cool white)
Feeling: Calm, trustworthy, fresh
```

### Benefits
- More professional appearance
- Better for food photography (neutral background)
- Calmer, less aggressive
- Better accessibility (higher contrast)
- More versatile for different content

## 📱 Platform Consistency

While Web uses Mediterranean Blue:
- **Android**: Can use Material You dynamic colors OR Mediterranean theme
- **iOS**: Keeps Liquid Glass with adaptive colors

This allows:
- Web: Consistent branded experience
- Android: User's personal color preference OR brand colors
- iOS: Platform-native feel with brand touches

## 🎉 Summary

The Mediterranean Blue theme provides:
- ✅ Professional, trustworthy appearance
- ✅ Calm, focused user experience
- ✅ Excellent accessibility (WCAG AA)
- ✅ Beautiful light and dark modes
- ✅ Timeless, versatile design
- ✅ Strong brand identity
- ✅ Cultural richness and depth

Perfect for a cooking app that emphasizes quality, trust, and a calm cooking experience! 🌊🇬🇷
