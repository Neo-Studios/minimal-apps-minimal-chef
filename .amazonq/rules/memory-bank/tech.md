# Technology Stack

## Programming Languages

### Web Platform
- **TypeScript 5.4** - Primary language for type-safe development
- **JavaScript (ES2022+)** - Runtime execution
- **CSS/Tailwind** - Styling

### Android Platform
- **Kotlin 1.9.22** - Primary language for Android development
- **Java** - Interop and legacy support

### iOS Platform
- **Swift 5.9+** - Primary language for iOS development
- **Objective-C** - Firebase plugin compatibility

### Configuration
- **JSON** - Configuration files, design tokens
- **YAML** - CI/CD workflows
- **Gradle Kotlin DSL** - Android build scripts

## Frameworks and Libraries

### Web (Next.js)
**Core Framework:**
- Next.js 14.2.0 - React framework with App Router
- React 18.3.0 - UI library
- React DOM 18.3.0 - DOM rendering

**State Management:**
- Zustand 4.5.0 - Lightweight state management

**Backend Integration:**
- Firebase 10.12.0 - Authentication, Firestore, Storage

**Styling:**
- Tailwind CSS 3.4.0 - Utility-first CSS framework
- PostCSS 8.4.0 - CSS processing
- Autoprefixer 10.4.0 - CSS vendor prefixing

**Development Tools:**
- TypeScript 5.4.0 - Type checking
- ESLint 8.57.0 - Code linting
- eslint-config-next 14.2.0 - Next.js ESLint rules

### Android (Kotlin)
**Core Framework:**
- Jetpack Compose - Declarative UI framework
- Material 3 Expressive - Design system

**Build System:**
- Gradle 8.3.0 - Build automation
- Android Gradle Plugin 8.3.0
- Kotlin Gradle Plugin 1.9.22

**Dependency Injection:**
- Hilt 2.50 - Dependency injection framework

**Backend Integration:**
- Firebase Android SDK - Auth, Firestore, Storage
- Google Services Plugin 4.4.1

**AI Integration:**
- Google AICore SDK - Pixel devices
- Samsung Galaxy AI SDK - Samsung devices
- Qualcomm AI Engine SDK - Snapdragon devices
- OEM-specific AI SDKs (Xiaomi, OPPO, OnePlus, Huawei)

**Additional Libraries:**
- Kotlin Coroutines - Asynchronous programming
- Coil - Image loading
- Room - Local database (offline support)

### iOS (Swift)
**Core Framework:**
- SwiftUI - Declarative UI framework
- Liquid Glass Design Language - Custom design system

**Backend Integration:**
- Firebase iOS SDK - Auth, Firestore, Storage
- CocoaPods - Dependency management

**Apple Frameworks:**
- Combine - Reactive programming
- HealthKit - Nutrition tracking integration
- Apple Intelligence SDK - On-device AI (iPhone 15 Pro+, iPhone 16)

**Additional Libraries:**
- CoreData - Local persistence
- AVFoundation - Voice guidance
- UserNotifications - Timer notifications

## Backend Services (Firebase)

### Firebase Products
- **Authentication** - Google Sign-In, email/password
- **Cloud Firestore** - NoSQL database for recipes, users, meal plans
- **Cloud Storage** - Recipe images and media
- **Cloud Functions** - Serverless backend logic (if needed)
- **Firebase Hosting** - Web app deployment

### Firestore Collections
- `users` - User profiles and preferences
- `recipes` - Recipe documents
- `mealPlans` - Calendar-based meal planning
- `shoppingLists` - Shopping list items
- `cookbooks` - Recipe collections

## Build Systems and Tools

### Web Build
```bash
npm run dev      # Development server (port 3000)
npm run build    # Production build
npm run start    # Production server
npm run lint     # ESLint checking
```

**Build Output:**
- `.next/` - Next.js build artifacts
- Static optimization for PWA
- Server-side rendering support

### Android Build
```bash
./gradlew build           # Full build
./gradlew assembleDebug   # Debug APK
./gradlew assembleRelease # Release APK
./gradlew test            # Run tests
```

**Build Configuration:**
- Kotlin DSL build scripts
- ProGuard for code obfuscation
- Multi-module architecture support

### iOS Build
```bash
pod install              # Install dependencies
xcodebuild              # Command-line build
# Or use Xcode IDE
```

