package com.neostudios.zest.ui.theme

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import javax.inject.Inject

enum class ThemeMode {
    LIGHT, DARK, SYSTEM
}

@HiltViewModel
class ThemeViewModel @Inject constructor() : ViewModel() {
    private val _themeMode = MutableStateFlow(ThemeMode.SYSTEM)
    val themeMode: StateFlow<ThemeMode> = _themeMode
    
    fun setTheme(mode: ThemeMode) {
        _themeMode.value = mode
    }
}
