package com.neostudios.zest.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Stop
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay

@Composable
fun CookingTimerCard(
    name: String,
    durationSeconds: Int,
    onComplete: () -> Unit
) {
    var remainingTime by remember { mutableStateOf(durationSeconds) }
    var isRunning by remember { mutableStateOf(false) }
    
    LaunchedEffect(isRunning) {
        while (isRunning && remainingTime > 0) {
            delay(1000)
            remainingTime--
            if (remainingTime == 0) {
                onComplete()
                isRunning = false
            }
        }
    }
    
    Card(
        modifier = Modifier.fillMaxWidth(),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column {
                Text(text = name, style = MaterialTheme.typography.titleMedium)
                Text(
                    text = "${remainingTime / 60}:${(remainingTime % 60).toString().padStart(2, '0')}",
                    style = MaterialTheme.typography.headlineMedium
                )
            }
            
            IconButton(onClick = { isRunning = !isRunning }) {
                Icon(
                    imageVector = if (isRunning) Icons.Default.Stop else Icons.Default.PlayArrow,
                    contentDescription = if (isRunning) "Stop" else "Start"
                )
            }
        }
    }
}
