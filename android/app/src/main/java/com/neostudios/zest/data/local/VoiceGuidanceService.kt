package com.neostudios.zest.data.local

import android.content.Context
import android.speech.tts.TextToSpeech
import java.util.Locale
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class VoiceGuidanceService @Inject constructor(
    private val context: Context
) : TextToSpeech.OnInitListener {

    private val tts: TextToSpeech = TextToSpeech(context, this)

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts.language = Locale.US
        }
    }

    fun speak(text: String) {
        tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, null)
    }

    fun shutdown() {
        tts.stop()
        tts.shutdown()
    }
}
