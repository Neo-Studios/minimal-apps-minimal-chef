# Firebase Setup

Firebase configuration files are not included in version control for security reasons.

## Setup Instructions

1. Run FlutterFire CLI to generate configuration:
   ```bash
   flutterfire configure
   ```
   This creates `lib/firebase_options.dart`

2. Download `google-services.json` from Firebase Console:
   - Go to Project Settings > Your apps > Android app
   - Download `google-services.json`
   - Place it in `android/app/google-services.json`

3. For iOS/macOS, download `GoogleService-Info.plist`:
   - Go to Project Settings > Your apps > iOS app
   - Download `GoogleService-Info.plist`
   - Place in `ios/Runner/` and `macos/Runner/`
