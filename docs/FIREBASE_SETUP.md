# Firebase Setup Guide for Zest

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Enter project name: `zest` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click **"Create project"**

## Step 2: Enable Authentication

1. In Firebase Console, go to **Build → Authentication**
2. Click **"Get started"**
3. Enable **Email/Password**:
   - Click "Email/Password"
   - Toggle "Enable"
   - Click "Save"
4. Enable **Google Sign-In**:
   - Click "Google"
   - Toggle "Enable"
   - Enter support email
   - Click "Save"

## Step 3: Create Firestore Database

1. Go to **Build → Firestore Database**
2. Click **"Create database"**
3. Choose **"Start in production mode"** (we'll add rules next)
4. Select location (choose closest to your users)
5. Click **"Enable"**

### Add Security Rules

Click **"Rules"** tab and paste:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // User profiles
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Recipes
    match /recipes/{recipeId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.userId;
    }
    
    // Meal plans
    match /mealPlans/{planId} {
      allow read, write: if request.auth.uid == resource.data.userId;
    }
    
    // Shopping lists
    match /shoppingLists/{userId}/items/{itemId} {
      allow read, write: if request.auth.uid == userId;
    }
    
    // Cookbooks
    match /cookbooks/{cookbookId} {
      allow read: if resource.data.isPublic == true || request.auth.uid == resource.data.userId;
      allow write: if request.auth.uid == resource.data.userId;
    }
  }
}
```

Click **"Publish"**

## Step 4: Storage (Not Required)

⚠️ **Note**: This application does NOT use Firebase Storage. Image URLs can be stored as external links in Firestore if needed. Skip any Storage setup.

The app works completely without Storage! Users can:
- ✅ Create and manage recipes
- ✅ Plan meals
- ✅ Generate shopping lists
- ✅ Track nutrition
- ✅ Use AI features
- ❌ Upload recipe images (will use placeholders)

## Step 5: Configure Web App

1. In Firebase Console, click ⚙️ (Settings) → **Project settings**
2. Scroll to **"Your apps"**
3. Click **Web icon** (</>) to add web app
4. Enter app nickname: `Zest Web`
5. Check **"Also set up Firebase Hosting"**
6. Click **"Register app"**
7. Copy the config object

### Add to Web App

Create `web/.env.local`:

```env
NEXT_PUBLIC_FIREBASE_API_KEY=your_api_key
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_project_id
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
NEXT_PUBLIC_FIREBASE_APP_ID=your_app_id
```

## Step 6: Configure Android App

1. In Firebase Console → **Project settings**
2. Click **Android icon** to add Android app
3. Enter package name: `com.neostudios.zest`
4. Enter app nickname: `Zest Android`
5. Click **"Register app"**
6. Download `google-services.json`
7. Place file in: `android/app/google-services.json`

### Verify Android Setup

Check `android/app/build.gradle.kts` has:
```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

Check `android/build.gradle.kts` has:
```kotlin
dependencies {
    classpath("com.google.gms:google-services:4.4.1")
}
```

## Step 7: Configure iOS App

1. In Firebase Console → **Project settings**
2. Click **iOS icon** to add iOS app
3. Enter bundle ID: `com.neostudios.zest`
4. Enter app nickname: `Zest iOS`
5. Click **"Register app"**
6. Download `GoogleService-Info.plist`
7. Place file in: `ios/Zest/GoogleService-Info.plist`

### Add to Xcode

1. Open `ios/Zest.xcworkspace` in Xcode
2. Right-click `Zest` folder
3. Select **"Add Files to Zest"**
4. Select `GoogleService-Info.plist`
5. Check **"Copy items if needed"**
6. Click **"Add"**

## Step 8: Test Connection

### Web
```bash
cd web
npm run dev
```
Visit http://localhost:3000 and try signing in

### Android
```bash
cd android
./gradlew assembleDebug
```
Install APK and test sign in

### iOS
```bash
cd ios
pod install
```
Open in Xcode, build and run

## Step 9: Create Indexes (Optional but Recommended)

Go to **Firestore → Indexes** and create:

1. **Recipes Collection**
   - Fields: `userId` (Ascending), `createdAt` (Descending)
   - Query scope: Collection

2. **Meal Plans Collection**
   - Fields: `userId` (Ascending), `date` (Ascending)
   - Query scope: Collection

## Step 10: Enable Offline Persistence

Already configured in code:
- **Web**: Automatic with Firebase SDK
- **Android**: Enabled in FirebaseApp initialization
- **iOS**: Enabled in Firebase configuration

## Troubleshooting

### Web: "Firebase not initialized"
- Check `.env.local` exists and has correct values
- Restart dev server: `npm run dev`

### Android: "google-services.json not found"
- Verify file is in `android/app/` directory
- Sync Gradle: `./gradlew clean build`

### iOS: "GoogleService-Info.plist not found"
- Verify file is added to Xcode project
- Check file is in target membership
- Clean build folder: Cmd+Shift+K

### Authentication not working
- Check Authentication is enabled in Firebase Console
- Verify package names/bundle IDs match exactly
- For Google Sign-In, add SHA-1 fingerprint (Android)

### Firestore permission denied
- Check security rules are published
- Verify user is authenticated
- Check userId matches in rules

## Next Steps

1. ✅ Firebase project created
2. ✅ Authentication enabled
3. ✅ Firestore database created
4. ✅ Web app configured
5. ✅ Android app configured
7. ✅ iOS app configured
8. ✅ Security rules added
9. 🎉 Ready to use!

### Free Tier Limits (Spark Plan)

- **Authentication**: 10K verifications/month
- **Firestore**: 1GB storage, 50K reads/day, 20K writes/day
- **Hosting**: 10GB storage, 360MB/day bandwidth
- **Storage**: ❌ Not used in this application

These limits are generous for development and small-scale use!

## Useful Commands

```bash
# Web development
cd web && npm run dev

# Android build
cd android && ./gradlew assembleDebug

# iOS build
cd ios && pod install && open Zest.xcworkspace

# View Firebase logs
firebase login
firebase projects:list
```

## Support

- [Firebase Documentation](https://firebase.google.com/docs)
- [Firebase Console](https://console.firebase.google.com/)
- [Zest GitHub Issues](https://github.com/neo-studios/zest/issues)
