package com.neostudios.zest.ui.theme

import androidx.compose.animation.core.Spring
import androidx.compose.animation.core.spring

// Material 3 Expressive motion springs
object ExpressiveMotion {
    // Spatial springs for position/size changes
    val spatialSpring = spring<Float>(
        dampingRatio = Spring.DampingRatioMediumBouncy,
        stiffness = Spring.StiffnessMedium
    )
    
    // Effects springs for color/opacity
    val effectsSpring = spring<Float>(
        dampingRatio = Spring.DampingRatioNoBouncy,
        stiffness = Spring.StiffnessMediumLow
    )
    
    // Emphasized spring for hero moments
    val emphasizedSpring = spring<Float>(
        dampingRatio = Spring.DampingRatioLowBouncy,
        stiffness = Spring.StiffnessLow
    )
}