**Build Configuration:**
- Xcode 15+ required
- Swift Package Manager + CocoaPods
- Code signing for distribution

## Development Environment

### IDX (Firebase Studio)
- **Environment:** `.idx/dev.nix` - Nix configuration for dependencies
- **AI Rules:** `.idx/airules.md` - AI assistant guidelines
- **Hot Reload:** Supported across all platforms

### Version Control
- **Git** - Source control
- **GitHub** - Repository hosting
- **GitHub Actions** - CI/CD pipelines

### CI/CD Workflows
- `android-build.yml` - Android build and test
- `ios-build.yml` - iOS build and test
- `web-deploy.yml` - Web deployment to Firebase Hosting
- `test.yml` - Cross-platform testing

## Package Management

### Web
- **npm** - Node package manager
- `package.json` - Dependency manifest
- `package-lock.json` - Locked versions

### Android
- **Gradle** - Build tool and dependency management
- `build.gradle.kts` - Build configuration
- `gradle.properties` - Gradle settings

### iOS
- **CocoaPods** - Dependency manager
- `Podfile` - Dependency manifest
- `Podfile.lock` - Locked versions

## Development Commands

### Web Development
```bash
cd web
npm install              # Install dependencies
npm run dev              # Start dev server
npm run build            # Build for production
npm run lint             # Lint code
```

### Android Development
```bash
cd android
./gradlew clean          # Clean build
./gradlew assembleDebug  # Build debug APK
./gradlew installDebug   # Install on device
./gradlew test           # Run unit tests
```

### iOS Development
```bash
cd ios
pod install              # Install pods
open MinimalChef.xcworkspace  # Open in Xcode
# Build and run from Xcode
```

## Testing Frameworks

### Web
- **Vitest** - Unit testing framework
- **React Testing Library** - Component testing
- Configuration: `vitest.config.ts`

### Android
- **JUnit** - Unit testing
- **Espresso** - UI testing
- **Mockito** - Mocking framework

### iOS
- **XCTest** - Unit and UI testing
- Example: `MinimalChefTests/ShoppingListGeneratorTests.swift`

## Design System

### Design Tokens
- **Location:** `shared/design-tokens/tokens.json`
- **Format:** JSON with colors, typography, spacing
- **Usage:** Imported by each platform

### Typography
- **Font:** RobotoFlex Variable Font
- **Location:** `shared/fonts/RobotoFlex-Variable.ttf`
- **Accessibility:** OpenDyslexic font option

### Platform-Specific Design
- **Android:** Material 3 Expressive with dynamic colors
- **iOS:** Liquid Glass design language
- **Web:** Tailwind CSS with custom theme

## Internationalization

### Localization Files
- **Location:** `shared/locales/`
- **Format:** `.lang` files
- **Languages:** 21 supported languages
- **Structure:** Key-value pairs for translations

### Supported Locales
en_us, en_uk, en_au, fr_fr, es_es, it_it, de_de, nl_nl, sv_se, pt_br, jp_jp, zh_cn, ko_kr, ru_ru, pl_pl, tr_tr, ar_sa, hi_in, vi_vn, th_th, id_id

## Security and Configuration

### Environment Variables
- `.env` - Root environment configuration
- `web/.env.example` - Web environment template
- Firebase configuration per platform

### Security Rules
- `firestore.rules` - Firestore security rules
- `firebase.json` - Firebase project configuration

### Code Protection
- **Android:** ProGuard rules in `proguard-rules.pro`
- **iOS:** Code signing and entitlements
- **Web:** Environment variable protection

## Performance Optimization

### Web
- Next.js static optimization
- Image optimization
- Code splitting
- PWA caching strategies

### Android
- Jetpack Compose performance
- ProGuard code shrinking
- APK size optimization

### iOS
- SwiftUI performance
- Asset catalog optimization
- App thinning

## Minimum Requirements

### Web
- Node.js 20+
- npm 9+
- Modern browser (Chrome 90+, Safari 14+, Firefox 88+)

### Android
- Android Studio Hedgehog+
- JDK 17
- Gradle 8.3+
- Minimum SDK varies by device

### iOS
- macOS 13+
- Xcode 15+
- CocoaPods 1.12+
- iOS 15+ target
