package com.neostudios.zest.ui.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsPressedAsState
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.scale
import com.neostudios.zest.ui.theme.ExpressiveMotion
import com.neostudios.zest.ui.theme.ExpressiveShapes

@Composable
fun ExpressiveButton(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    content: @Composable () -> Unit
) {
    val interactionSource = remember { MutableInteractionSource() }
    val isPressed by interactionSource.collectIsPressedAsState()
    
    val scale by animateFloatAsState(
        targetValue = if (isPressed) 0.95f else 1f,
        animationSpec = ExpressiveMotion.spatialSpring,
        label = "button_scale"
    )
    
    Button(
        onClick = onClick,
        modifier = modifier.scale(scale),
        shape = ExpressiveShapes.pill,
        interactionSource = interactionSource
    ) {
        content()
    }
}
