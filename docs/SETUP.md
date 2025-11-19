# Setup Guide - Zest Native Apps

## Prerequisites

### All Platforms

- Firebase project with Auth, Firestore, and Storage enabled
- Google OAuth credentials configured

### Web

- Node.js 20+
- npm or yarn

### Android

- JDK 17
- Android SDK
- Gradle 8+

### iOS

- macOS with Xcode 15+
- CocoaPods

## Setup Instructions

### 1. Firebase Configuration

#### Web configuration

1. Create `.env.local` in `web/` directory:

```env
NEXT_PUBLIC_FIREBASE_API_KEY=your_key
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_domain
NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_project
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your_bucket
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
NEXT_PUBLIC_FIREBASE_APP_ID=your_app_id
```

#### Android Configuration

1. Download `google-services.json` from Firebase Console
2. Place in `android/app/google-services.json`

#### iOS Configuration

1. Download `GoogleService-Info.plist` from Firebase Console
2. Place in `ios/MinimalChef/GoogleService-Info.plist`

### 2. Install Dependencies

#### Web Dependencies

```bash
cd web
npm install
npm run dev
```

#### Android Dependencies

```bash
cd android
./gradlew assembleDebug
```

#### iOS Dependencies

```bash
cd ios
pod install
open MinimalChef.xcworkspace
```

### 3. Run Tests

#### Web tests

```bash
cd web
npm test
```

#### Android tests

```bash
cd android
./gradlew test
```

#### iOS tests

```bash
cd ios
xcodebuild test -scheme MinimalChef -destination 'platform=iOS Simulator,name=iPhone 14'
```

## Troubleshooting

### Firebase Connection Issues

- Verify config files are in correct locations
- Check Firebase project settings
- Ensure OAuth credentials are configured

### Build Failures

- Clean build: `./gradlew clean` (Android) or `Product > Clean` (iOS)
- Delete node_modules and reinstall (Web)
- Update dependencies

## Production Deployment

See `.github/workflows/` for CI/CD configurations.
