# Minimal Chef

A minimalist cooking application built with Flutter that helps users discover recipes, plan meals, and manage shopping lists.

## Features

- **Recipe Management** - Browse recipes from multiple cuisines, add custom recipes, import from URLs
- **Meal Planning** - Calendar-based meal planning and tracking
- **Shopping Lists** - Manage ingredients with Instacart integration
- **Multi-Platform** - Android, iOS, Web, Windows, Linux, macOS
- **Firebase Backend** - Cloud sync with Firestore, Google Sign-In authentication

## Getting Started

### Prerequisites
- Flutter SDK ^3.9.0
- Firebase project configured
- Google Sign-In credentials

### Installation

```bash
# 1. Install dependencies
flutter pub get

# 2. Setup Firebase configuration
cp lib/firebase_options.dart.example lib/firebase_options.dart
# Edit lib/firebase_options.dart with your Firebase credentials

# 3. Run the app
flutter run
```

### Platform-Specific Setup

#### Android
- Add SHA-1 fingerprint to Firebase Console
- Ensure `google-services.json` is in `android/app/`

#### iOS (Without Mac)
Use GitHub Actions for building:
1. Push code to GitHub
2. Go to Actions → Run "iOS Build" workflow
3. Download built app from artifacts

Alternatively, use [Codemagic](https://codemagic.io) (500 free minutes/month)

#### Web
- Google Sign-In configured with web client ID
- Run: `flutter run -d chrome`

## Building

```bash
flutter build apk          # Android
flutter build web          # Web
```

For iOS builds without Mac, see `.github/workflows/ios-build.yml`

## CI/CD Setup

For GitHub Actions builds, you need to configure Firebase secrets. See [`.github/SECRETS_SETUP.md`](.github/SECRETS_SETUP.md) for detailed instructions.

## Tech Stack

- **Framework**: Flutter 3.9+
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Authentication**: Google Sign-In
- **UI**: Material 3 with custom RobotoFlex typography
- **State**: Local state management with StreamBuilder

## Project Structure

```
lib/
├── features/          # Feature modules
│   ├── auth/         # Authentication
│   ├── recipe/       # Recipe management
│   ├── meal_plan/    # Meal planning
│   └── shopping_list/
├── core/             # Core services
├── data/             # Static data & database
└── main.dart
```

