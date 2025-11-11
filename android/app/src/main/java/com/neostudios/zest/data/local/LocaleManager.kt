package com.neostudios.zest.data.local

import android.content.Context
import java.io.BufferedReader
import java.io.InputStreamReader

object LocaleManager {
    private val translations = mutableMapOf<String, Map<String, String>>()
    
    fun loadLocale(context: Context, locale: String): Map<String, String> {
        if (translations.containsKey(locale)) {
            return translations[locale]!!
        }
        
        val map = mutableMapOf<String, String>()
        try {
            val inputStream = context.assets.open("locales/$locale.lang")
            val reader = BufferedReader(InputStreamReader(inputStream))
            
            reader.forEachLine { line ->
                val trimmed = line.trim()
                if (trimmed.isNotEmpty() && !trimmed.startsWith("#")) {
                    val parts = trimmed.split("=", limit = 2)
                    if (parts.size == 2) {
                        map[parts[0].trim()] = parts[1].trim()
                    }
                }
            }
            reader.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        
        translations[locale] = map
        return map
    }
    
    fun t(translations: Map<String, String>, key: String): String {
        return translations[key] ?: key
    }
}
