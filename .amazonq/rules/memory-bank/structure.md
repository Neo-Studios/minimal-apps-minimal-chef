# Project Structure - Minimal Chef

## Directory Organization

```
minimal-apps-minimal-chef/
├── lib/                      # Main Flutter application code
│   ├── features/            # Feature-based modules
│   │   ├── auth/           # Authentication (Google Sign-In)
│   │   ├── common/         # Shared feature components
│   │   ├── discover/       # Recipe discovery interface
│   │   ├── home/           # Home screen and navigation
│   │   ├── meal_plan/      # Meal planning calendar
│   │   ├── recipe/         # Recipe management
│   │   ├── settings/       # App settings
│   │   └── shopping_list/  # Shopping list management
│   ├── core/               # Core services and utilities
│   │   └── services/       # Core service implementations
│   ├── data/               # Data layer
│   │   ├── recipes/        # Recipe data files
│   │   ├── database_helper.dart
│   │   ├── default_recipes.dart
│   │   ├── recipes.dart
│   │   ├── recipes.db      # SQLite database
│   │   └── sync_operation.dart
│   ├── models/             # Data models
│   ├── providers/          # State management providers
│   ├── screens/            # Screen widgets
│   ├── services/           # Service layer
│   ├── widgets/            # Reusable UI components
│   ├── firebase_options.dart
│   └── main.dart           # Application entry point
├── android/                # Android platform code
│   └── app/
│       └── src/main/
│           ├── java/       # Java plugin registrants
│           └── kotlin/     # Kotlin MainActivity
├── ios/                    # iOS platform code
│   ├── Runner/             # iOS app configuration
│   └── Flutter/            # Flutter iOS integration
├── web/                    # Web platform code
│   ├── icons/              # PWA icons
│   ├── dev-recipes.js      # Recipe import utilities
│   └── index.html          # Web entry point
├── macos/                  # macOS platform code
├── assets/                 # Static assets
│   └── fonts/              # Custom fonts (RobotoFlex)
├── test/                   # Unit and widget tests
│   ├── models/             # Model tests
│   ├── services/           # Service tests
│   └── widgets/            # Widget tests
├── .gemini/                # AI assistant workspace
│   ├── diagnostics/        # Issue diagnostics
│   ├── plans/              # Feature plans
│   └── tasks/              # Task lists
├── .github/                # GitHub workflows
│   └── workflows/          # CI/CD pipelines
├── .idx/                   # IDX environment config
├── docs/                   # Documentation website
└── pubspec.yaml            # Flutter dependencies
```

## Core Components

### Feature Modules (lib/features/)
Each feature is self-contained with its own screens, widgets, and logic:
- **auth**: Handles Google Sign-In and authentication state
- **recipe**: Recipe CRUD operations, import, and display
- **meal_plan**: Calendar-based meal planning with table_calendar
- **shopping_list**: Shopping list management with Instacart integration
- **discover**: Recipe browsing and discovery interface
- **home**: Main navigation and home screen
- **settings**: App configuration and preferences

### Data Layer (lib/data/)
- **database_helper.dart**: SQLite database management
- **default_recipes.dart**: Pre-loaded recipe data
- **recipes.dart**: Recipe data access layer
- **sync_operation.dart**: Cloud sync operations
- **recipes.db**: Local SQLite database for offline access

### Services (lib/services/ & lib/core/services/)
- **web_recipe_import_service_loader.dart**: Web recipe scraping and import
- Firebase integration services (Auth, Firestore, Storage)
- Local database services

### Models (lib/models/)
Data models for Recipe, Ingredient, MealPlan, ShoppingList entities

### Platform Code
- **android/**: Gradle build configuration, MainActivity, plugin registration
- **ios/**: Xcode project, AppDelegate, Info.plist
- **web/**: HTML entry point, PWA manifest, recipe import JS utilities
- **macos/**: macOS app configuration

## Architectural Patterns

### Feature-Based Architecture
The app uses a feature-based structure where each major feature (auth, recipe, meal_plan, shopping_list) is organized as a self-contained module with its own screens, widgets, and business logic.

### Data Flow
1. **UI Layer**: Feature screens and widgets
2. **Service Layer**: Business logic and API calls
3. **Data Layer**: Local SQLite + Cloud Firestore
4. **Firebase Backend**: Authentication, cloud storage, real-time sync

### State Management
- Local state management with StatefulWidget
- StreamBuilder for Firebase real-time updates
- Provider pattern for shared state (lib/providers/)

### Database Strategy
- **Local**: SQLite via sqflite for offline access
- **Cloud**: Cloud Firestore for synchronization
- **Hybrid**: Sync operations bridge local and cloud data

### Platform Integration
- Flutter platform channels for native functionality
- Firebase SDKs for each platform (Android, iOS, Web)
- Platform-specific configurations in respective directories

## Key Relationships

- **main.dart** → Initializes Firebase and launches AuthGate
- **AuthGate** → Routes to Home or Login based on auth state
- **Home** → Navigation hub for all feature modules
- **Features** → Access services for data operations
- **Services** → Interact with Firebase and local database
- **Models** → Shared across all layers for type safety
