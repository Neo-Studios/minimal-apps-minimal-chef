# Zest - Quick Start Guide

Get up and running with Zest in minutes!

---

## 🚀 Choose Your Platform

### 🌐 Web Development

**Prerequisites:**
- Node.js 20+
- npm or yarn

**Setup:**
```bash
cd web
npm install
cp .env.example .env.local
# Add your Firebase credentials to .env.local
npm run dev
```

**Open:** http://localhost:3000

**Features Available:**
- ✅ All core features
- ✅ AI recipe generation
- ✅ Offline mode
- ✅ PWA support

---

### 🍎 iOS Development

**Prerequisites:**
- macOS
- Xcode 15+
- CocoaPods

**Setup:**
```bash
cd ios
pod install
# Add GoogleService-Info.plist to project
open MinimalChef.xcworkspace
```

**Build:** Cmd+B  
**Run:** Cmd+R

**Features Available:**
- ✅ Google Sign-In
- ✅ All CRUD operations
- ✅ Image upload
- ✅ Star ratings
- ✅ Offline support
- ✅ Network monitoring

---

### 🤖 Android Development

**Prerequisites:**
- JDK 17
- Android Studio
- Android SDK

**Setup:**
```bash
cd android
# Add google-services.json to app/
./gradlew assembleDebug
```

**Current Status:**
- ✅ Backend architecture ready
- ⚠️ UI implementation needed

---

## 🔥 Firebase Setup

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create new project
3. Enable Authentication (Google Sign-In)
4. Enable Firestore Database
5. Enable Storage

### 2. Get Configuration Files

**For Web:**
```bash
# Copy Firebase config to web/.env.local
NEXT_PUBLIC_FIREBASE_API_KEY=your_api_key
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_auth_domain
NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_project_id
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your_storage_bucket
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
NEXT_PUBLIC_FIREBASE_APP_ID=your_app_id
```

**For iOS:**
1. Download `GoogleService-Info.plist`
2. Add to Xcode project

**For Android:**
1. Download `google-services.json`
2. Place in `android/app/`

### 3. Configure Firestore Rules
```bash
# Deploy security rules
firebase deploy --only firestore:rules
```

---

## 📱 Platform-Specific Features

### Web
- **Hot Reload:** Automatic with Next.js
- **Testing:** `npm test`
- **Build:** `npm run build`
- **Deploy:** Vercel or Firebase Hosting

### iOS
- **Simulator:** Cmd+R in Xcode
- **Device:** Connect iPhone, select device, Cmd+R
- **TestFlight:** Archive → Distribute
- **App Store:** Submit through App Store Connect

### Android
- **Emulator:** Run from Android Studio
- **Device:** Enable USB debugging, run
- **Beta:** Upload to Play Console
- **Production:** Submit to Play Store

---

## 🛠️ Development Workflow

### Web Development
```bash
cd web
npm run dev          # Start dev server
npm run lint         # Run ESLint
npm test             # Run tests
npm run build        # Production build
```

### iOS Development
```bash
cd ios
pod install          # Install dependencies
# Open in Xcode
# Cmd+B to build
# Cmd+R to run
# Cmd+U to test
```

### Android Development
```bash
cd android
./gradlew clean              # Clean build
./gradlew assembleDebug      # Build debug APK
./gradlew test               # Run tests
./gradlew assembleRelease    # Build release APK
```

---

## 🐛 Troubleshooting

### Web Issues

**Port already in use:**
```bash
# Kill process on port 3000
npx kill-port 3000
npm run dev
```

**Firebase errors:**
- Check `.env.local` has all required variables
- Verify Firebase project is enabled
- Check browser console for specific errors

### iOS Issues

**Pod install fails:**
```bash
cd ios
pod deintegrate
pod install
```

**Build fails:**
- Clean build folder: Cmd+Shift+K
- Delete derived data
- Restart Xcode

**GoogleService-Info.plist missing:**
- Download from Firebase Console
- Add to Xcode project (not just folder)

### Android Issues

**Gradle sync fails:**
```bash
cd android
./gradlew clean
./gradlew build --refresh-dependencies
```

**google-services.json missing:**
- Download from Firebase Console
- Place in `android/app/` directory
- Sync Gradle

---

## 📚 Documentation

### Essential Docs
- [Project Status](PROJECT_STATUS.md) - Overall progress
- [iOS Complete Guide](IOS_100_PERCENT_COMPLETE.md) - iOS implementation
- [Tech Stack](../README.md#tech-stack) - Technologies used
- [Firebase Setup](FIREBASE_SETUP.md) - Detailed Firebase guide

### Architecture Docs
- [Web Architecture](../web/README.md) - Next.js structure
- [iOS Architecture](IOS_100_PERCENT_COMPLETE.md#architecture-overview) - MVVM pattern
- [Android Architecture](../android/README.md) - Clean Architecture

---

## 🎯 Next Steps

### For Web Developers
1. ✅ Setup complete
2. Explore `web/src/app/` for pages
3. Check `web/src/components/` for components
4. Review `web/src/lib/` for utilities

### For iOS Developers
1. ✅ Setup complete
2. Explore `ios/Zest/Views/` for UI
3. Check `ios/Zest/ViewModels/` for logic
4. Review `ios/Zest/Services/` for Firebase

### For Android Developers
1. ✅ Backend ready
2. Start with `android/app/src/main/java/`
3. Implement Composables in `ui/` package
4. Connect ViewModels to UI

---

## 💡 Tips

### Web
- Use React DevTools for debugging
- Check Network tab for Firebase calls
- Use Lighthouse for performance

### iOS
- Use SwiftUI Previews for rapid development
- Check Console for Firebase logs
- Use Instruments for performance

### Android
- Use Layout Inspector for UI debugging
- Check Logcat for Firebase logs
- Use Profiler for performance

---

## 🆘 Getting Help

### Resources
- **Firebase Docs:** https://firebase.google.com/docs
- **Next.js Docs:** https://nextjs.org/docs
- **SwiftUI Docs:** https://developer.apple.com/documentation/swiftui
- **Compose Docs:** https://developer.android.com/jetpack/compose

### Community
- Open an issue on GitHub
- Check existing documentation
- Review code examples in project

---

## ✅ Verification Checklist

### Web
- [ ] Dev server running on port 3000
- [ ] Firebase connection working
- [ ] Can create account
- [ ] Can add recipe
- [ ] Hot reload working

### iOS
- [ ] Project opens in Xcode
- [ ] Build succeeds
- [ ] App runs in simulator
- [ ] Firebase connection working
- [ ] Can sign in with Google

### Android
- [ ] Project opens in Android Studio
- [ ] Gradle sync succeeds
- [ ] Build succeeds
- [ ] App runs in emulator
- [ ] Firebase configured

---

**Ready to code!** 🚀

Choose your platform above and start building!
