# Project Structure

## Repository Layout

```dir
zest/
├── web/                    # Next.js web application
├── android/                # Android Kotlin application
├── ios/                    # iOS Swift application
├── shared/                 # Shared resources across platforms
├── docs/                   # Documentation
├── .github/                # GitHub workflows and CI/CD
├── .kiro/                  # Kiro AI assistant configuration
└── [root config files]     # License, README, security docs
```

## Web Application (`web/`)

```dir
web/
├── src/
│   ├── app/                # Next.js App Router pages
│   │   ├── ai-recipe-generator/
│   │   ├── api/            # API routes
│   │   ├── meal-plan/
│   │   ├── recipes/
│   │   ├── settings/
│   │   ├── shopping/
│   │   ├── layout.tsx      # Root layout
│   │   ├── page.tsx        # Home page
│   │   └── globals.css     # Global styles
│   ├── components/
│   │   ├── features/       # Feature-specific components
│   │   ├── ui/             # Reusable UI components
│   │   └── [components]    # Top-level components (CookingTimer, etc.)
│   ├── lib/
│   │   ├── firebase/       # Firebase configuration and utilities
│   │   ├── hooks/          # Custom React hooks
│   │   ├── i18n/           # Internationalization
│   │   ├── services/       # Business logic services
│   │   ├── stores/         # Zustand state stores
│   │   └── __tests__/      # Library tests
│   ├── hooks/              # Additional custom hooks
│   ├── types/              # TypeScript type definitions
│   │   └── models.ts       # Data models
│   └── test/               # Test configuration
├── public/                 # Static assets
├── next.config.js
├── tailwind.config.ts
├── tsconfig.json
├── vitest.config.ts
└── package.json
```

## Android Application (`android/`)

```dir
android/
├── app/
│   ├── src/
│   │   ├── main/           # Main source code
│   │   │   ├── java/       # Kotlin source files
│   │   │   │   └── [package structure with MVVM]
│   │   │   ├── res/        # Resources (layouts, drawables, values)
│   │   │   └── AndroidManifest.xml
│   │   └── test/           # Unit tests
│   ├── build.gradle.kts    # App-level build config
│   └── google-services.json # Firebase config (gitignored)
├── build.gradle.kts        # Root build config
├── gradle.properties
└── settings.gradle.kts
```

**Android Architecture**: MVVM + Clean Architecture with Repository pattern, Hilt DI, and Jetpack Compose UI.

## iOS Application (`ios/`)

```dir
ios/
├── Runner/                 # Main app target
│   ├── [Swift source files]
│   ├── Assets.xcassets/
│   ├── Info.plist
│   └── GoogleService-Info.plist # Firebase config (gitignored)
├── Zest/                   # Additional app files
├── ZestTests/       # Unit tests
├── Flutter/                # Flutter integration (legacy)
├── Podfile                 # CocoaPods dependencies
└── Zest.xcworkspace # Xcode workspace
```

**iOS Architecture**: MVVM with SwiftUI, ObservableObject for state, Combine for reactive programming, and service layer for data.

## Shared Resources (`shared/`)

```dir
shared/
├── design-tokens/          # Design system tokens (colors, spacing, typography)
├── locales/                # Translation files for 21 languages
├── firebase-config/        # Firebase setup documentation
├── fonts/                  # Shared font files
├── icons/                  # Shared icon assets
└── api-docs/               # API documentation
```

## Documentation (`docs/`)

Contains architecture docs, setup guides, AI integration docs, health integration, and project website files (index.html, robots.txt, sitemap.xml).

## File Naming Conventions

### Web (TypeScript)

- **Components**: PascalCase (e.g., `CookingTimer.tsx`)
- **Utilities/Services**: camelCase (e.g., `recipeImport.ts`)
- **Types**: PascalCase (e.g., `models.ts`)
- **Hooks**: camelCase with `use` prefix (e.g., `useNotifications.ts`)

### Android (Kotlin)

- **Files**: PascalCase matching class name (e.g., `RecipeViewModel.kt`)
- **Packages**: lowercase with underscores (e.g., `com.neostudios.zest.features.recipe`)

### iOS (Swift)

- **Files**: PascalCase matching type name (e.g., `RecipeView.swift`)

## Key Configuration Files

- **Root**: `LICENSE.md`, `README.md`, `SECURITY.md`, `CONTRIBUTING.md`, `MIGRATION.md`, `FIREBASE_SETUP.md`
- **Firebase**: `firestore.rules` (Firestore security rules)
- **Git**: `.gitignore` (root and platform-specific)
- **Environment**: `.env` (root), `web/.env.example`

## Platform Independence

Each platform (web, Android, iOS) is completely independent with its own:

- Build system and dependencies
- Source code and architecture
- Testing framework
- Configuration files

They share only:

- Firebase backend
- Design tokens and assets in `shared/`
- Documentation and project metadata
