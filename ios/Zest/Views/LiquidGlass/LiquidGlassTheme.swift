import SwiftUI

/**
 * Liquid Glass Design System for iOS
 * Based on https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass
 * 
 * Liquid Glass is Apple's design language featuring:
 * - Translucent materials with depth
 * - Specular highlights and reflections
 * - Smooth, fluid animations
 * - Adaptive color palettes
 * - Depth and layering
 */

// MARK: - Color Palette
struct LiquidGlassColors {
    // Primary colors
    static let primaryLight = Color(red: 1.0, green: 0.647, blue: 0.0) // #FFA500
    static let primaryDark = Color(red: 1.0, green: 0.718, blue: 0.2)  // #FFB733
    
    // Secondary colors
    static let secondaryLight = Color(red: 0.0, green: 0.706, blue: 0.847) // #00B4D8
    static let secondaryDark = Color(red: 0.2, green: 0.765, blue: 0.890)  // #33C3E3
    
    // Tertiary colors
    static let tertiaryLight = Color(red: 0.298, green: 0.686, blue: 0.314) // #4CAF50
    static let tertiaryDark = Color(red: 0.435, green: 0.749, blue: 0.451)  // #6FBF73
    
    // Surface colors
    static let surfaceLight = Color(red: 1.0, green: 0.973, blue: 0.882) // #FFF8E1
    static let surfaceDark = Color(red: 0.110, green: 0.106, blue: 0.122) // #1C1B1F
    
    // Adaptive colors
    static func primary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? primaryDark : primaryLight
    }
    
    static func secondary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? secondaryDark : secondaryLight
    }
    
    static func tertiary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? tertiaryDark : tertiaryLight
    }
    
    static func surface(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? surfaceDark : surfaceLight
    }
}

// MARK: - Typography
struct LiquidGlassTypography {
    // Display styles
    static let displayLarge = Font.system(size: 57, weight: .regular, design: .rounded)
    static let displayMedium = Font.system(size: 45, weight: .regular, design: .rounded)
    static let displaySmall = Font.system(size: 36, weight: .regular, design: .rounded)
    
    // Headline styles
    static let headlineLarge = Font.system(size: 32, weight: .semibold, design: .rounded)
    static let headlineMedium = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let headlineSmall = Font.system(size: 24, weight: .semibold, design: .rounded)
    
    // Title styles
    static let titleLarge = Font.system(size: 22, weight: .medium, design: .rounded)
    static let titleMedium = Font.system(size: 16, weight: .medium, design: .rounded)
    static let titleSmall = Font.system(size: 14, weight: .medium, design: .rounded)
    
    // Body styles
    static let bodyLarge = Font.system(size: 16, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 14, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 12, weight: .regular, design: .default)
    
    // Label styles
    static let labelLarge = Font.system(size: 14, weight: .medium, design: .default)
    static let labelMedium = Font.system(size: 12, weight: .medium, design: .default)
    static let labelSmall = Font.system(size: 11, weight: .medium, design: .default)
}

// MARK: - Spacing
struct LiquidGlassSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let xxxl: CGFloat = 48
}

// MARK: - Corner Radius
struct LiquidGlassCornerRadius {
    static let extraSmall: CGFloat = 8
    static let small: CGFloat = 12
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let extraLarge: CGFloat = 32
    static let full: CGFloat = 9999
}

// MARK: - Materials
enum LiquidGlassMaterial {
    case ultraThin
    case thin
    case regular
    case thick
    case ultraThick
    
    var material: Material {
        switch self {
        case .ultraThin: return .ultraThinMaterial
        case .thin: return .thinMaterial
        case .regular: return .regularMaterial
        case .thick: return .thickMaterial
        case .ultraThick: return .ultraThickMaterial
        }
    }
}

// MARK: - Animations
struct LiquidGlassAnimation {
    // Spring animations for fluid motion
    static let spring = Animation.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0)
    static let springBouncy = Animation.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)
    static let springSmooth = Animation.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)
    
    // Easing curves
    static let easeInOut = Animation.easeInOut(duration: 0.3)
    static let easeOut = Animation.easeOut(duration: 0.25)
    static let easeIn = Animation.easeIn(duration: 0.25)
    
    // Interactive animations
    static let interactive = Animation.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)
}

// MARK: - Shadows
struct LiquidGlassShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    static let small = LiquidGlassShadow(
        color: .black.opacity(0.08),
        radius: 4,
        x: 0,
        y: 2
    )
    
    static let medium = LiquidGlassShadow(
        color: .black.opacity(0.12),
        radius: 8,
        x: 0,
        y: 4
    )
    
    static let large = LiquidGlassShadow(
        color: .black.opacity(0.15),
        radius: 16,
        x: 0,
        y: 8
    )
    
    static let extraLarge = LiquidGlassShadow(
        color: .black.opacity(0.18),
        radius: 24,
        x: 0,
        y: 12
    )
}

// MARK: - Blur Effects
struct LiquidGlassBlur {
    static let light: CGFloat = 10
    static let medium: CGFloat = 20
    static let heavy: CGFloat = 30
}
