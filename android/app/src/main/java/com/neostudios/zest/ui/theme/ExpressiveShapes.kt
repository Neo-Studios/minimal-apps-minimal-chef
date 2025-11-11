package com.neostudios.zest.ui.theme

import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.CutCornerShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.unit.dp

// Material 3 Expressive shape library - variety for visual interest
object ExpressiveShapes {
    // Standard rounded shapes
    val roundedSmall: Shape = RoundedCornerShape(12.dp)
    val roundedMedium: Shape = RoundedCornerShape(16.dp)
    val roundedLarge: Shape = RoundedCornerShape(24.dp)
    val roundedExtraLarge: Shape = RoundedCornerShape(32.dp)
    
    // Asymmetric shapes for emphasis
    val heroCard: Shape = RoundedCornerShape(
        topStart = 32.dp,
        topEnd = 8.dp,
        bottomEnd = 32.dp,
        bottomStart = 8.dp
    )
    
    // Mixed corner styles for visual tension
    val accentShape: Shape = CutCornerShape(
        topStart = 0.dp,
        topEnd = 16.dp,
        bottomEnd = 0.dp,
        bottomStart = 16.dp
    )
    
    // Full circle for FABs and avatars
    val circular: Shape = CircleShape
    
    // Pill shape for buttons
    val pill: Shape = RoundedCornerShape(50)
}
