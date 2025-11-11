'use client'

import { useState, useEffect } from 'react'
import { CookingTimer as Timer } from '@/types/models'
import { timerService } from '@/lib/services/timerService'
import { sendTimerComplete } from '@/lib/services/notificationService'
import { hapticService } from '@/lib/services/hapticService'

export default function CookingTimer() {
  const [timers, setTimers] = useState<Timer[]>([])
  const [newTimerName, setNewTimerName] = useState('')
  const [newTimerDuration, setNewTimerDuration] = useState(10)

  const addTimer = () => {
    const timer: Timer = {
      id: Date.now().toString(),
      name: newTimerName || 'Timer',
      duration: newTimerDuration * 60,
      remainingTime: newTimerDuration * 60,
      isRunning: false
    }
    setTimers([...timers, timer])
    setNewTimerName('')
    setNewTimerDuration(10)
    hapticService.light()
  }

  const startTimer = (id: string) => {
    const timer = timers.find(t => t.id === id)
    if (!timer) return

    timer.isRunning = true
    setTimers([...timers])

    timerService.startTimer(
      timer,
      (updatedTimer) => {
        setTimers(prev => prev.map(t => t.id === id ? updatedTimer : t))
      },
      () => {
        sendTimerComplete(timer.name)
        hapticService.success()
        setTimers(prev => prev.filter(t => t.id !== id))
      }
    )
  }

  const stopTimer = (id: string) => {
    timerService.stopTimer(id)
    setTimers(prev => prev.map(t => t.id === id ? { ...t, isRunning: false } : t))
    hapticService.light()
  }

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60)
    const secs = seconds % 60
    return `${mins}:${secs.toString().padStart(2, '0')}`
  }

  return (
    <div className="space-y-4">
      <div className="flex gap-2">
        <input
          type="text"
          placeholder="Timer name"
          value={newTimerName}
          onChange={(e) => setNewTimerName(e.target.value)}
          className="flex-1 p-2 border rounded-lg"
        />
        <input
          type="number"
          value={newTimerDuration}
          onChange={(e) => setNewTimerDuration(Number(e.target.value))}
          className="w-20 p-2 border rounded-lg"
          min="1"
        />
        <button onClick={addTimer} className="px-4 py-2 bg-orange-500 text-white rounded-lg">
          Add
        </button>
      </div>

      <div className="space-y-2">
        {timers.map(timer => (
          <div key={timer.id} className="flex items-center justify-between p-4 bg-white dark:bg-gray-800 rounded-xl shadow-sm">
            <div>
              <p className="font-medium">{timer.name}</p>
              <p className="text-2xl font-bold">{formatTime(timer.remainingTime)}</p>
            </div>
            <button
              onClick={() => timer.isRunning ? stopTimer(timer.id) : startTimer(timer.id)}
              className={`px-4 py-2 rounded-lg ${timer.isRunning ? 'bg-red-500' : 'bg-green-500'} text-white`}
            >
              {timer.isRunning ? 'Stop' : 'Start'}
            </button>
          </div>
        ))}
      </div>
    </div>
  )
}
