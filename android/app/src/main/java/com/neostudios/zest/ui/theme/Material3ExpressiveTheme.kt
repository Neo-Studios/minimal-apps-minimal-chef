package com.neostudios.zest.ui.theme

import android.app.Activity
import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.res.colorResource
import androidx.core.view.WindowCompat
import com.neostudios.zest.R

@Composable
fun Material3ExpressiveTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    // Dynamic color is available on Android 12+
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit
) {
    val context = LocalContext.current

    val LightColors = lightColorScheme(
        primary = colorResource(id = R.color.m3_primary),
        onPrimary = colorResource(id = R.color.m3_on_primary),
        primaryContainer = colorResource(id = R.color.m3_primary_container),
        onPrimaryContainer = colorResource(id = R.color.m3_on_primary_container),
        secondary = colorResource(id = R.color.m3_secondary),
        onSecondary = colorResource(id = R.color.m3_on_secondary),
        secondaryContainer = colorResource(id = R.color.m3_secondary_container),
        onSecondaryContainer = colorResource(id = R.color.m3_on_secondary_container),
        tertiary = colorResource(id = R.color.m3_tertiary),
        onTertiary = colorResource(id = R.color.m3_on_tertiary),
        tertiaryContainer = colorResource(id = R.color.m3_tertiary_container),
        onTertiaryContainer = colorResource(id = R.color.m3_on_tertiary_container),
        error = colorResource(id = R.color.m3_error),
        errorContainer = colorResource(id = R.color.m3_error_container),
        onError = colorResource(id = R.color.m3_on_error),
        onErrorContainer = colorResource(id = R.color.m3_on_error_container),
        background = colorResource(id = R.color.m3_surface), // Using surface as background
        onBackground = colorResource(id = R.color.m3_on_surface), // Using on_surface as on_background
        surface = colorResource(id = R.color.m3_surface),
        onSurface = colorResource(id = R.color.m3_on_surface),
        surfaceVariant = colorResource(id = R.color.m3_surface_container_low), // Closest equivalent
        onSurfaceVariant = colorResource(id = R.color.m3_on_surface_variant),
        outline = colorResource(id = R.color.m3_outline),
        outlineVariant = colorResource(id = R.color.m3_outline_variant),
    )

    val DarkColors = darkColorScheme(
        primary = colorResource(id = R.color.m3_primary_dark),
        onPrimary = colorResource(id = R.color.m3_on_primary_dark),
        primaryContainer = colorResource(id = R.color.m3_primary_container_dark),
        onPrimaryContainer = colorResource(id = R.color.m3_on_primary_container_dark),
        secondary = colorResource(id = R.color.m3_secondary_dark),
        onSecondary = colorResource(id = R.color.m3_on_secondary_dark),
        secondaryContainer = colorResource(id = R.color.m3_secondary_container_dark),
        onSecondaryContainer = colorResource(id = R.color.m3_on_secondary_container_dark),
        tertiary = colorResource(id = R.color.m3_tertiary_dark),
        onTertiary = colorResource(id = R.color.m3_on_tertiary_dark),
        tertiaryContainer = colorResource(id = R.color.m3_tertiary_container_dark),
        onTertiaryContainer = colorResource(id = R.color.m3_on_tertiary_container_dark),
        error = colorResource(id = R.color.m3_error_dark),
        errorContainer = colorResource(id = R.color.m3_error_container_dark),
        onError = colorResource(id = R.color.m3_on_error_dark),
        onErrorContainer = colorResource(id = R.color.m3_on_error_container_dark),
        background = colorResource(id = R.color.m3_surface_dark), // Using surface as background
        onBackground = colorResource(id = R.color.m3_on_surface_dark), // Using on_surface as on_background
        surface = colorResource(id = R.color.m3_surface_dark),
        onSurface = colorResource(id = R.color.m3_on_surface_dark),
        surfaceVariant = colorResource(id = R.color.m3_surface_container_low_dark), // Closest equivalent
        onSurfaceVariant = colorResource(id = R.color.m3_on_surface_variant_dark),
        outline = colorResource(id = R.color.m3_outline_dark),
        outlineVariant = colorResource(id = R.color.m3_outline_variant_dark),
    )

    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }
        darkTheme -> DarkColors
        else -> LightColors
    }
    
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as Activity).window
            window.statusBarColor = colorScheme.primary.toArgb()
            WindowCompat.getInsetsController(window, view).isAppearanceLightStatusBars = !darkTheme
        }
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = ExpressiveTypography,
        shapes = ExpressiveShapes,
        content = content
    )
}
