# Migration Guide: Flutter to Native Platforms

## Overview

Zest v2.0 represents a complete rewrite from Flutter to native platforms (Next.js for web, Kotlin for Android, Swift for iOS). This guide helps existing users transition smoothly.

## Why We Migrated

### Performance Improvements
- **3x faster** app launch times
- **50% smaller** app size on mobile
- **Native animations** and transitions
- Better memory management

### Platform-Specific Features
- **Android**: Material You dynamic colors, edge-to-edge display
- **iOS**: Liquid Glass design, better integration with iOS features
- **Web**: Progressive Web App with offline support

### Better User Experience
- Native look and feel on each platform
- Improved accessibility
- Platform-specific gestures and interactions
- Better keyboard and screen reader support

## What's Changed

### User Interface

#### Android
- **Before**: Material Design 2 with Flutter widgets
- **After**: Material 3 Expressive with Jetpack Compose
- **Impact**: More vibrant colors, smoother animations, dynamic theming

#### iOS
- **Before**: Cupertino widgets
- **After**: SwiftUI with Liquid Glass design
- **Impact**: Translucent materials, fluid animations, native iOS feel

#### Web
- **Before**: Flutter web
- **After**: Next.js with React
- **Impact**: Faster loading, better SEO, improved accessibility

### Data & Sync

#### Good News
- **All your data is preserved** - recipes, meal plans, shopping lists
- **Same Firebase backend** - no data migration needed
- **Automatic sync** - sign in with the same Google account

#### What to Know
- First sync may take a few moments
- Offline data will sync when you're back online
- No action required from you

### Features

#### Maintained Features
All core features from v1.x are available:
- ✅ Recipe management
- ✅ Meal planning
- ✅ Shopping lists
- ✅ Nutrition tracking
- ✅ Multiple timers
- ✅ Recipe import
- ✅ Offline mode

#### New Features
- ✅ Cookbook collections
- ✅ Recipe scaling
- ✅ Enhanced sharing
- ✅ Better search and filters
- ✅ Improved accessibility
- ✅ Platform-specific optimizations

#### Temporarily Unavailable
- ⏳ Recipe video support (coming in v2.1)
- ⏳ Collaborative meal planning (coming in v2.1)
- ⏳ Wearable support (coming in v2.2)

## Migration Steps

### For Mobile Users (Android/iOS)

#### Step 1: Update the App
1. Open Google Play Store (Android) or App Store (iOS)
2. Find Zest in your app list
3. Tap **Update**
4. Wait for download and installation

#### Step 2: First Launch
1. Open the updated app
2. Sign in with your Google account (same as before)
3. Grant necessary permissions:
   - Notifications (for timers and reminders)
   - Photos (for recipe images)
   - Camera (for taking recipe photos)

#### Step 3: Verify Your Data
1. Check that your recipes are visible
2. Verify meal plans are intact
3. Review shopping lists
4. If anything is missing, pull down to refresh

#### Step 4: Explore New Features
1. Try the new cookbook feature
2. Test recipe scaling
3. Explore the updated settings
4. Customize your theme and accessibility options

### For Web Users

#### Step 1: Clear Browser Cache
1. Open browser settings
2. Clear cache and cookies for zest.app
3. Refresh the page

#### Step 2: Reinstall PWA (if applicable)
1. Uninstall the old PWA from your device
2. Visit zest.app in your browser
3. Click the install prompt
4. Add to home screen

#### Step 3: Sign In
1. Use your existing Google account
2. Your data will sync automatically
3. Enable notifications if desired

## Troubleshooting

### Data Not Syncing

**Problem**: Recipes or meal plans are missing after update

**Solutions**:
1. Ensure you're signed in with the correct Google account
2. Check internet connection
3. Pull down to refresh on the main screen
4. Sign out and sign back in
5. Contact support if issues persist

### App Crashes on Launch

**Problem**: App closes immediately after opening

**Solutions**:
1. Restart your device
2. Clear app cache (Settings > Apps > Zest > Clear Cache)
3. Uninstall and reinstall the app
4. Ensure your device OS is up to date

### Features Look Different

**Problem**: UI doesn't match what you're used to

**Explanation**: This is expected! The new native design is intentionally different and follows platform-specific guidelines.

**Tips**:
- Give it a few days to adjust
- Explore the new features
- Customize theme and layout in Settings
- Provide feedback if something is confusing

### Performance Issues

**Problem**: App feels slow or laggy

**Solutions**:
1. Ensure you have the latest version
2. Restart the app
3. Check available storage space
4. Disable animations in Settings if needed
5. Report persistent issues to support

## Feature Comparison

| Feature | v1.x (Flutter) | v2.0 (Native) | Notes |
|---------|----------------|---------------|-------|
| Recipe CRUD | ✅ | ✅ | Enhanced with scaling |
| Meal Planning | ✅ | ✅ | Improved calendar UI |
| Shopping Lists | ✅ | ✅ | Better organization |
| Nutrition Tracking | ✅ | ✅ | More detailed |
| Timers | ✅ | ✅ | Multiple timers support |
| Recipe Import | ✅ | ✅ | Faster and more reliable |
| Offline Mode | ✅ | ✅ | Better sync |
| Cookbooks | ❌ | ✅ | New feature |
| Recipe Scaling | ❌ | ✅ | New feature |
| Voice Guidance | ✅ | ✅ | Improved |
| AI Features | ✅ | ✅ | Android/iOS only |
| Widgets | ✅ | ⏳ | Coming soon |
| Wearables | ✅ | ⏳ | Coming soon |

## Rollback Option

If you experience critical issues with v2.0, you can temporarily rollback:

### Android
1. Uninstall the current version
2. Download v1.x APK from our website
3. Install manually
4. Note: This is temporary; v1.x will not receive updates

### iOS
1. Uninstall the current version
2. Reinstall from App Store
3. If v2.0 is the only version, contact support

### Web
1. Use the legacy version at legacy.zest.app
2. Note: Limited support and no new features

**Important**: We strongly recommend staying on v2.0 as v1.x will be deprecated in 3 months.

## Getting Help

### Support Channels
- **Email**: support@zest.app
- **Community Forum**: community.zest.app
- **Live Chat**: Available in app Settings
- **FAQ**: zest.app/faq

### Reporting Issues
When reporting issues, please include:
- Device model and OS version
- App version (found in Settings > About)
- Steps to reproduce the issue
- Screenshots if applicable
- Whether data was migrated from v1.x

### Feature Requests
We're actively developing v2.1 and beyond. Submit feature requests at feedback.zest.app.

## Timeline

- **November 2024**: v2.0 release (current)
- **December 2024**: v2.1 with collaborative features
- **January 2025**: v2.2 with wearable support
- **February 2025**: v1.x deprecated

## Feedback

Your feedback helps us improve! Please:
- Rate the app in your app store
- Share your experience in the community
- Report bugs promptly
- Suggest improvements

Thank you for being part of the Zest community!

---

**Last Updated**: November 2024 | **Version**: 2.0
