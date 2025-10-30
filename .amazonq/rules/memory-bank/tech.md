# Technology Stack

## Core Framework
- **Flutter SDK**: ^3.9.0
- **Dart**: Language for Flutter development
- **Material 3**: Modern Material Design implementation

## Firebase Services
- **firebase_core**: ^4.2.0 - Firebase initialization
- **firebase_auth**: ^6.1.1 - User authentication
- **cloud_firestore**: ^6.0.3 - NoSQL cloud database
- **firebase_storage**: ^13.0.3 - Cloud file storage

## Authentication
- **google_sign_in**: ^7.2.0 - Google OAuth integration

## UI Components
- **cupertino_icons**: ^1.0.8 - iOS-style icons
- **table_calendar**: ^3.0.9 - Calendar widget for meal planning
- **morphable_shape**: ^2.0.0 - Custom shape animations
- **image_picker**: ^1.0.4 - Camera and gallery access

## Data Processing
- **html**: ^0.15.4 - HTML parsing for recipe scraping
- **http**: ^1.5.0 - HTTP client for API requests

## Development Tools
- **flutter_test**: SDK - Testing framework
- **flutter_lints**: ^6.0.0 - Recommended linting rules

## Build Systems

### Android
- Gradle 8.12
- Kotlin DSL for build scripts
- Target SDK configuration in build.gradle.kts

### iOS/macOS
- Xcode project configuration
- Swift for platform-specific code
- CocoaPods for dependency management

### Windows/Linux
- CMake build system
- C++ for platform integration
- Native window management

### Web
- Standard Flutter web compilation
- PWA manifest support

## Development Commands
```bash
# Install dependencies
flutter pub get

# Run on connected device
flutter run

# Build for production
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
flutter build windows      # Windows
flutter build linux        # Linux
flutter build macos        # macOS

# Run tests
flutter test

# Analyze code
flutter analyze
```

## Custom Assets
- **RobotoFlex Variable Font**: Custom typography for Material 3 text theme
- Configured for all text styles (display, headline, title, body, label)
