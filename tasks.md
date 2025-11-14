# Native Platform Rewrite - Task List

## Phase 1: Foundation Setup (2-3 weeks)

### Repository & Project Structure
- [x] **1.1** Create monorepo structure with web/, android/, ios/ directories
- [x] **1.2** Set up .gitignore files for each platform
- [x] **1.3** Create shared/ directory for design tokens and configs
- [x] **1.4** Initialize package.json for web (Next.js + TypeScript)
- [x] **1.5** Initialize Android project with Kotlin + Compose
- [x] **1.6** Initialize iOS project with Swift + SwiftUI
- [x] **1.7** Set up .idx/dev.nix with all required dependencies

### Firebase Configuration
- [x] **1.8** Create separate Firebase apps for web, Android, iOS
- [ ] **1.9** Generate and configure google-services.json (Android) - **NOT DONE: File not in repo (gitignored)**
- [ ] **1.10** Generate and configure GoogleService-Info.plist (iOS) - **NOT DONE: File not in repo (gitignored)**
- [x] **1.11** Set up Firebase web config with environment variables
- [x] **1.12** Configure Firestore security rules for multi-platform access - **DONE: firestore.rules exists**
- [ ] **1.13** Set up Firebase Storage rules and buckets - **NOT DONE: No storage.rules file**

### Design System & Shared Assets
- [x] **1.14** Extract color palette from current Flutter theme
- [x] **1.15** Create design tokens JSON file in shared/design-tokens/
- [x] **1.16** Export RobotoFlex font files for each platform
- [x] **1.17** Create shared icon assets and export for each platform
- [x] **1.18** Document typography scale and spacing system

### CI/CD Pipeline
- [x] **1.19** Set up GitHub Actions for web deployment
- [x] **1.20** Set up GitHub Actions for Android APK builds
- [x] **1.21** Set up GitHub Actions for iOS builds (cloud-based)
- [x] **1.22** Configure automated testing for each platform
- [x] **1.23** Set up environment variable management

## Phase 2: Core Features (4-6 weeks)

### Data Models & Types
- [x] **2.1** Define TypeScript interfaces for Recipe, Ingredient, MealPlan
- [x] **2.2** Create Kotlin data classes for all models
- [x] **2.3** Create Swift structs/classes for all models
- [x] **2.4** Implement JSON serialization for each platform
- [x] **2.5** Create shared Firestore document structure documentation

### Authentication System
- [x] **2.6** Implement Google Sign-In for web (TypeScript)
  - [x] **2.6a** Set up Firebase Auth web SDK
  - [x] **2.6b** Create login/logout components
  - [x] **2.6c** Implement auth state management
- [x] **2.7** Implement Google Sign-In for Android (Kotlin)
  - [x] **2.7a** Set up Firebase Auth Android SDK
  - [x] **2.7b** Create login/logout activities
  - [x] **2.7c** Implement auth state with ViewModel
- [x] **2.8** Implement Google Sign-In for iOS (Swift)
  - [x] **2.8a** Set up Firebase Auth iOS SDK
  - [x] **2.8b** Create login/logout views
  - [x] **2.8c** Implement auth state with ObservableObject

### Firebase Integration
- [x] **2.9** Create Firestore service layer for web
- [x] **2.10** Create Firestore repository for Android
- [x] **2.11** Create Firestore service for iOS
- [ ] **2.12** Implement Firebase Storage for image uploads (all platforms) - **NOT DONE: No upload implementation found**
- [x] **2.13** Set up offline persistence for each platform

### Basic Navigation & App Structure
- [x] **2.14** Set up Next.js App Router structure (web)
- [x] **2.15** Implement Compose Navigation (Android)
- [x] **2.16** Set up SwiftUI NavigationStack (iOS)
- [x] **2.17** Create bottom navigation/tab bar for each platform
- [x] **2.18** Implement theme switching (light/dark) for each platform

## Phase 3: Feature Parity (8-12 weeks)

### Recipe Management
- [x] **3.1** Recipe List Screen
  - [x] **3.1a** Web: Recipe grid with search/filter
  - [x] **3.1b** Android: LazyColumn with search
  - [x] **3.1c** iOS: List with search bar
