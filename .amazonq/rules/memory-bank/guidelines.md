# Development Guidelines

## Code Quality Standards

### Kotlin (Android)

**Package Structure:**

- Use reverse domain notation: `com.neostudios.zest.{module}`
- Organize by feature/layer: `ai/`, `data/`, `ui/`, `services/`

**Naming Conventions:**

- Classes: PascalCase (e.g., `AIManager`, `NotificationHelper`)
- Functions: camelCase (e.g., `isAIAvailable()`, `sendTimerComplete()`)
- Constants: SCREAMING_SNAKE_CASE (e.g., `CHANNEL_ID`, `CHANNEL_NAME`)
- Private properties: camelCase with `private` modifier
- Enums: PascalCase for enum class, SCREAMING_SNAKE_CASE for values

**Code Formatting:**

- 4-space indentation
- Opening braces on same line
- Explicit return types for public functions
- Use `private` modifier for internal implementation details
- Lazy initialization with `by lazy` for expensive operations

**Kotlin Idioms:**

- Use `when` expressions for multi-branch logic
- Prefer `object` for singletons (e.g., `object NotificationHelper`)
- Use data classes for models
- Leverage extension functions for utility methods
- Use `?.` safe calls and `?:` Elvis operator for null safety
- Prefer `apply`, `let`, `also`, `run` scope functions appropriately

**Coroutines:**

- Use `suspend` functions for async operations
- Wrap blocking operations with `withContext(Dispatchers.Default)` or `Dispatchers.IO`
- Return nullable types for operations that may fail
- Use try-catch blocks within suspend functions, return null on failure

**Error Handling:**

- Use try-catch blocks for operations that may throw exceptions
- Return null or default values on failure rather than throwing
- Log errors for debugging but don't expose to users
- Provide fallback mechanisms (e.g., `getFallbackRecipe()`)

### Swift (iOS)

**Naming Conventions:**

- Structs/Classes: PascalCase (e.g., `SettingsView`, `HealthKitService`)
- Properties: camelCase (e.g., `themeMode`, `notifications`)
- Functions: camelCase (e.g., `requestAuthorization()`, `syncNutrition()`)
- Constants: camelCase for local, PascalCase for static

**Code Formatting:**

- 4-space indentation
- Opening braces on same line
- Explicit type annotations for public APIs
- Use `private` for internal implementation

**SwiftUI Patterns:**

- Use `@State` for local view state
- Use `@Binding` for two-way data flow between parent-child views
- Use `@EnvironmentObject` for shared app-wide state
- Prefer `struct` for views (value types)
- Use `NavigationLink` for navigation
- Use `List` with sections for grouped content

**Swift Idioms:**

- Use `guard` for early returns and unwrapping optionals
- Prefer `if let` or `guard let` for optional unwrapping
- Use trailing closures for completion handlers
- Leverage computed properties for derived state
- Use `static let shared` for singleton pattern

**Error Handling:**

- Use completion handlers with Bool/Result for async operations
- Check availability with `guard` statements
- Provide default values or early returns on failure
- Log errors with `print()` for debugging

**Apple Framework Integration:**

- Check availability before using framework features (e.g., `HKHealthStore.isHealthDataAvailable()`)
- Request permissions before accessing sensitive APIs
- Use framework-specific types (e.g., `HKQuantityType`, `HKQuantitySample`)

### TypeScript (Web)

**Type Definitions:**

- Use `interface` for object shapes and data models
- Use `type` for unions, intersections, and aliases
- Export all public interfaces
- Use optional properties with `?` (e.g., `id?: string`)
- Use union types for enums (e.g., `'easy' | 'medium' | 'hard'`)

**Naming Conventions:**

- Interfaces: PascalCase (e.g., `Recipe`, `NutritionInfo`)
- Types: PascalCase (e.g., `DietaryRestriction`)
- Properties: camelCase (e.g., `prepTime`, `cookTime`)
- Use descriptive names that reflect domain concepts

**Code Formatting:**

- 2-space indentation
- Semicolons optional but consistent
- Use single quotes for strings
- Trailing commas in multi-line objects/arrays

**Type Safety:**

- Avoid `any` type - use specific types or `unknown`
- Use strict null checks
- Leverage TypeScript's type inference
- Define explicit return types for functions

## Architectural Patterns

### Separation of Concerns

**Android (Kotlin):**

- **Manager Classes:** Handle complex business logic (e.g., `AIManager`)
- **Helper Objects:** Provide utility functions (e.g., `NotificationHelper`)
- **Data Layer:** Separate from UI and business logic
- **Dependency Injection:** Use Hilt for managing dependencies

**iOS (Swift):**

- **Service Classes:** Singleton pattern for shared services (e.g., `HealthKitService.shared`)
- **Views:** Pure SwiftUI views with minimal logic
- **ViewModels:** Handle business logic and state management
- **Models:** Data structures separate from views

**Web (TypeScript):**

- **Type Definitions:** Centralized in `types/` directory
- **Models:** Pure data interfaces without logic
- **Separation:** Types separate from implementation

### State Management

**Android:**

