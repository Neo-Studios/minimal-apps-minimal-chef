# Icon Migration Guide

## Web Platform ✅ COMPLETED

All emojis have been replaced with FontAwesome icons using a centralized Icon component.

### Icon Component
- Location: `web/src/components/ui/Icon.tsx`
- Library: `@fortawesome/react-fontawesome` with `@fortawesome/free-solid-svg-icons`
- Usage: `<Icon name="book" size="lg" className="..." />`

### Icon Mappings
- 📖 → `book` (faBook)
- 📅 → `calendar` (faCalendar)
- 🛒 → `cart` (faCartShopping)
- 📚 → `cookbook` (faBookBookmark)
- 📊 → `chart` (faChartLine)
- ⏱️ → `clock` (faClock)
- 🤖 → `robot` (faRobot)
- ⚙️ → `settings` (faGear)
- 🔥 → `fire` (faFire)
- 🥩 → `meat` (faDrumstickBite)
- 🍞 → `bread` (faBreadSlice)
- 🥑 → `vegetable` (faSeedling)
- 🍽️ → `utensils` (faUtensils)
- 🗑️ → `trash` (faTrash)
- 📁 → `folder` (faFolder)
- 📋 → `clipboard` (faClipboard)
- ℹ️ → `info` (faCircleInfo)
- ✅ → `success` (faCircleCheck)
- ⚠️ → `warning` (faTriangleExclamation)
- ❌ → `error` (faCircleXmark)
- 📱 → `mobile` (faMobileScreen)

### Files Updated
- ✅ `web/src/components/layout/TabletLayout.tsx`
- ✅ `web/src/components/layout/MobileLayout.tsx`
- ✅ `web/src/components/ui/Toast.tsx`
- ✅ `web/src/app/shopping/page.tsx`
- ✅ `web/src/app/timers/page.tsx`
- ✅ `web/src/app/nutrition/page.tsx`
- ✅ `web/src/app/recipes/page.tsx`
- ✅ `web/src/app/recipes/[id]/page.tsx`
- ✅ `web/src/app/ai-recipe-generator/page.tsx`
- ✅ `web/src/components/features/RecipeCard.tsx`

## Android Platform - TODO

Android uses Material Icons which are already available in Jetpack Compose.

### Recommended Approach
Use `androidx.compose.material.icons.Icons` with Material Icons Extended.

### Dependencies to Add
```kotlin
// In android/app/build.gradle.kts
implementation("androidx.compose.material:material-icons-extended:1.6.0")
```

### Icon Mappings for Android
```kotlin
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*

// Navigation
Icons.Filled.MenuBook        // 📖 Recipes
Icons.Filled.CalendarToday   // 📅 Meal Plan
Icons.Filled.ShoppingCart    // 🛒 Shopping
Icons.Filled.Book            // 📚 Cookbooks
Icons.Filled.BarChart        // 📊 Nutrition
Icons.Filled.Timer           // ⏱️ Timers
Icons.Filled.SmartToy        // 🤖 AI Assistant
Icons.Filled.Settings        // ⚙️ Settings

// Food & Actions
Icons.Filled.Whatshot        // 🔥 Fire/Calories
Icons.Filled.Restaurant      // 🍽️ Utensils
Icons.Filled.Delete          // 🗑️ Trash
Icons.Filled.Folder          // 📁 Folder
Icons.Filled.Assignment      // 📋 Clipboard
```

### Files to Update
- `android/app/src/main/java/.../ui/navigation/` - Bottom navigation
- `android/app/src/main/java/.../ui/screens/` - Screen icons
- `android/app/src/main/java/.../ui/components/` - Component icons

## iOS Platform - TODO

iOS uses SF Symbols which are built into the system.

### Recommended Approach
Use SwiftUI's `Image(systemName:)` with SF Symbols.

### Icon Mappings for iOS
```swift
// Navigation
Image(systemName: "book.fill")           // 📖 Recipes
Image(systemName: "calendar")            // 📅 Meal Plan
Image(systemName: "cart.fill")           // 🛒 Shopping
Image(systemName: "books.vertical.fill") // 📚 Cookbooks
Image(systemName: "chart.bar.fill")      // 📊 Nutrition
Image(systemName: "timer")               // ⏱️ Timers
Image(systemName: "brain.head.profile")  // 🤖 AI Assistant
Image(systemName: "gearshape.fill")      // ⚙️ Settings

// Food & Actions
Image(systemName: "flame.fill")          // 🔥 Fire/Calories
Image(systemName: "fork.knife")          // 🍽️ Utensils
Image(systemName: "trash.fill")          // 🗑️ Trash
Image(systemName: "folder.fill")         // 📁 Folder
Image(systemName: "doc.on.clipboard")    // 📋 Clipboard
```

### Files to Update
- `ios/Zest/Views/Navigation/` - Tab bar and navigation
- `ios/Zest/Views/Screens/` - Screen icons
- `ios/Zest/Views/Components/` - Component icons

## Benefits of Icon Migration

1. **Consistency**: Professional icon set across all platforms
2. **Accessibility**: Better screen reader support
3. **Customization**: Easy to change colors, sizes, and styles
4. **Performance**: Vector icons scale perfectly at any size
5. **Maintainability**: Centralized icon management
6. **Cross-platform**: Native icon systems for each platform

## Next Steps

1. ✅ Web platform completed
2. ⏳ Update Android to use Material Icons
3. ⏳ Update iOS to use SF Symbols
4. ⏳ Test all platforms for visual consistency
5. ⏳ Update design documentation
