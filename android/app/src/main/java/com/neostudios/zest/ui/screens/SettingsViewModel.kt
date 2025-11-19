package com.neostudios.zest.ui.screens

import android.app.Application
import android.content.Context
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.neostudios.zest.util.Language
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SettingsViewModel @Inject constructor(
    application: Application
) : AndroidViewModel(application) {

    private val preferences = application.getSharedPreferences("settings_prefs", Context.MODE_PRIVATE)

    private val _language = MutableStateFlow(
        Language.fromCode(preferences.getString("language", Language.ENGLISH.code) ?: Language.ENGLISH.code) ?: Language.ENGLISH
    )
    val language: StateFlow<Language> = _language

    private val _themeMode = MutableStateFlow(preferences.getString("theme_mode", "System") ?: "System")
    val themeMode: StateFlow<String> = _themeMode

    private val _notifications = MutableStateFlow(preferences.getBoolean("notifications", true))
    val notifications: StateFlow<Boolean> = _notifications

    private val _offlineMode = MutableStateFlow(preferences.getBoolean("offline_mode", true))
    val offlineMode: StateFlow<Boolean> = _offlineMode

    private val _fontSize = MutableStateFlow(preferences.getString("font_size", "Medium") ?: "Medium")
    val fontSize: StateFlow<String> = _fontSize

    private val _reducedMotion = MutableStateFlow(preferences.getBoolean("reduced_motion", false))
    val reducedMotion: StateFlow<Boolean> = _reducedMotion

    private val _highContrast = MutableStateFlow(preferences.getBoolean("high_contrast", false))
    val highContrast: StateFlow<Boolean> = _highContrast

    private val _colorBlindMode = MutableStateFlow(preferences.getString("color_blind_mode", "None") ?: "None")
    val colorBlindMode: StateFlow<String> = _colorBlindMode

    private val _talkBack = MutableStateFlow(preferences.getBoolean("talk_back", false))
    val talkBack: StateFlow<Boolean> = _talkBack

    private val _enableAI = MutableStateFlow(preferences.getBoolean("enable_ai", true))
    val enableAI: StateFlow<Boolean> = _enableAI

    fun setLanguage(newLanguage: Language) {
        viewModelScope.launch {
            _language.value = newLanguage
            preferences.edit().putString("language", newLanguage.code).apply()
        }
    }

    fun setThemeMode(newThemeMode: String) {
        viewModelScope.launch {
            _themeMode.value = newThemeMode
            preferences.edit().putString("theme_mode", newThemeMode).apply()
        }
    }

    fun setNotifications(enabled: Boolean) {
        viewModelScope.launch {
            _notifications.value = enabled
            preferences.edit().putBoolean("notifications", enabled).apply()
        }
    }

    fun setOfflineMode(enabled: Boolean) {
        viewModelScope.launch {
            _offlineMode.value = enabled
            preferences.edit().putBoolean("offline_mode", enabled).apply()
        }
    }

    fun setFontSize(newFontSize: String) {
        viewModelScope.launch {
            _fontSize.value = newFontSize
            preferences.edit().putString("font_size", newFontSize).apply()
        }
    }

    fun setReducedMotion(enabled: Boolean) {
        viewModelScope.launch {
            _reducedMotion.value = enabled
            preferences.edit().putBoolean("reduced_motion", enabled).apply()
        }
    }

    fun setHighContrast(enabled: Boolean) {
        viewModelScope.launch {
            _highContrast.value = enabled
            preferences.edit().putBoolean("high_contrast", enabled).apply()
        }
    }

    fun setColorBlindMode(newColorBlindMode: String) {
        viewModelScope.launch {
            _colorBlindMode.value = newColorBlindMode
            preferences.edit().putString("color_blind_mode", newColorBlindMode).apply()
        }
    }

    fun setTalkBack(enabled: Boolean) {
        viewModelScope.launch {
            _talkBack.value = enabled
            preferences.edit().putBoolean("talk_back", enabled).apply()
        }
    }

    fun setEnableAI(enabled: Boolean) {
        viewModelScope.launch {
            _enableAI.value = enabled
            preferences.edit().putBoolean("enable_ai", enabled).apply()
        }
    }
}
