# Project Structure

## Repository Organization

```dir
zest/
├── web/                    # Next.js web application
├── android/                # Kotlin Android application
├── ios/                    # Swift iOS application
├── shared/                 # Cross-platform shared resources
├── docs/                   # Documentation
├── .gemini/                # AI assistant workspace
├── .amazonq/               # Amazon Q configuration
├── .github/                # GitHub workflows and CI/CD
└── .idx/                   # IDX environment configuration
```

## Platform-Specific Directories

### Web Application (`web/`)

```dir
web/
├── src/
│   ├── app/              # Next.js 14 App Router pages
│   ├── components/       # React components
│   ├── lib/              # Utilities and Firebase config
│   ├── types/            # TypeScript type definitions
│   └── test/             # Test files
├── public/
│   ├── fonts/            # Web fonts
│   ├── locales/          # Localization files
│   └── manifest.json     # PWA manifest
├── package.json          # Dependencies
├── next.config.js        # Next.js configuration
├── tailwind.config.ts    # Tailwind CSS configuration
└── tsconfig.json         # TypeScript configuration
```

**Key Components:**

- App Router for routing and layouts
- Zustand for state management
- Firebase SDK for backend services
- Tailwind CSS for styling
- TypeScript for type safety

### Android Application (`android/`)

```dir
android/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/neostudios/zest/
│   │       │   ├── ai/              # AI integration
│   │       │   ├── data/            # Data layer
│   │       │   ├── ui/              # Compose UI components
│   │       │   └── MainActivity.kt
│   │       └── res/                 # Resources
│   ├── build.gradle.kts
│   └── proguard-rules.pro
├── build.gradle.kts      # Root build configuration
├── gradle.properties     # Gradle properties
└── settings.gradle.kts   # Project settings
```

**Key Components:**

- Jetpack Compose for UI
- Material 3 Expressive design system
- Hilt for dependency injection
- Firebase SDK for backend
- Kotlin Coroutines for async operations

### iOS Application (`ios/`)

```dir
ios/
├── Zest/
│   ├── AI/               # AI integration (Apple Intelligence)
│   ├── Models/           # Data models
│   ├── Services/         # Business logic services
│   ├── ViewModels/       # MVVM view models
│   ├── Views/            # SwiftUI views
│   ├── Resources/        # Assets and resources
│   ├── Performance/      # Performance monitoring
│   ├── Info.plist        # App configuration
│   └── ZestApp.swift  # App entry point
├── ZestTests/     # Unit tests
├── Runner/               # Flutter compatibility layer
└── Podfile               # CocoaPods dependencies
```

**Key Components:**

- SwiftUI for declarative UI
- Liquid Glass design language
- Combine framework for reactive programming
- Firebase SDK for backend
- HealthKit for nutrition integration

## Shared Resources (`shared/`)

### Design Tokens (`shared/design-tokens/`)

- `tokens.json` - Unified design system tokens (colors, typography, spacing)

### Localization (`shared/locales/`)

- 21 language files (.lang format)
- Consistent translations across platforms

### Firebase Configuration (`shared/firebase-config/`)

- Setup documentation
- Firestore schema definitions

### Assets

- `shared/fonts/` - RobotoFlex variable font
- `shared/icons/` - Icon assets and guidelines

## Documentation (`docs/`)

- `ARCHITECTURE.md` - System architecture overview
- `AI_SUPPORT.md` - AI device compatibility
- `AI_SDK_INTEGRATION.md` - AI SDK integration guide
- `SETUP.md` - Development setup instructions
- SEO files (robots.txt, sitemap.xml, humans.txt)

## AI Assistant Workspace (`.gemini/`)

```dir
.gemini/
├── plans/          # Feature planning documents
├── tasks/          # Task lists with sub-tasks
├── progress/       # Phase summaries and session logs
└── diagnostics/    # Issue tracking and fixes
```

## CI/CD Configuration (`.github/workflows/`)

- `android-build.yml` - Android build pipeline
- `ios-build.yml` - iOS build pipeline
- `web-deploy.yml` - Web deployment pipeline
- `test.yml` - Automated testing

## Architectural Patterns

### Multi-Platform Architecture

- **Native Implementations** - Each platform uses native frameworks (Next.js, Kotlin Compose, SwiftUI)
- **Shared Backend** - Firebase provides unified backend (Auth, Firestore, Storage)
- **Design Token System** - Shared design tokens ensure visual consistency
- **Localization Strategy** - Centralized translation files

### Data Flow

1. **Client Layer** - Platform-specific UI (React, Compose, SwiftUI)
2. **Service Layer** - Business logic and API calls
3. **Firebase Backend** - Authentication, database, storage
4. **Local Storage** - Offline-first with local caching

### State Management

- **Web:** Zustand for global state
- **Android:** Hilt + ViewModel + StateFlow
- **iOS:** Combine + ObservableObject

### AI Integration

- Platform-specific AI SDKs (AICore, Galaxy AI, Apple Intelligence)
- On-device processing for privacy
- Fallback to cloud AI when unavailable

## Core Component Relationships

### Recipe Management Flow

```dir
UI Layer → ViewModel/State → Service Layer → Firebase/Local DB
```

### Authentication Flow

```dir
Login UI → Firebase Auth → User Session → Firestore User Profile
```

### AI Features Flow

```dir
User Input → AI Manager → Device AI SDK → Result Processing → UI Update
```

### Offline Sync Flow

```dir
Local DB ↔ Sync Service ↔ Firebase Firestore
```

## Development Environment

- **IDX Integration** - Firebase Studio environment
- **Package Management** - `.idx/dev.nix` for system dependencies
- **Hot Reload** - Supported on all platforms
- **Testing** - Platform-specific test frameworks
