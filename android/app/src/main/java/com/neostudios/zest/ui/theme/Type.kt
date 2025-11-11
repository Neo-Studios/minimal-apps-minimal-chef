package com.neostudios.zest.ui.theme

import androidx.compose.material3.Typography
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

// Material 3 Expressive typography with bolder weights and tighter spacing
val Typography = Typography(
    displayLarge = TextStyle(fontSize = 64.sp, fontWeight = FontWeight.Bold, letterSpacing = (-0.5).sp, lineHeight = 72.sp),
    displayMedium = TextStyle(fontSize = 52.sp, fontWeight = FontWeight.Bold, letterSpacing = (-0.25).sp, lineHeight = 60.sp),
    displaySmall = TextStyle(fontSize = 44.sp, fontWeight = FontWeight.Bold, lineHeight = 52.sp),
    headlineLarge = TextStyle(fontSize = 36.sp, fontWeight = FontWeight.Bold, lineHeight = 44.sp),
    headlineMedium = TextStyle(fontSize = 32.sp, fontWeight = FontWeight.SemiBold, lineHeight = 40.sp),
    headlineSmall = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold, lineHeight = 36.sp),
    titleLarge = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold, lineHeight = 32.sp),
    titleMedium = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold, letterSpacing = 0.15.sp, lineHeight = 26.sp),
    titleSmall = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.SemiBold, letterSpacing = 0.1.sp, lineHeight = 24.sp),
    bodyLarge = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Normal, letterSpacing = 0.5.sp, lineHeight = 28.sp),
    bodyMedium = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Normal, letterSpacing = 0.25.sp, lineHeight = 24.sp),
    bodySmall = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, letterSpacing = 0.4.sp, lineHeight = 20.sp),
    labelLarge = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Bold, letterSpacing = 0.1.sp, lineHeight = 24.sp),
    labelMedium = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Bold, letterSpacing = 0.5.sp, lineHeight = 20.sp),
    labelSmall = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Bold, letterSpacing = 0.5.sp, lineHeight = 16.sp)
)
