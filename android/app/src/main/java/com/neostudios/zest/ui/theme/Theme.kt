package com.neostudios.zest.ui.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp

// Material 3 Expressive color scheme with vibrant, bold colors
private val LightColorScheme = lightColorScheme(
    primary = Color(0xFFFFA500),
    onPrimary = Color(0xFF000000),
    primaryContainer = Color(0xFFFFD180),
    onPrimaryContainer = Color(0xFF2F2F2F),
    secondary = Color(0xFF00B4D8),
    onSecondary = Color(0xFFFFFFFF),
    secondaryContainer = Color(0xFF80D8F0),
    onSecondaryContainer = Color(0xFF003D4F),
    tertiary = Color(0xFFFF6F61),
    onTertiary = Color(0xFFFFFFFF),
    tertiaryContainer = Color(0xFFFFB7B0),
    onTertiaryContainer = Color(0xFF3D0000),
    surface = Color(0xFFFFF8E1),
    onSurface = Color(0xFF2F2F2F),
    surfaceVariant = Color(0xFFFFECB3),
    onSurfaceVariant = Color(0xFF4A4A4A),
    background = Color(0xFFFFFBF5),
    onBackground = Color(0xFF2F2F2F),
    error = Color(0xFFD32F2F),
    onError = Color(0xFFFFFFFF)
)

private val DarkColorScheme = darkColorScheme(
    primary = Color(0xFFFFB74D),
    onPrimary = Color(0xFF1A1A1A),
    primaryContainer = Color(0xFFFF8F00),
    onPrimaryContainer = Color(0xFFFFE0B2),
    secondary = Color(0xFF4DD0E1),
    onSecondary = Color(0xFF1A1A1A),
    secondaryContainer = Color(0xFF0097A7),
    onSecondaryContainer = Color(0xFFB2EBF2),
    tertiary = Color(0xFFFF8A80),
    onTertiary = Color(0xFF1A1A1A),
    tertiaryContainer = Color(0xFFD32F2F),
    onTertiaryContainer = Color(0xFFFFCDD2),
    surface = Color(0xFF2A2A2A),
    onSurface = Color(0xFFF5F5F5),
    surfaceVariant = Color(0xFF3D3D3D),
    onSurfaceVariant = Color(0xFFE0E0E0),
    background = Color(0xFF1F1F1F),
    onBackground = Color(0xFFF5F5F5),
    error = Color(0xFFEF5350),
    onError = Color(0xFF1A1A1A)
)

// Material 3 Expressive shapes with more pronounced curves
private val ExpressiveShapes = Shapes(
    extraSmall = RoundedCornerShape(8.dp),
    small = RoundedCornerShape(12.dp),
    medium = RoundedCornerShape(16.dp),
    large = RoundedCornerShape(24.dp),
    extraLarge = RoundedCornerShape(32.dp)
)

@Composable
fun MinimalChefTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }
        darkTheme -> DarkColorScheme
        else -> LightColorScheme
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        shapes = ExpressiveShapes,
        content = content
    )
}
