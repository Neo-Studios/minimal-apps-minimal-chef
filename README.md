# Minimal Chef

**Version 0.1.0** - A minimalist cooking application built with Flutter that helps users discover recipes, plan meals, and manage shopping lists.

[![Flutter](https://img.shields.io/badge/Flutter-3.9%2B-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-Neo%20Studios-blue)](LICENSE.md)

## Features

- **Recipe Management** - Browse recipes from multiple cuisines, add custom recipes, import from URLs
- **Meal Planning** - Calendar-based meal planning and tracking
- **Shopping Lists** - Manage ingredients with Instacart integration
- **Multi-Platform** - Android, iOS, Web, Windows, Linux, macOS
- **Firebase Backend** - Cloud sync with Firestore, Google Sign-In authentication

## What's New in v0.1

🎉 First public release!
- Recipe management with URL import
- Calendar-based meal planning
- Shopping list with Instacart integration
- Multi-platform support (Android, iOS, Web, Desktop)
- Material 3 design with light/dark themes

See [CHANGELOG.md](CHANGELOG.md) for full details.

## Getting Started

### Prerequisites
- Flutter SDK ^3.9.0
- Firebase project configured
- Google Sign-In credentials
- Android SDK 31+ (for Android builds)

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
- **Database**: Cloud Firestore + SQLite (local)
- **Image Handling**: Firebase Storage + image_picker

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Security

For security concerns, please see [SECURITY.md](SECURITY.md).

## License

This project is licensed under the Neo Studios Public Repository License - see [LICENSE.md](LICENSE.md) for details.

## Roadmap

### v0.2 (Planned)
- AI Chef with voice-guided cooking
- Offline mode support
- Recipe sharing between users
- Enhanced search functionality

### Future
- Nutrition tracking
- Grocery delivery integration
- Recipe collections and favorites
- Social features

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