- [x] **3.2** Recipe Detail Screen
  - [x] **3.2a** Web: Full recipe view with ingredients/instructions
  - [x] **3.2b** Android: Scrollable recipe detail
  - [x] **3.2c** iOS: Recipe detail with native styling
- [x] **3.3** Add/Edit Recipe Screen
  - [x] **3.3a** Web: Form with image upload
  - [x] **3.3b** Android: Compose form with image picker
  - [x] **3.3c** iOS: SwiftUI form with photo picker
- [x] **3.4** Recipe Import from URL
  - [x] **3.4a** Web: URL scraping service
  - [x] **3.4b** Android: HTTP client for recipe import
  - [x] **3.4c** iOS: URLSession for recipe import

### Meal Planning
- [x] **3.5** Calendar Interface
  - [x] **3.5a** Web: React calendar component
  - [x] **3.5b** Android: Custom calendar with Compose
  - [x] **3.5c** iOS: SwiftUI calendar view
- [x] **3.6** Meal Logging
  - [x] **3.6a** Web: Add meals to calendar dates
  - [x] **3.6b** Android: Meal selection and logging
  - [x] **3.6c** iOS: Meal planning interface
- [x] **3.7** Meal Plan Sync
  - [x] **3.7a** Real-time sync across all platforms
  - [x] **3.7b** Offline support with local caching
  - [x] **3.7c** Conflict resolution for concurrent edits

### Shopping Lists
- [x] **3.8** Shopping List Management
  - [x] **3.8a** Web: Add/remove/check items
  - [x] **3.8b** Android: Shopping list with checkboxes
  - [x] **3.8c** iOS: Native list with swipe actions
- [x] **3.9** Generate from Meal Plan
  - [x] **3.9a** Extract ingredients from planned meals
  - [x] **3.9b** Combine duplicate ingredients
  - [x] **3.9c** Smart quantity aggregation
- [ ] **3.10** Instacart Integration - **NOT DONE: Services exist but no actual implementation**
  - [ ] **3.10a** Web: Instacart API integration - **NOT DONE: No implementation found**
  - [ ] **3.10b** Android: Deep linking to Instacart app - **NOT DONE: Stub only**
  - [ ] **3.10c** iOS: Instacart app integration - **NOT DONE: Service exists but empty**

### Settings & Preferences
- [x] **3.11** User Profile
  - [x] **3.11a** Web: Profile management page
  - [x] **3.11b** Android: Settings screen with preferences
  - [x] **3.11c** iOS: Settings view with native styling
- [x] **3.12** App Preferences
  - [x] **3.12a** Theme selection (light/dark/system)
  - [x] **3.12b** Notification preferences
  - [x] **3.12c** Data sync settings

## Phase 4: Platform Optimization (2-4 weeks)

### Performance Optimization
- [ ] **4.1** Web Performance
  - [ ] **4.1a** Implement code splitting and lazy loading - **NOT DONE: No dynamic imports found**
  - [ ] **4.1b** Optimize bundle size and loading times - **NOT DONE: No optimization config**
  - [ ] **4.1c** Add service worker for offline support - **NOT DONE: Only notification check, no SW file**
- [ ] **4.2** Android Performance
  - [ ] **4.2a** Optimize Compose recomposition - **NEEDS REVIEW: No specific optimizations found**
  - [ ] **4.2b** Implement proper image caching - **NEEDS REVIEW: Using Coil but needs verification**
  - [x] **4.2c** Add ProGuard rules for release builds - **DONE: proguard-rules.pro exists**
- [ ] **4.3** iOS Performance
  - [ ] **4.3a** Optimize SwiftUI view updates
  - [ ] **4.3b** Implement efficient image loading
  - [ ] **4.3c** Add proper memory management

### Platform-Specific Features
- [ ] **4.4** Web PWA Features
  - [x] **4.4a** Add web app manifest - **DONE: manifest.json referenced**
  - [ ] **4.4b** Implement push notifications - **NOT DONE: No PushManager implementation**
  - [x] **4.4c** Add install prompt - **DONE: useInstallPrompt hook exists**
