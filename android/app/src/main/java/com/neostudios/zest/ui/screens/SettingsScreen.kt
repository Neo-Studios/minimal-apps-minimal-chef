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
import com.neostudios.zest.ui.theme.ExpressiveShapes

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SettingsScreen() {
    var themeMode by remember { mutableStateOf("Automatic") }
    var notifications by remember { mutableStateOf(true) }
    var language by remember { mutableStateOf("English") }
    var offlineMode by remember { mutableStateOf(true) }
    var fontSize by remember { mutableStateOf("Medium") }
    var reducedMotion by remember { mutableStateOf(false) }
    var highContrast by remember { mutableStateOf(false) }
    var colorBlindMode by remember { mutableStateOf("None") }
    var talkBack by remember { mutableStateOf(false) }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(16.dp)
    ) {
        Text(
            text = "Settings",
            style = MaterialTheme.typography.headlineLarge,
            modifier = Modifier.padding(bottom = 24.dp)
        )
        
        // General
        SettingsSection(title = "General") {
            SettingsItem(
                icon = Icons.Default.Palette,
                title = "Theme",
                subtitle = themeMode,
                onClick = { /* Show theme picker */ }
            )
            SettingsItem(
                icon = Icons.Default.Language,
                title = "Language",
                subtitle = language,
                onClick = { /* Show language picker */ }
            )
            SettingsItem(
                icon = Icons.Default.Notifications,
                title = "Notifications",
                trailing = {
                    Switch(checked = notifications, onCheckedChange = { notifications = it })
                }
            )
            SettingsItem(
                icon = Icons.Default.CloudOff,
                title = "Offline Mode",
                subtitle = "Enable offline access",
                trailing = {
                    Switch(checked = offlineMode, onCheckedChange = { offlineMode = it })
                }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Accessibility
        SettingsSection(title = "Accessibility") {
            SettingsItem(
                icon = Icons.Default.TextFields,
                title = "Font Size",
                subtitle = fontSize,
                onClick = { /* Show font size picker */ }
            )
            SettingsItem(
                icon = Icons.Default.Animation,
                title = "Reduce Motion",
                subtitle = "Minimize animations",
                trailing = {
                    Switch(checked = reducedMotion, onCheckedChange = { reducedMotion = it })
                }
            )
            SettingsItem(
                icon = Icons.Default.Contrast,
                title = "High Contrast",
                subtitle = "Increase text contrast",
                trailing = {
                    Switch(checked = highContrast, onCheckedChange = { highContrast = it })
                }
            )
            SettingsItem(
                icon = Icons.Default.Palette,
                title = "Color Blind Mode",
                subtitle = colorBlindMode,
                onClick = { /* Show color blind mode picker */ }
            )
            SettingsItem(
                icon = Icons.Default.RecordVoiceOver,
                title = "TalkBack Support",
                subtitle = "Optimize for screen readers",
                trailing = {
                    Switch(checked = talkBack, onCheckedChange = { talkBack = it })
                }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Account
        SettingsSection(title = "Account") {
            SettingsItem(
                icon = Icons.Default.Person,
                title = "Profile",
                subtitle = "user@example.com",
                onClick = { /* Navigate to profile */ }
            )
            SettingsItem(
                icon = Icons.Default.ExitToApp,
                title = "Sign Out",
                onClick = { /* Sign out */ }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // About
        SettingsSection(title = "About") {
            SettingsItem(
                icon = Icons.Default.Info,
                title = "Version",
                subtitle = "2.0.0"
            )
            SettingsItem(
                icon = Icons.Default.Code,
                title = "Developer",
                subtitle = "Neo Studios"
            )
            SettingsItem(
                icon = Icons.Default.Description,
                title = "License",
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
