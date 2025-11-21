# Zest

## Project Overview

Zest is a modern, multi-platform cooking application with native implementations for Web, Android, and iOS. It offers a rich feature set including recipe management, meal planning, smart shopping lists, and AI-powered assistance. The project is divided into separate platforms, each with its own native codebase, to ensure optimal performance and user experience.

The project is structured as a monorepo with the following key directories:

-   `web/`: The Next.js-based web application.
-   `android/`: The native Android application written in Kotlin with Jetpack Compose.
-   `ios/`: The native iOS application written in Swift with SwiftUI.
-   `shared/`: Contains shared resources such as design tokens, localization files, and Firebase configuration documentation.
-   `docs/`: The project's documentation, built with Docusaurus.

## Building and Running

### Web (Next.js)

To build and run the web application, navigate to the `web/` directory and use the following commands:

```bash
# Install dependencies
npm install

# Run the development server
npm run dev

# Build for production
npm run build

# Start the production server
npm run start

# Run the linter
npm run lint
```

### Android (Kotlin/Compose)

To build the Android application, navigate to the `android/` directory and use the following command:

```bash
# Build the application
./gradlew build
```

### iOS (Swift/SwiftUI)

To build and run the iOS application:

1.  Navigate to the `ios/` directory.
2.  Install the required pods:
    ```bash
    pod install
    ```
3.  Open the `Zest.xcworkspace` file in Xcode.
4.  Build and run the project from within Xcode.

## Development Conventions

-   **Code Style:** The project uses Prettier for code formatting (in the web directory). The `.eslintrc.json` file in the `web` directory contains the ESLint configuration.
-   **Testing:** The web project uses Vitest for testing.
-   **Contributing:** Contribution guidelines are available in `CONTRIBUTING.md`.
-   **Security:** Security policies and procedures are outlined in `SECURITY.md`.
-   **Design:** The project utilizes a design system with tokens defined in `shared/design-tokens/tokens.json`. The web platform uses Tailwind CSS with a Mediterranean Blue theme, while the Android and iOS platforms have their own native design implementations (Material 3 Expressive and Liquid Glass, respectively).
