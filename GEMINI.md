# Gemini Code-Aware Context

This document provides context for the Zest project, a multi-platform cooking application.

## Project Overview

Zest is a modern cooking application with native implementations for Web, Android, and iOS. It features recipe management, meal planning, smart shopping lists, and AI-powered assistance.

The project is structured as a monorepo with three separate frontends (`web`, `android`, `ios`) that share a common backend on Firebase.

## Platforms

### 🌐 Web (Production Ready)

* **Framework**: Next.js 14 with React 18 (App Router)
* **Language**: TypeScript
* **Styling**: Tailwind CSS with a custom Material 3 Expressive design system.
* **State Management**: Zustand
* **Data Fetching**: Firebase SDK
* **Testing**:
  * **Unit/Integration**: Vitest and React Testing Library
  * **E2E**: Playwright

### 🤖 Android (In Progress)

* **Language**: Kotlin
* **UI**: Jetpack Compose with Material 3 Expressive
* **Architecture**: MVVM + Clean Architecture
* **Dependency Injection**: Hilt

### 🍎 iOS (Complete)

* **Language**: Swift
* **UI**: SwiftUI with a custom "Liquid Glass" design language
* **Architecture**: MVVM
* **Frameworks**: Combine

## Shared Backend

* **Services**: Firebase (Authentication, Firestore, Storage)
* **Offline Support**: Firestore's local persistence is enabled on all platforms.

## Building and Running (Web)

### Prerequisites

* Node.js 20+
* npm

### Setup

1. Navigate to the `web` directory:

    ```bash
    cd web
    ```

2. Install dependencies:

    ```bash
    npm install
    ```

3. Set up Firebase:
    * Create a `.env.local` file in the `web` directory.
    * Add the following environment variables with your Firebase project's credentials (see `web/.env.example`):

        ```env
        NEXT_PUBLIC_FIREBASE_API_KEY=...
        NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=...
        NEXT_PUBLIC_FIREBASE_PROJECT_ID=...
        NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=...
        NEXT_PUBLIC_FIREBASE_APP_ID=...
        ```

### Commands

* **Run in development mode**: `npm run dev`
* **Create a production build**: `npm run build`
* **Start the production server**: `npm run start`
* **Run linter**: `npm run lint`
* **Run unit tests**: `npm test` or `npx vitest`
* **Run E2E tests**: `npx playwright test`

## Development Conventions (Web)

* **Code Style**: Follows standard TypeScript and React conventions. ESLint is configured to enforce this.
* **File Naming**: Use kebab-case for files and folders.
* **Components**: Stored in `src/components`.
* **State Management**:
  * Use Zustand for global state that needs to be shared across multiple components.
  * For local component state, use React's `useState` and `useReducer` hooks.
* **Styling**:
  * Use Tailwind CSS utility classes for styling.
  * Adhere to the Material 3 Expressive design system defined in `src/lib/design/material3-expressive.ts`.
* **Testing**:
  * Write unit tests for individual components and functions.
  * Write integration tests for features that involve multiple components.
  * Write E2E tests for critical user flows.
* **Commits**: Follow the Conventional Commits specification.
* **Branching**: Use feature branches (e.g., `feature/new-recipe-importer`).
