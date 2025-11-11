# AI SDK Integration Guide

## Current Status

### Android

#### Google Pixel (AICore)
- **SDK**: Google Generative AI SDK
- **Status**: ✅ Integrated (v0.1.2)
- **Model**: Gemini Nano (on-device)
- **Implementation**: Uses `com.google.ai.client.generativeai` package
- **Note**: SDK is in early preview, fallback implemented

#### Samsung Galaxy AI
- **SDK**: Samsung Galaxy AI SDK
- **Status**: ⏳ Awaiting official SDK release
- **Fallback**: Template-based generation
- **Expected**: Q1 2025

#### Xiaomi HyperOS AI
- **SDK**: Xiaomi AI SDK
- **Status**: ⏳ Not publicly available
- **Fallback**: Template-based generation
- **Note**: Available in China market only

#### OPPO AndesGPT
- **SDK**: OPPO AI SDK
- **Status**: ⏳ Not publicly available
- **Fallback**: Template-based generation

#### OnePlus AI
- **SDK**: OnePlus AI SDK (based on OPPO)
- **Status**: ⏳ Not publicly available
- **Fallback**: Template-based generation

#### Huawei Pangu AI
- **SDK**: Huawei AI SDK
- **Status**: ⏳ HMS AI SDK in development
- **Fallback**: Template-based generation
- **Note**: Requires HMS instead of GMS

#### Qualcomm AI Engine
- **SDK**: Qualcomm AI Hub SDK
- **Status**: ⏳ Developer preview
- **Fallback**: Template-based generation
- **Note**: Hardware-level AI acceleration

### iOS

#### Apple Intelligence
- **SDK**: Apple Intelligence Framework
- **Status**: ⏳ iOS 18 beta, official release pending
- **Model**: Apple Foundation Models
- **Implementation**: Prepared for `AppleIntelligence` framework
- **Fallback**: Template-based generation
- **Expected**: iOS 18.1+ (Fall 2024)

### Web

#### Browser AI
- **SDK**: WebNN API / Chrome Built-in AI
- **Status**: ⏳ Experimental
- **Fallback**: Template-based generation
- **Note**: Chrome 127+ has experimental on-device AI

## Implementation Details

### Google Generative AI SDK (Android)

```kotlin
val generativeModel = GenerativeModel(
    modelName = "gemini-nano",
    apiKey = "" // On-device doesn't need API key
)

val response = generativeModel.generateContent(prompt)
val recipe = response.text
```

### Apple Intelligence (iOS - Coming Soon)

```swift
import AppleIntelligence

let model = AIModel.foundation
let response = try await model.generate(prompt: prompt)
let recipe = response.text
```

### Samsung Galaxy AI (Coming Soon)

```kotlin
val galaxyAI = GalaxyAI.getInstance()
val response = galaxyAI.generateText(prompt)
```

## Fallback Strategy

All platforms implement intelligent fallbacks:

1. **Try SDK**: Attempt to use native AI SDK
2. **Catch Errors**: Handle SDK unavailability gracefully
3. **Template Generation**: Use structured template with ingredients
4. **User Notification**: Clearly indicate AI provider used

## Testing

### Test on Real Devices
- Google Pixel 8+ for AICore
- Samsung Galaxy S24 for Galaxy AI
- iPhone 15 Pro+ for Apple Intelligence (iOS 18+)

### Fallback Testing
- Test on non-AI devices to verify fallback works
- Ensure no crashes when SDK unavailable

## Future Updates

As SDKs become available:
1. Update dependency versions
2. Replace fallback implementations
3. Test on target devices
4. Update documentation

## API Keys & Configuration

### Google AI
- On-device models don't require API keys
- Cloud fallback would need Firebase/Google Cloud setup

### Other Providers
- Most on-device AI doesn't require API keys
- Privacy-focused, no data leaves device

## Performance Considerations

- First generation may take 2-5 seconds
- Subsequent generations are faster (model cached)
- Battery impact is minimal (optimized hardware)
- No internet required

## Privacy

All AI processing happens on-device:
- ✅ No data sent to cloud
- ✅ No API calls to external servers
- ✅ Complete privacy
- ✅ Works offline
