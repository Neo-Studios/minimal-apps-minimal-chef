package com.neostudios.zest.ui.utils

import androidx.compose.runtime.*
import kotlinx.coroutines.FlowPreview
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.debounce
import kotlinx.coroutines.flow.distinctUntilChanged

@OptIn(FlowPreview::class)
@Composable
fun <T> rememberDebounced(value: T, delayMillis: Long = 300L): State<T> {
    val flow = remember { MutableStateFlow(value) }
    
    LaunchedEffect(value) {
        flow.value = value
    }
    
    return flow
        .debounce(delayMillis)
        .distinctUntilChanged()
        .collectAsState(initial = value)
}

fun stableKey(id: String, index: Int): String = "$id-$index"