- Use StateFlow/LiveData for reactive state
- Hilt ViewModels for UI state
- Local state in Composables when appropriate

**iOS:**

- `@State` for local view state
- `@EnvironmentObject` for app-wide state (e.g., `AuthService`)
- `@Binding` for parent-child communication
- Combine framework for reactive programming

**Web:**

- Zustand for global state management
- React hooks for local component state
- Context API for shared state

### Async Operations

**Android:**

- Kotlin Coroutines with `suspend` functions
- `withContext()` for dispatcher switching
- Return nullable types for failable operations

**iOS:**

- Completion handlers with `@escaping` closures
- Async/await for modern Swift code
- HealthKit async operations with callbacks

**Web:**

- Promises and async/await
- React hooks for side effects (useEffect)
- Firebase SDK async methods

## Platform-Specific Patterns

### Android Device Detection

**Pattern:** Comprehensive device capability detection

- Check manufacturer with `Build.MANUFACTURER.lowercase()`
- Check model with `Build.MODEL.lowercase()`
- Check Android version with `Build.VERSION.SDK_INT`
- Use specific model codes for device identification
- Provide fallback for unsupported devices

**Example:**

```kotlin
private fun isSamsungGalaxyAIDevice(): Boolean {
    val manufacturer = Build.MANUFACTURER.lowercase()
    val model = Build.MODEL.lowercase()
    
    if (manufacturer != "samsung") return false
    
    // Check for specific models
    if (model.contains("sm-s92")) return true
    
    return false
}
```

### Android Notifications

**Pattern:** Channel-based notification system

- Create notification channel for Android O+
- Use object singleton for notification helpers
- Use descriptive channel names and IDs
- Set appropriate priority levels
- Use `hashCode()` for unique notification IDs

**Example:**

```kotlin
object NotificationHelper {
    private const val CHANNEL_ID = "zest_notifications"
    
    fun createNotificationChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(...)
            // Configure channel
        }
    }
}
```

### iOS HealthKit Integration

**Pattern:** Permission-based health data access

- Check availability with `HKHealthStore.isHealthDataAvailable()`
- Request authorization before accessing data
- Define specific data types to read/write
- Use completion handlers for async operations
- Create samples with proper units and timestamps

**Example:**

```swift
func requestAuthorization(completion: @escaping (Bool) -> Void) {
    guard HKHealthStore.isHealthDataAvailable() else {
        completion(false)
        return
    }
    
    let typesToWrite: Set<HKSampleType> = [...]
    healthStore.requestAuthorization(toShare: typesToWrite, read: nil) { success, error in
        completion(success)
    }
}
```

### SwiftUI Liquid Glass Design

**Pattern:** Custom design system with modifiers

- Use `.liquidGlass()` modifier for consistent styling
- Apply to sections and list items
- Use `NavigationView` and `NavigationLink` for navigation
- Hide scroll content background with `.scrollContentBackground(.hidden)`
- Use system grouped background colors

**Example:**

```swift
Section("General") {
    // Content
}
.liquidGlass()
```

### TypeScript Data Modeling

**Pattern:** Comprehensive interface definitions

- Optional properties for nullable fields
- Union types for constrained values
- Nested interfaces for complex structures
- Consistent naming across related types
- Date types for timestamps

**Example:**

```typescript
export interface Recipe {
  id?: string
  name: string
  difficulty?: 'easy' | 'medium' | 'hard'
  ingredients: Ingredient[]
  createdAt?: Date
}
```

## AI Integration Patterns

### Multi-Provider Support

**Pattern:** Provider detection and fallback

- Detect device capabilities at initialization
- Use lazy initialization for provider detection
- Provide fallback responses when SDK unavailable
- Include provider name in generated content
- Handle errors gracefully with try-catch

**Example:**

```kotlin
private val aiProvider: AIProvider by lazy {
    when {
        isPixelDevice() && Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE -> AIProvider.GOOGLE_AICORE
        isSamsungGalaxyAIDevice() -> AIProvider.SAMSUNG_GALAXY_AI
        // ... other providers
        else -> AIProvider.NONE
    }
}
```

### Prompt Engineering

**Pattern:** Structured prompts with clear instructions

- Use multi-line strings with `""" """`
- Include specific requirements in prompt
- Request structured output format
- Keep prompts concise and focused

**Example:**

```kotlin
private fun buildPrompt(ingredients: List<String>): String {
    return """Create a recipe using: ${ingredients.joinToString(", ")}.
Provide: name, ingredients with measurements, instructions, time, servings, difficulty."""
}
```

### Fallback Mechanisms

**Pattern:** Intelligent defaults when AI unavailable

- Provide template-based responses
- Include provider attribution
- Use input data to personalize fallback
- Maintain consistent output format

## Accessibility Patterns

### iOS Accessibility

**Pattern:** Comprehensive accessibility options

- Provide multiple font size options
- Support reduced motion and transparency
- Offer high contrast mode
- Include color blind mode options (Protanopia, Deuteranopia, Tritanopia)
- VoiceOver optimization toggle
- Use system accessibility APIs

