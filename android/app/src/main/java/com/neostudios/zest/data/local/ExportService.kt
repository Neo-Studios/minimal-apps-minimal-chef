package com.neostudios.zest.data.local

import com.neostudios.zest.domain.model.Recipe
import java.io.ByteArrayOutputStream
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ExportService @Inject constructor() {

    fun exportToPDF(recipe: Recipe): ByteArray {
        // Implementation to export recipe to PDF
        return ByteArray(0)
    }

    fun exportToJSON(recipe: Recipe): String {
        // Implementation to export recipe to JSON
        return ""
    }
}
