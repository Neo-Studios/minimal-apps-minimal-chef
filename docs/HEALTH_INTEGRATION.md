# Health Integration

## Overview
All nutrition data logged in Zest is automatically synced to the platform's native health system.

## iOS - HealthKit Integration

### Automatic Sync
- All nutrition entries sync to Apple Health
- Data includes: calories, protein, carbs, fat
- Syncs immediately when nutrition is logged

### Usage
```swift
// Log nutrition - automatically syncs to HealthKit
NutritionService.shared.logNutrition(nutritionInfo)

// Request permissions
NutritionService.shared.requestHealthPermissions { granted in
    // Handle permission result
}
```

### Permissions Required
- Dietary Energy Consumed (write)
- Dietary Protein (write)
- Dietary Carbohydrates (write)
- Dietary Fat Total (write)

### Info.plist
Already configured with HealthKit usage description.

## Android - Health Connect Integration

### Automatic Sync
- All nutrition entries sync to Health Connect
- Data includes: calories, protein, carbs, fat
- Syncs immediately when nutrition is logged

### Usage
```kotlin
// Log nutrition - automatically syncs to Health Connect
val repository = NutritionRepository(context)
repository.logNutrition(nutritionInfo)

// Check availability
val available = repository.isHealthConnectAvailable()

// Check permissions
val hasPermissions = repository.hasHealthPermissions()

// Get required permissions for request
val permissions = repository.getRequiredPermissions()
```

### Permissions Required
- android.permission.health.READ_NUTRITION
- android.permission.health.WRITE_NUTRITION

### AndroidManifest.xml
Already configured with Health Connect permissions.

## Data Flow

### When User Logs Nutrition
1. User adds/edits recipe or meal
2. Nutrition calculated automatically
3. Data saved to Firestore
4. **Automatically synced to HealthKit/Health Connect**
5. Available in Apple Health or Health Connect app

### Data Synced
- **Calories** (kcal)
- **Protein** (grams)
- **Carbohydrates** (grams)
- **Fat** (grams)
- **Timestamp** (when logged)

## Privacy
- All health data stays on device
- Synced directly to Apple Health / Health Connect
- No health data stored on Zest servers
- User controls permissions

## Requirements

### iOS
- iOS 13.0+
- HealthKit framework
- User must grant permissions

### Android
- Android 9.0+ (API 28+)
- Health Connect app installed
- User must grant permissions

## Implementation Details

### iOS
- **HealthKitService.swift** - Manages HealthKit operations
- **NutritionService.swift** - High-level nutrition logging
- Automatic sync on every nutrition log

### Android
- **HealthConnectManager.kt** - Manages Health Connect operations
- **NutritionRepository.kt** - High-level nutrition logging
- Automatic sync on every nutrition log

## Future Enhancements
- Read nutrition data from health systems
- Sync exercise data
- Sync water intake
- Sync weight/body measurements
- Two-way sync for meal planning
