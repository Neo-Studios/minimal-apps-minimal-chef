package com.neostudios.zest.util

enum class Language(val code: String, val displayName: String) {
    ENGLISH("en", "English"),
    SPANISH("es", "Español"),
    FRENCH("fr", "Français"),
    GERMAN("de", "Deutsch"),
    JAPANESE("ja", "日本語"),
    CHINESE("zh", "中文"),
    KOREAN("ko", "한국어"),
    PORTUGUESE("pt", "Português"),
    ITALIAN("it", "Italiano"),
    RUSSIAN("ru", "Русский"),
    ARABIC("ar", "العربية"),
    HINDI("hi", "हिन्दी"),
    DUTCH("nl", "Nederlands"),
    SWEDISH("sv", "Svenska"),
    POLISH("pl", "Polski"),
    TURKISH("tr", "Türkçe"),
    VIETNAMESE("vi", "Tiếng Việt"),
    THAI("th", "ไทย"),
    INDONESIAN("id", "Bahasa Indonesia");

    companion object {
        fun fromCode(code: String): Language? = values().find { it.code == code }
    }
}
