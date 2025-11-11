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
fun ExpressiveFAB(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    icon: @Composable () -> Unit
) {
    val interactionSource = remember { MutableInteractionSource() }
    val isPressed by interactionSource.collectIsPressedAsState()
    
    val scale by animateFloatAsState(
        targetValue = if (isPressed) 0.9f else 1f,
        animationSpec = ExpressiveMotion.emphasizedSpring,
        label = "fab_scale"
    )
    
    FloatingActionButton(
        onClick = onClick,
        modifier = modifier.scale(scale),
        shape = ExpressiveShapes.circular,
        containerColor = MaterialTheme.colorScheme.primaryContainer,
        contentColor = MaterialTheme.colorScheme.onPrimaryContainer,
        interactionSource = interactionSource
    ) {
        icon()
    }
}
