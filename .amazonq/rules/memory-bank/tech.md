# Technology Stack - Minimal Chef

## Programming Languages

### Primary
- **Dart** (^3.9.0): Main application language for Flutter
- **Kotlin**: Android MainActivity implementation
- **Swift**: iOS AppDelegate implementation

### Supporting
- **Java**: Android plugin registration
- **JavaScript**: Web recipe import utilities
- **Python**: iOS Flutter LLDB helper scripts
- **C++**: Native platform integrations

## Framework & SDK

### Flutter
- **Version**: 3.9.0+
- **Material Design**: Material 3 (useMaterial3: true)
- **Platforms**: Android, iOS, Web, Windows, Linux, macOS

### Android
- **Minimum SDK**: 31 (Android 12)
- **Target SDK**: 36 (Android 15)
- **Build System**: Gradle with Kotlin DSL (build.gradle.kts)
- **Namespace**: com.neo_studios.minimal_chef

### iOS
- **Minimum Version**: iOS 12.0+
- **Build System**: Xcode with CocoaPods
- **Bundle ID**: com.neoStudios.minimalChef

## Core Dependencies

### Firebase Services
```yaml
firebase_core: ^4.2.1          # Firebase initialization
firebase_auth: ^6.1.2          # Authentication
cloud_firestore: ^6.1.0        # Cloud database
firebase_storage: ^13.0.4      # File storage
```

### Authentication
```yaml
google_sign_in: ^7.2.0         # Google Sign-In (mobile)
google_sign_in_web: ^1.1.0     # Google Sign-In (web)
```

### UI & Design
```yaml
cupertino_icons: ^1.0.8        # iOS-style icons
table_calendar: ^3.0.9         # Calendar widget
morphable_shape: ^2.0.0        # Custom shape animations
font_awesome_flutter: ^10.7.0  # Icon library
```

### Data & Storage
```yaml
sqflite: ^2.3.0                # Local SQLite database
path: ^1.8.3                   # File path utilities
```

### Media & Web
```yaml
image_picker: ^1.0.4           # Camera/gallery access
html: ^0.15.4                  # HTML parsing for recipe import
http: ^1.5.0                   # HTTP requests
web: ^1.0.0                    # Web platform APIs
```

### Utilities
```yaml
package_info_plus: ^9.0.0      # App version info
flutter_dotenv: ^6.0.0         # Environment variables
args: ^2.4.2                   # Command-line arguments
crypto: ^3.0.3                 # Cryptographic functions
```

## Development Tools

### Testing
```yaml
flutter_test: sdk: flutter     # Flutter testing framework
flutter_lints: ^6.0.0          # Dart linting rules
```

### Build Tools
- **Gradle**: 8.x with Kotlin DSL
- **CocoaPods**: iOS dependency management
- **Flutter CLI**: Build and deployment

## Custom Assets

### Fonts
- **RobotoFlex-Variable.ttf**: Variable font with custom typography scale
  - Display: 57px, 45px, 36px
  - Headline: 32px, 28px, 24px
  - Title: 22px, 16px, 14px
  - Body: 16px, 14px, 12px
  - Label: 14px, 12px, 11px

### Environment
- **.env**: Environment variables (API keys, configuration)

## Development Commands

### Setup
```bash
flutter pub get                 # Install dependencies
flutter pub upgrade             # Update dependencies
```

### Run
```bash
flutter run                     # Run on connected device
flutter run -d chrome           # Run on web
flutter run -d android          # Run on Android
flutter run -d ios              # Run on iOS
```

### Build
```bash
flutter build apk               # Android APK
flutter build appbundle         # Android App Bundle
flutter build ios               # iOS build
flutter build web               # Web build
flutter build macos             # macOS build
flutter build windows           # Windows build
flutter build linux             # Linux build
```

### Test
```bash
flutter test                    # Run all tests
flutter test test/models/       # Run model tests
flutter analyze                 # Static analysis
```

### Clean
```bash
flutter clean                   # Clean build artifacts
flutter pub cache repair        # Repair pub cache
```

## CI/CD

### GitHub Actions
- **android-build.yml**: Automated Android builds
- **ios-build.yml**: iOS builds without Mac (cloud-based)

### Codemagic
- **codemagic.yaml**: Alternative CI/CD configuration
- 500 free build minutes per month

## Firebase Configuration

### Required Files
- **android/app/google-services.json**: Android Firebase config
- **ios/Runner/GoogleService-Info.plist**: iOS Firebase config
- **lib/firebase_options.dart**: Flutter Firebase options
- **firebase.json**: Firebase project configuration
- **firestore.rules**: Firestore security rules

### Services Used
- **Authentication**: Google Sign-In provider
- **Firestore**: Real-time database for recipes, meal plans, shopping lists
- **Storage**: Recipe image uploads and storage

## Platform-Specific Features

### Android
- Edge-to-edge display with transparent system bars
- Material 3 dynamic color support
- ProGuard rules for release builds

### iOS
- SwiftUI integration ready
- App Transport Security configured
- Universal links support

### Web
- Progressive Web App (PWA) support
- Service worker for offline capabilities
- Web-specific recipe import via JavaScript

## Environment Setup

### IDX (Project IDX)
- **dev.nix**: Nix configuration for development environment
- Firebase Studio integration
- Cloud-based development environment

### Local Development
- Flutter SDK 3.9.0+
- Android Studio / Xcode / VS Code
- Firebase CLI for deployment
