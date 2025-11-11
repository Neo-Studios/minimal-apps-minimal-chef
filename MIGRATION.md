# Migration from Flutter to Native Platforms

## Overview

Minimal Chef has been completely rewritten from Flutter to native platform implementations.

## What Changed

### Before (Flutter)
- Single codebase for all platforms
- Dart programming language
- Flutter widgets
- Material Design 2

### After (Native)
- Three separate codebases
- TypeScript (Web), Kotlin (Android), Swift (iOS)
- Platform-native UI frameworks
- Material 3 Expressive (Android) + Liquid Glass (iOS)

## New Structure

```
minimal-apps-minimal-chef/
├── web/              # Next.js TypeScript app
├── android/          # Kotlin Compose app
├── ios/              # Swift SwiftUI app
├── shared/           # Design tokens, fonts, docs
└── flutter-legacy/   # Old Flutter code (archived)
```

## For Developers

### Flutter Code Location
All Flutter code has been moved to `flutter-legacy/` directory.

### New Development
- **Web**: `cd web && npm run dev`
- **Android**: `cd android && ./gradlew assembleDebug`
- **iOS**: `cd ios && pod install && open MinimalChef.xcworkspace`

### Firebase Configuration
Each platform now requires separate Firebase configuration:
- Web: `.env.local`
- Android: `google-services.json`
- iOS: `GoogleService-Info.plist`

See `docs/SETUP.md` for detailed instructions.

## Benefits of Native

1. **Performance**: Native code runs faster
2. **Design**: Platform-specific design languages
3. **Features**: Access to latest platform APIs
4. **UX**: Native feel on each platform

## Breaking Changes

- Flutter dependencies removed
- Separate builds required per platform
- Different development workflows
- Platform-specific code maintenance

## Rollback

If needed, Flutter code is preserved in `flutter-legacy/` directory.
To restore: `git checkout <commit-before-rewrite>`

## Questions?

See `docs/SETUP.md` or `docs/ARCHITECTURE.md` for more information.
