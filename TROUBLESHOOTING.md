# Troubleshooting Guide

Common issues and solutions for Minimal Chef.

## Firebase Setup Issues

### "Firebase options not found"
**Problem**: App crashes on startup with Firebase initialization error.

**Solution**:
1. Ensure `firebase_options.dart` exists in `lib/`
2. Run `flutterfire configure` to generate it
3. Make sure Firebase project is properly set up

### Google Sign-In fails on Android
**Problem**: Google Sign-In returns error or doesn't work.

**Solution**:
1. Add SHA-1 fingerprint to Firebase Console
2. Download updated `google-services.json`
3. Place it in `android/app/`
4. Rebuild the app

```bash
# Get SHA-1 fingerprint
cd android
./gradlew signingReport
```

### Google Sign-In fails on Web
**Problem**: 404 error or sign-in popup doesn't work.

**Solution**:
1. Enable Google Sign-In in Firebase Console
2. Add authorized domains in Firebase Console
3. Ensure web client ID is configured
4. Check browser console for errors

## Build Issues

### "Gradle build failed"
**Problem**: Android build fails with Gradle errors.

**Solution**:
1. Clean build: `flutter clean`
2. Get dependencies: `flutter pub get`
3. Update Gradle: Check `android/gradle/wrapper/gradle-wrapper.properties`
4. Sync Gradle files in Android Studio

### "CocoaPods not installed" (iOS)
**Problem**: iOS build fails due to CocoaPods.

**Solution**:
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
flutter run
```

### Out of storage during build
**Problem**: Build fails due to insufficient storage.

**Solution**:
1. Run `flutter clean` to remove build artifacts
2. Clear Flutter cache: `flutter pub cache clean`
3. Remove unused dependencies
4. Use `--no-tree-shake-icons` flag cautiously

## Runtime Issues

### "No recipes showing"
**Problem**: Recipe list is empty after sign-in.

**Solution**:
1. Check internet connection
2. Verify Firestore rules allow read access
3. Check Firebase Console for data
4. Try signing out and back in

### "Image upload fails"
**Problem**: Cannot upload recipe images.

**Solution**:
1. Check camera/storage permissions
2. Verify Firebase Storage is enabled
3. Check Firebase Storage rules
4. Ensure sufficient storage quota

### "Recipe import doesn't work"
**Problem**: URL import fails or returns no data.

**Solution**:
1. Verify URL is accessible
2. Check internet connection
3. Some sites may block scraping
4. Try a different recipe URL

## Performance Issues

### App is slow or laggy
**Solutions**:
1. Clear app cache
2. Reduce image sizes before upload
3. Check internet connection speed
4. Restart the app

### High memory usage
**Solutions**:
1. Limit number of images loaded at once
2. Use image caching
3. Close and reopen app periodically

## Platform-Specific Issues

### Android: "Cleartext HTTP traffic not permitted"
**Solution**: Check `android/app/src/main/AndroidManifest.xml` for network security config.

### iOS: "App Transport Security" error
**Solution**: Update `ios/Runner/Info.plist` with proper ATS settings.

### Web: CORS errors
**Solution**: 
1. Some recipe sites block cross-origin requests
2. Use a CORS proxy for development
3. Consider server-side import for production

## Development Issues

### Hot reload not working
**Solutions**:
1. Try hot restart (Shift + R)
2. Stop and restart app
3. Run `flutter clean`

### "Package not found" errors
**Solutions**:
```bash
flutter pub get
flutter pub upgrade
```

### IDE not recognizing Flutter
**Solutions**:
1. Restart IDE
2. Run `flutter doctor`
3. Reinstall Flutter plugin

## Getting Help

If your issue isn't listed here:

1. Check [GitHub Issues](https://github.com/your-repo/minimal-chef/issues)
2. Search existing issues for similar problems
3. Create a new issue with:
   - Clear description
   - Steps to reproduce
   - Error messages
   - Device/platform info
   - Flutter version (`flutter --version`)

## Useful Commands

```bash
# Check Flutter installation
flutter doctor -v

# Clean build artifacts
flutter clean

# Update dependencies
flutter pub upgrade

# Analyze code
flutter analyze

# Check for outdated packages
flutter pub outdated

# Run on specific device
flutter devices
flutter run -d <device-id>
```