### Settings Organization

**Pattern:** Grouped settings with clear labels

- Use `Section()` to group related settings
- Use `Label()` with SF Symbols for visual clarity
- Use `Toggle()` for boolean settings
- Use `NavigationLink` for sub-menus
- Show current value in secondary text

## Error Handling Philosophy

### Graceful Degradation

**Pattern:** Never crash, always provide fallback

- Return null for failed operations
- Provide default/fallback values
- Log errors for debugging
- Continue execution when possible
- Inform user only when necessary

### Null Safety

**Kotlin:**

- Use nullable types (`String?`) for failable operations
- Use safe calls (`?.`) and Elvis operator (`?:`)
- Return null instead of throwing exceptions

**Swift:**

- Use optionals for values that may be absent
- Use `guard` for early returns
- Provide completion handlers with success/failure

**TypeScript:**

- Use optional properties (`?`)
- Check for undefined/null before use
- Provide default values with `??`

## Testing Patterns

### Unit Testing

**iOS Example:**

- Use XCTest framework
- Test file naming: `{Feature}Tests.swift`
- Test business logic and data transformations
- Mock external dependencies

## Documentation Standards

### Code Comments

**When to Comment:**

- Complex algorithms or business logic
- Device-specific workarounds
- API limitations or quirks
- Non-obvious design decisions

**When NOT to Comment:**

- Self-explanatory code
- Obvious functionality
- Redundant descriptions

### Inline Documentation

**Pattern:** Brief, informative comments

- Explain "why" not "what"
- Document device model codes
- Note version requirements
- Explain fallback strategies

**Example:**

```kotlin
// Samsung Galaxy AI is available on:
// - Galaxy S24 series (SM-S92x)
// - Galaxy S23 series with One UI 6.1+ (SM-S91x)
```

## Version and Compatibility

### Version Checking

**Android:**

- Use `Build.VERSION.SDK_INT` for API level checks
- Use named constants (e.g., `Build.VERSION_CODES.UPSIDE_DOWN_CAKE`)
- Check both OS version and device model for features

**iOS:**

- Use `@available` for API availability
- Check framework availability before use
- Provide fallbacks for older versions

### Backward Compatibility

**Pattern:** Progressive enhancement

- Detect feature availability at runtime
- Provide fallback for unsupported devices
- Don't assume latest OS/SDK
- Test on minimum supported versions

## Firebase Integration

### Authentication

**Pattern:** Service-based auth management

- Centralize auth logic in service classes
- Use environment objects (iOS) or dependency injection (Android)
- Handle sign-in/sign-out lifecycle
- Store user state reactively

### Data Modeling

**Pattern:** Consistent field naming

- Use camelCase for Firestore fields
- Include userId for user-scoped data
- Add timestamps (createdAt, updatedAt)
- Use optional fields for nullable data

## Performance Optimization

### Lazy Initialization

**Pattern:** Defer expensive operations

- Use `by lazy` (Kotlin) for one-time initialization
- Use `static let shared` (Swift) for singletons
- Initialize on first use, not at startup

### Resource Management

**Pattern:** Efficient resource usage

- Clear caches when appropriate
- Release resources in lifecycle methods
- Use appropriate dispatchers for background work
- Optimize image loading and caching

## Localization

### String Management

**Pattern:** Centralized translation files

- Store translations in `shared/locales/`
- Use `.lang` file format
- Support 21 languages
- Use key-value pairs for lookups

### Language Support

**Supported Languages:**
English (US, UK, AU), French, Spanish, Italian, German, Dutch, Swedish, Portuguese, Japanese, Chinese, Korean, Russian, Polish, Turkish, Arabic, Hindi, Vietnamese, Thai, Indonesian

## Security Best Practices

### API Keys

**Pattern:** Never hardcode credentials

- Use empty strings for API keys in code
- Load from environment variables
- Use platform-specific secure storage
- Never commit credentials to version control

### User Data

**Pattern:** Privacy-first approach

- Request permissions before accessing data
- Use on-device AI when possible
- Encrypt sensitive data
- Follow platform privacy guidelines

## Build and Deployment

### Configuration Management

**Android:**

- Use `build.gradle.kts` for dependencies
- Use ProGuard for release builds
- Configure signing in Gradle

**iOS:**

- Use CocoaPods for dependencies
- Configure in Xcode project settings
- Use proper code signing

**Web:**

- Use `package.json` for dependencies
- Configure in `next.config.js`
- Use environment variables for secrets

### Version Management

**Pattern:** Semantic versioning

- Current version: 2.0.0
- Update across all platforms simultaneously
- Document changes in version history
- Use consistent version strings

## Code Review Checklist

- [ ] Follows naming conventions for platform
- [ ] Proper error handling with fallbacks
- [ ] Null safety patterns applied
- [ ] Accessibility considerations included
- [ ] No hardcoded credentials
- [ ] Appropriate use of async patterns
- [ ] Platform-specific APIs used correctly
- [ ] Consistent with existing codebase style
- [ ] Comments explain "why" not "what"
- [ ] Tests included for business logic
