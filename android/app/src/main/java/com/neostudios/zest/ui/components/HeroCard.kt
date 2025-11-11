package com.neostudios.zest.ui.components

import androidx.compose.animation.animateColorAsState
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsPressedAsState
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import com.neostudios.zest.ui.theme.ExpressiveMotion
import com.neostudios.zest.ui.theme.ExpressiveShapes

@Composable
fun HeroCard(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    content: @Composable () -> Unit
) {
    val interactionSource = remember { MutableInteractionSource() }
    val isPressed by interactionSource.collectIsPressedAsState()
    
    val containerColor by animateColorAsState(
        targetValue = if (isPressed) 
            MaterialTheme.colorScheme.primaryContainer 
        else 
            MaterialTheme.colorScheme.surface,
        animationSpec = ExpressiveMotion.effectsSpring,
        label = "hero_color"
    )
    
    Card(
        modifier = modifier.clickable(
            interactionSource = interactionSource,
            indication = null,
            onClick = onClick
        ),
        shape = ExpressiveShapes.heroCard,
        colors = CardDefaults.cardColors(containerColor = containerColor),
        elevation = CardDefaults.cardElevation(defaultElevation = androidx.compose.ui.unit.dp(8))
    ) {
        content()
    }
}
