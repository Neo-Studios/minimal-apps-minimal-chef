package com.neostudios.zest.data.local

import android.content.Context
import android.os.CountDownTimer
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import java.util.UUID
import javax.inject.Inject
import javax.inject.Singleton

data class CookingTimer(
    val id: String = UUID.randomUUID().toString(),
    val name: String,
    val durationSeconds: Int,
    val remainingSeconds: Int,
    val isRunning: Boolean = false,
    val recipeId: String? = null
)

@Singleton
class TimerService @Inject constructor(
    @ApplicationContext private val context: Context
) {
    private val _timers = MutableStateFlow<List<CookingTimer>>(emptyList())
    val timers: StateFlow<List<CookingTimer>> = _timers.asStateFlow()
    
    private val activeTimers = mutableMapOf<String, CountDownTimer>()

    fun addTimer(name: String, durationSeconds: Int, recipeId: String? = null) {
        val timer = CookingTimer(
            name = name,
            durationSeconds = durationSeconds,
            remainingSeconds = durationSeconds,
            recipeId = recipeId
        )
        _timers.value = _timers.value + timer
    }

    fun startTimer(timerId: String) {
        val timer = _timers.value.find { it.id == timerId } ?: return
        if (timer.isRunning) return

        val countDownTimer = object : CountDownTimer(
            timer.remainingSeconds * 1000L,
            1000
        ) {
            override fun onTick(millisUntilFinished: Long) {
                val remainingSeconds = (millisUntilFinished / 1000).toInt()
                updateTimer(timerId) { it.copy(remainingSeconds = remainingSeconds) }
            }

            override fun onFinish() {
                updateTimer(timerId) { it.copy(remainingSeconds = 0, isRunning = false) }
                NotificationHelper.sendTimerComplete(context, timer.name)
                activeTimers.remove(timerId)
            }
        }

        countDownTimer.start()
        activeTimers[timerId] = countDownTimer
        updateTimer(timerId) { it.copy(isRunning = true) }
    }

    fun pauseTimer(timerId: String) {
        activeTimers[timerId]?.cancel()
        activeTimers.remove(timerId)
        updateTimer(timerId) { it.copy(isRunning = false) }
    }

    fun resetTimer(timerId: String) {
        activeTimers[timerId]?.cancel()
        activeTimers.remove(timerId)
        updateTimer(timerId) { 
            it.copy(
                remainingSeconds = it.durationSeconds,
                isRunning = false
            )
        }
    }

    fun deleteTimer(timerId: String) {
        activeTimers[timerId]?.cancel()
        activeTimers.remove(timerId)
        _timers.value = _timers.value.filter { it.id != timerId }
    }

    private fun updateTimer(timerId: String, update: (CookingTimer) -> CookingTimer) {
        _timers.value = _timers.value.map { timer ->
            if (timer.id == timerId) update(timer) else timer
        }
    }

    fun cleanup() {
        activeTimers.values.forEach { it.cancel() }
        activeTimers.clear()
    }
}
