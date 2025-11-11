# Firebase Configuration

## Setup Instructions

### 1. Create Firebase Apps

In Firebase Console, create three separate apps:
- **Web App**: For TypeScript/Next.js
- **Android App**: For Kotlin/Compose (package: com.neostudios.minimalchef)
- **iOS App**: For Swift/SwiftUI (bundle ID: com.neostudios.minimalchef)

### 2. Download Configuration Files

#### Web
- Download web config and create `web-app/.env.local`:
```
NEXT_PUBLIC_FIREBASE_API_KEY=your_api_key
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_auth_domain
NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_project_id
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your_storage_bucket
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
NEXT_PUBLIC_FIREBASE_APP_ID=your_app_id
```

#### Android
- Download `google-services.json`
- Place in `android-app/app/google-services.json`

#### iOS
- Download `GoogleService-Info.plist`
- Place in `ios-app/MinimalChef/GoogleService-Info.plist`

### 3. Enable Authentication

- Enable Google Sign-In in Firebase Console
- Add OAuth client IDs for each platform
- Configure authorized domains

### 4. Firestore Rules

Use the rules in `firestore.rules` (root directory)

### 5. Storage Rules

Configure Firebase Storage with appropriate security rules
