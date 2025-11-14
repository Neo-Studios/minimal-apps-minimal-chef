# Zest

**Version 0.5.0** - A modern cooking application with native implementations for Web, Android, and iOS.

[![TypeScript](https://img.shields.io/badge/TypeScript-Next.js-3178C6?logo=typescript)](https://nextjs.org)
[![Kotlin](https://img.shields.io/badge/Kotlin-Compose-7F52FF?logo=kotlin)](https://developer.android.com/jetpack/compose)
[![Swift](https://img.shields.io/badge/Swift-SwiftUI-FA7343?logo=swift)](https://developer.apple.com/xcode/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-Neo%20Studios-blue)](LICENSE.md)

## 🎉 What's New in v0.5

Zest v0.5 is a complete rewrite with native platforms for better performance and platform-specific features!

- **Native Web** - Next.js 14 with React 18
- **Native Android** - Kotlin with Jetpack Compose & Material 3 Expressive
- **Native iOS** - Swift with SwiftUI & Liquid Glass design
- **On-Device AI** - Support for 8 AI providers (Google, Samsung, Xiaomi, OPPO, OnePlus, Huawei, Qualcomm, Apple)
- **21 Languages** - Full internationalization support
- **Advanced Features** - Nutrition tracking, voice guidance, timers, offline mode, and more

## Features

### Core Features
- 📖 **Recipe Management** - Browse, create, import recipes from URLs
- 📅 **Meal Planning** - Calendar-based meal planning and tracking
- 🛒 **Shopping Lists** - Smart shopping lists with Instacart integration
- 📚 **Recipe Cookbooks** - Organize recipes into custom collections
- 🔍 **Advanced Search** - Filter by cuisine, dietary restrictions, time, rating

### Smart Features
- 🤖 **On-Device AI** - Recipe suggestions, photo analysis, instruction generation
- 🍎 **Nutrition Tracking** - Calorie counter, macros, nutrition dashboard
- 🗣️ **Voice-Guided Cooking** - Hands-free cooking mode with voice commands
- ⏱️ **Cooking Timers** - Multiple simultaneous timers with notifications
- 📏 **Unit Conversion** - Built-in metric/imperial converter
- 🔄 **Recipe Scaling** - Adjust serving sizes automatically

### Accessibility
- 🎨 **Dyslexia-Friendly Font** - OpenDyslexic font option
- 📱 **Haptic Feedback** - Tactile responses for actions
- 🔊 **Voice Input** - Dictate recipes and notes
- ♿ **Screen Reader Support** - Optimized for accessibility
- 🎯 **High Contrast Mode** - Better visibility
- 🌈 **Color Blind Modes** - Protanopia, Deuteranopia, Tritanopia support

### Multi-Platform
- 🌐 **Web** - Progressive Web App with offline support
- 📱 **Android** - Material 3 Expressive design with dynamic colors
- 🍎 **iOS** - Liquid Glass design language
- 🔄 **Cloud Sync** - Firebase real-time synchronization
- 📴 **Offline Mode** - Full offline functionality

## Supported AI Devices

### Android
- Google Pixel 8+ (AICore)
- Samsung Galaxy S23+, S24, Z Fold5, Z Flip5, Tab S9 (Galaxy AI)
- Xiaomi 14, 13 Ultra, Redmi K70 (HyperOS AI)
- OPPO Find X7, Find N3, Reno 11 (AndesGPT)
- OnePlus 12, 11, Open (OnePlus AI)
- Huawei Mate 60, Pura 70 (Pangu AI)
- Any Snapdragon 8 Gen 3 device (Qualcomm AI Engine)

### iOS
- iPhone 15 Pro/Pro Max, iPhone 16 series (Apple Intelligence)
- iPad Pro M1+, iPad Air M1+ (Apple Intelligence)

## Getting Started

### Prerequisites
- **Web**: Node.js 20+, npm
- **Android**: Android Studio, JDK 17, Gradle
- **iOS**: Xcode 15+, macOS (for iOS development)
- **Firebase**: Firebase project with Auth, Firestore, Storage

### Installation

```bash
# Clone the repository
git clone https://github.com/neo-studios/zest.git
cd zest

# Web setup
cd web
npm install
npm run dev

# Android setup
cd android
./gradlew build

# iOS setup (macOS only)
cd ios
pod install
open MinimalChef.xcworkspace
```

### Firebase Configuration

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable Authentication (Google Sign-In)
3. Enable Firestore Database
4. Enable Storage
5. Download configuration files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/MinimalChef/`
   - Web: Add Firebase config to `.env`

## Tech Stack

### Web
- Next.js 14.2 with React 18
- TypeScript 5.4
- Tailwind CSS 3.4 with Material 3 Expressive
- Mediterranean Blue theme (inspired by Greek islands)
- Firebase 10.12
- Zustand (state management)
- Dynamic theming (light/dark mode)

### Android
- Kotlin with Jetpack Compose
- Material 3 Expressive design system
- Hilt (dependency injection)
- Firebase SDK
- Coil (image loading)
- Dynamic color support (Android 12+)

### iOS
- Swift with SwiftUI
- Liquid Glass design language
- Translucent materials with depth
- Combine framework
- Firebase SDK
- HealthKit integration

## Project Structure

```
zest/
├── web/                    # Next.js web app
├── android/                # Android Kotlin app
├── ios/                    # iOS Swift app
├── shared/                 # Shared resources
│   ├── design-tokens/     # Design system tokens
│   ├── locales/           # 21 language files
│   └── firebase-config/   # Firebase setup docs
└── docs/                   # Documentation
```

## Languages Supported

English (US, UK, AU), French, Spanish, Italian, German, Dutch, Swedish, Portuguese, Japanese, Chinese, Korean, Russian, Polish, Turkish, Arabic, Hindi, Vietnamese, Thai, Indonesian

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Security

For security concerns, please see [SECURITY.md](SECURITY.md).

## License

This project is licensed under the Neo Studios Public Repository License - see [LICENSE.md](LICENSE.md) for details.

## Roadmap

### v2.1 (Planned)
- Recipe video support
- Collaborative meal planning
- Enhanced AI features with official SDKs
- More language support

### Future
- Smart home integration (Alexa, Google Home)
- Wearable support (Apple Watch, Wear OS)
- Meal kit integration
- Social features and recipe sharing

## Why Native?

This v0.5 native rewrite provides:
- 3x faster performance than cross-platform frameworks
- Native platform features and APIs
- Better design systems (Material 3 Expressive, Liquid Glass)
- On-device AI support
- Improved accessibility
- Smaller app sizes

## Support

- 📧 Email: support@neo-studios.com
- 🐛 Issues: [GitHub Issues](https://github.com/neo-studios/zest/issues)
- 📖 Docs: [docs/](docs/)

---

Made with ❤️ by Neo Studios
