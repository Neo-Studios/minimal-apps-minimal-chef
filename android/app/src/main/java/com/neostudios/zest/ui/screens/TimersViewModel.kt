package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.neostudios.zest.data.local.CookingTimer
import com.neostudios.zest.data.local.TimerService
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class TimersViewModel @Inject constructor(
    private val timerService: TimerService
) : ViewModel() {

    val timers: StateFlow<List<CookingTimer>> = timerService.timers

    fun addTimer(name: String, durationSeconds: Int, recipeId: String? = null) {
        timerService.addTimer(name, durationSeconds, recipeId)
    }

    fun startTimer(timerId: String) {
        timerService.startTimer(timerId)
    }

    fun pauseTimer(timerId: String) {
        timerService.pauseTimer(timerId)
    }

    fun resetTimer(timerId: String) {
        timerService.resetTimer(timerId)
    }

    fun deleteTimer(timerId: String) {
        timerService.deleteTimer(timerId)
    }

    override fun onCleared() {
        super.onCleared()
        timerService.cleanup()
    }
}