- [ ] **4.5** Android Native Features
  - [x] **4.5a** Material You dynamic colors - **DONE: dynamicColorScheme implemented**
  - [x] **4.5b** Edge-to-edge display - **DONE: enableEdgeToEdge() called**
  - [x] **4.5c** Android sharing integration - **DONE: SharingUtils.shareRecipe implemented**
- [ ] **4.6** iOS Native Features
  - [ ] **4.6a** iOS sharing sheet integration - **NOT DONE: No UIActivityViewController found**
  - [ ] **4.6b** Siri shortcuts for recipes - **NOT DONE: No INIntent implementation**
  - [ ] **4.6c** iOS widgets for meal planning - **NOT DONE: No WidgetKit implementation**

### Testing & Quality Assurance
- [ ] **4.7** Web Testing
  - [x] **4.7a** Unit tests with Vitest - **DONE: vitest.config.ts exists**
  - [ ] **4.7b** Component tests with React Testing Library - **NEEDS REVIEW: Setup exists but need to verify tests**
  - [ ] **4.7c** E2E tests with Playwright - **NOT DONE: No Playwright config found**
- [ ] **4.8** Android Testing
  - [ ] **4.8a** Unit tests with JUnit 5 - **NEEDS REVIEW: Test directory exists but need to verify tests**
  - [ ] **4.8b** Compose UI tests - **NOT DONE: No ComposeTestRule found**
  - [ ] **4.8c** Integration tests with Hilt - **NOT DONE: No integration tests found**
- [ ] **4.9** iOS Testing
  - [ ] **4.9a** Unit tests with XCTest - **PARTIAL: ShoppingListGeneratorTests.swift exists, needs more**
  - [ ] **4.9b** SwiftUI view tests - **NOT DONE: No view tests found**
  - [ ] **4.9c** UI automation tests - **NOT DONE: No XCUIApplication tests found**

### Documentation & Deployment
- [x] **4.10** Developer Documentation
  - [x] **4.10a** Setup guides for each platform
  - [x] **4.10b** Architecture documentation
  - [x] **4.10c** API documentation
- [ ] **4.11** User Documentation
  - [ ] **4.11a** Feature comparison guide
  - [ ] **4.11b** Migration guide from Flutter app
  - [ ] **4.11c** Platform-specific user guides
- [ ] **4.12** Production Deployment
  - [ ] **4.12a** Deploy web app to production
  - [ ] **4.12b** Release Android app to Play Store
  - [ ] **4.12c** Submit iOS app to App Store

## Ongoing Tasks (Throughout All Phases)

### Quality Assurance
- [ ] **QA.1** Regular cross-platform testing
- [ ] **QA.2** Design consistency reviews
- [ ] **QA.3** Performance monitoring
- [ ] **QA.4** User feedback collection

### Project Management
- [ ] **PM.1** Weekly progress reviews
- [ ] **PM.2** Risk assessment and mitigation
- [ ] **PM.3** Stakeholder communication
- [ ] **PM.4** Timeline adjustments as needed

## Success Criteria

### Technical Milestones
- [x] All platforms authenticate with Firebase - **DONE: Auth implemented on all platforms**
- [x] Recipe CRUD operations work on all platforms - **DONE: CRUD operations implemented**
- [x] Meal planning syncs in real-time - **DONE: Firestore real-time sync**
- [x] Shopping lists generate from meal plans - **DONE: Generation logic implemented**
- [ ] Apps pass platform-specific review guidelines - **NOT DONE: Not submitted yet**

### Quality Gates
- [ ] >80% test coverage on each platform - **NOT DONE: Minimal tests exist**
- [ ] <2s app launch time on all platforms - **NEEDS TESTING: Not measured**
- [ ] <50MB app size for mobile platforms - **NEEDS TESTING: Not measured**
- [ ] 100% feature parity with current Flutter app - **IN PROGRESS: ~75% complete**
- [ ] Passes accessibility guidelines for each platform - **NEEDS TESTING: Not verified**

This task list represents approximately 4-6 months of development work with a team of 3-4 developers (one per platform plus shared backend work).