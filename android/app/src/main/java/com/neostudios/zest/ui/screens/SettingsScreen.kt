package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.neostudios.zest.ui.theme.ExpressiveShapes
import androidx.compose.ui.res.stringResource
import com.neostudios.zest.R
import com.neostudios.zest.util.Language

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SettingsScreen(
    viewModel: SettingsViewModel = hiltViewModel()
) {
    val themeMode by viewModel.themeMode.collectAsStateWithLifecycle()
    val notifications by viewModel.notifications.collectAsStateWithLifecycle()
    val language by viewModel.language.collectAsStateWithLifecycle()
    val offlineMode by viewModel.offlineMode.collectAsStateWithLifecycle()
    val fontSize by viewModel.fontSize.collectAsStateWithLifecycle()
    val reducedMotion by viewModel.reducedMotion.collectAsStateWithLifecycle()
    val highContrast by viewModel.highContrast.collectAsStateWithLifecycle()
    val colorBlindMode by viewModel.colorBlindMode.collectAsStateWithLifecycle()
    val talkBack by viewModel.talkBack.collectAsStateWithLifecycle()

    var expandedLanguageMenu by remember { mutableStateOf(false) }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(16.dp)
    ) {
        Text(
            text = stringResource(R.string.settings_title),
            style = MaterialTheme.typography.headlineLarge,
            modifier = Modifier.padding(bottom = 24.dp)
        )
        
        // General
        SettingsSection(title = stringResource(R.string.settings_general)) {
            SettingsItem(
                icon = Icons.Default.Palette,
                title = stringResource(R.string.settings_theme),
                subtitle = themeMode,
                onClick = { /* Show theme picker */ }
            )
            SettingsItem(
                icon = Icons.Default.Language,
                title = stringResource(R.string.settings_language),
                subtitle = language.displayName,
                onClick = { expandedLanguageMenu = true }
            )
            DropdownMenu(
                expanded = expandedLanguageMenu,
                onDismissRequest = { expandedLanguageMenu = false }
            ) {
                Language.values().forEach { lang ->
                    DropdownMenuItem(
                        text = { Text(lang.displayName) },
                        onClick = {
                            viewModel.setLanguage(lang)
                            expandedLanguageMenu = false
                        }
                    )
                }
            }
            SettingsItem(
                icon = Icons.Default.Notifications,
                title = stringResource(R.string.settings_notifications),
                trailing = {
                    Switch(checked = notifications, onCheckedChange = { viewModel.setNotifications(it) })
                }
            )
            SettingsItem(
                icon = Icons.Default.CloudOff,
                title = stringResource(R.string.settings_offline_mode),
                subtitle = stringResource(R.string.settings_offline_mode_subtitle),
                trailing = {
                    Switch(checked = offlineMode, onCheckedChange = { viewModel.setOfflineMode(it) })
                }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Accessibility
        SettingsSection(title = stringResource(R.string.settings_accessibility)) {
            SettingsItem(
                icon = Icons.Default.TextFields,
                title = stringResource(R.string.settings_font_size),
                subtitle = fontSize,
                onClick = { /* Show font size picker */ }
            )
            SettingsItem(
                icon = Icons.Default.Animation,
                title = stringResource(R.string.settings_reduce_motion),
                subtitle = stringResource(R.string.settings_reduce_motion_subtitle),
                trailing = {
                    Switch(checked = reducedMotion, onCheckedChange = { viewModel.setReducedMotion(it) })
                }
            )
            SettingsItem(
                icon = Icons.Default.Contrast,
                title = stringResource(R.string.settings_high_contrast),
                subtitle = stringResource(R.string.settings_high_contrast_subtitle),
                trailing = {
                    Switch(checked = highContrast, onCheckedChange = { viewModel.setHighContrast(it) })
                }
            )
            SettingsItem(
                icon = Icons.Default.Palette,
                title = stringResource(R.string.settings_color_blind_mode),
                subtitle = colorBlindMode,
                onClick = { /* Show color blind mode picker */ }
            )
            SettingsItem(
                icon = Icons.Default.RecordVoiceOver,
                title = stringResource(R.string.settings_talk_back_support),
                subtitle = stringResource(R.string.settings_talk_back_support_subtitle),
                trailing = {
                    Switch(checked = talkBack, onCheckedChange = { viewModel.setTalkBack(it) })
                }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Account
        SettingsSection(title = stringResource(R.string.settings_account)) {
            SettingsItem(
                icon = Icons.Default.Person,
                title = stringResource(R.string.settings_profile),
                subtitle = "user@example.com", // TODO: Replace with actual user email
                onClick = { /* Navigate to profile */ }
            )
            SettingsItem(
                icon = Icons.Default.ExitToApp,
                title = stringResource(R.string.settings_sign_out),
                onClick = { /* Sign out */ }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // About
        SettingsSection(title = stringResource(R.string.settings_about)) {
            SettingsItem(
                icon = Icons.Default.Info,
                title = stringResource(R.string.settings_version),
                subtitle = "2.0.0" // TODO: Get actual version
            )
            SettingsItem(
                icon = Icons.Default.Code,
                title = stringResource(R.string.settings_developer),
                subtitle = "Neo Studios"
            )
            SettingsItem(
                icon = Icons.Default.Description,
                title = stringResource(R.string.settings_license),
                subtitle = "Neo Studios Public Repository License"
            )
        }
    }
}

@Composable
fun SettingsSection(
    title: String,
    content: @Composable ColumnScope.() -> Unit
) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = ExpressiveShapes.large
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleLarge,
                modifier = Modifier.padding(bottom = 12.dp)
            )
            content()
        }
    }
}

@Composable
fun SettingsItem(
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    title: String,
    subtitle: String? = null,
    trailing: @Composable (() -> Unit)? = null,
    onClick: (() -> Unit)? = null
) {
    Surface(
        onClick = onClick ?: {},
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.width(16.dp))
            Column(modifier = Modifier.weight(1f)) {
                Text(text = title, style = MaterialTheme.typography.bodyLarge)
                if (subtitle != null) {
                    Text(
                        text = subtitle,
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
            if (trailing != null) {
                trailing()
            }
        }
    }
}
