# Project Structure

## Directory Organization

### `/lib` - Main Application Code
- **`/models`** - Data models (Recipe, Ingredient, MealPlan)
- **`/screens`** - UI screens for different app sections
  - Authentication: auth_gate.dart, login_screen.dart, sign_in_screen.dart
  - Core features: recipes_screen.dart, discover_screen.dart, meal_plan_screen.dart, shopping_list_screen.dart
  - Detail views: recipe_detail_screen.dart
  - Forms: add_recipe_screen.dart, add_shopping_list_item_screen.dart, import_recipe_screen.dart
  - Settings: settings_screen.dart, home_screen.dart
- **`/services`** - Business logic and external integrations
  - auth_service.dart - Firebase authentication
  - firestore_service.dart - Cloud Firestore database operations
  - recipe_service.dart - Recipe management
  - meal_plan_service.dart - Meal planning logic
  - storage_service.dart - Firebase Storage for images
  - recipe_api_service.dart - External recipe API integration
  - search_service.dart - Recipe search functionality
- **`/widgets`** - Reusable UI components
  - instruction_step.dart - Recipe instruction display
  - morphing_container.dart - Animated container transitions
  - springy_button.dart - Interactive button with spring animation
  - variable_font_text.dart - Custom typography with RobotoFlex
- **`/data`** - Static data and constants
- **`/providers`** - State management (if using Provider pattern)
- **`main.dart`** - Application entry point with theme configuration
- **`firebase_options.dart`** - Firebase configuration

### `/assets` - Static Resources
- **`/fonts`** - RobotoFlex-Variable.ttf for custom typography

### Platform-Specific Code
- **`/android`** - Android build configuration (Gradle, Kotlin)
- **`/ios`** - iOS build configuration (Swift, Xcode)
- **`/web`** - Web deployment assets
- **`/windows`** - Windows desktop configuration (C++, CMake)
- **`/linux`** - Linux desktop configuration (C++, CMake)
- **`/macos`** - macOS desktop configuration (Swift, Xcode)

### Configuration Files
- **`pubspec.yaml`** - Flutter dependencies and assets
- **`firebase.json`** - Firebase project configuration
- **`firestore.rules`** - Firestore security rules
- **`analysis_options.yaml`** - Dart linting rules

## Architectural Patterns

### Service-Oriented Architecture
The app separates concerns into distinct service layers:
- Authentication services handle user login/logout
- Firestore services manage database operations
- Storage services handle image uploads
- Recipe services encapsulate recipe-related business logic

### Screen-Based Navigation
Each major feature has dedicated screens with clear separation of concerns.

### Widget Composition
Custom reusable widgets promote code reuse and consistent UI patterns.

### Firebase Backend
- Firebase Auth for user authentication (Google Sign-In)
- Cloud Firestore for data persistence
- Firebase Storage for recipe images
- Cross-platform Firebase integration
