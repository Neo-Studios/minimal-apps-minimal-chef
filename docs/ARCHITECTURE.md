# Architecture Documentation

## Overview

Zest uses a native multi-platform architecture with three separate codebases sharing a common backend.

## Platform Architectures

### Web (TypeScript/Next.js)

- **Pattern**: Server Components + Client Components
- **State**: Zustand for global state
- **Data**: Firebase SDK + SWR for caching
- **Routing**: Next.js App Router

### Android (Kotlin/Compose)

- **Pattern**: MVVM + Clean Architecture
- **State**: ViewModel + StateFlow
- **Data**: Repository pattern with Firestore
- **DI**: Hilt
- **UI**: Jetpack Compose with Material 3 Expressive

### iOS (Swift/SwiftUI)

- **Pattern**: MVVM
- **State**: ObservableObject + Combine
- **Data**: Service layer with Firestore
- **UI**: SwiftUI with Liquid Glass design

## Shared Backend

### Firebase Services

- **Authentication**: Google Sign-In
- **Database**: Cloud Firestore
- **Storage**: Firebase Storage
- **Offline**: Local persistence enabled

### Data Models

Consistent across platforms:

- Recipe
- Ingredient
- MealPlan
- ShoppingListItem

## Design Systems

### Android: Material 3 Expressive

- Vibrant color schemes
- Bold typography
- Motion springs
- Varied shapes

### iOS: Liquid Glass

- Translucent materials
- Specular highlights
- Fluid animations
- Dimensional depth

## Offline Support

All platforms cache data locally:

- Web: IndexedDB via Firestore
- Android: Firestore persistence
- iOS: Firestore persistence
