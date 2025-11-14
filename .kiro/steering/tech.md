# Tech Stack

## Web Platform
- **Framework**: Next.js 14.2 with React 18.3
- **Language**: TypeScript 5.4
- **Styling**: Tailwind CSS 3.4
- **State Management**: Zustand 4.5
- **Backend**: Firebase 10.12 (Auth, Firestore, Storage)
- **Testing**: Vitest 4.0, React Testing Library 16.3
- **Architecture**: Server Components + Client Components, Next.js App Router
- **Path Aliases**: `@/*` maps to `./src/*`

## Android Platform
- **Language**: Kotlin 1.9.22
- **UI Framework**: Jetpack Compose with Material 3 Expressive
- **Architecture**: MVVM + Clean Architecture
- **Dependency Injection**: Hilt 2.50
- **Build System**: Gradle 8.3, Android Gradle Plugin 8.3.0
- **Firebase**: Google Services 4.4.4
- **State**: ViewModel + StateFlow
- **Image Loading**: Coil

## iOS Platform
- **Language**: Swift
- **UI Framework**: SwiftUI with Liquid Glass design
- **Architecture**: MVVM
- **State**: ObservableObject + Combine
- **Dependency Management**: CocoaPods
- **Requirements**: Xcode 15+, macOS
- **Integration**: HealthKit, Firebase SDK

## Shared Resources
- **Design Tokens**: Centralized in `shared/design-tokens/`
- **Locales**: 21 language files in `shared/locales/`
- **Firebase Config**: Documentation in `shared/firebase-config/`
- **Fonts**: Shared font assets in `shared/fonts/`
- **Icons**: Shared icon assets in `shared/icons/`

## Common Commands

### Web
```bash
cd web
npm install          # Install dependencies
npm run dev          # Start development server
npm run build        # Production build
npm start            # Start production server
npm run lint         # Run ESLint
npm test             # Run tests with Vitest
```

### Android
```bash
cd android
./gradlew assembleDebug    # Build debug APK
./gradlew assembleRelease  # Build release APK
./gradlew test             # Run unit tests
./gradlew clean            # Clean build artifacts
```

### iOS
```bash
cd ios
pod install                # Install CocoaPods dependencies
# Then open MinimalChef.xcworkspace in Xcode
# Build: Cmd+B
# Run: Cmd+R
# Test: Cmd+U
```

## Configuration Files

### Web
- `next.config.js`: Next.js configuration with image optimization, SWC minification
- `tsconfig.json`: TypeScript strict mode, ES2020 target
- `tailwind.config.ts`: Custom colors (primary: #FFA500, secondary: #00B4D8), RobotoFlex font
- `.env.local`: Firebase credentials (not in repo, see `.env.example`)

### Android
- `build.gradle.kts`: Root build configuration
- `app/build.gradle.kts`: App-level build configuration
- `google-services.json`: Firebase config (not in repo, download from Firebase Console)

### iOS
- `Podfile`: CocoaPods dependencies
- `GoogleService-Info.plist`: Firebase config (not in repo, download from Firebase Console)

## Prerequisites
- **Web**: Node.js 20+
- **Android**: JDK 17, Android SDK
- **iOS**: macOS, Xcode 15+
- **All**: Firebase project with Auth, Firestore, and Storage enabled
