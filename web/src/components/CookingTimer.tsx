'use client'

import { useState, useEffect } from 'react'

interface Timer {
  id: string
  name: string
  duration: number
  remaining: number
  isRunning: boolean
}

export default function CookingTimer() {
  const [timers, setTimers] = useState<Timer[]>([])

  useEffect(() => {
    const interval = setInterval(() => {
      setTimers((prev) =>
        prev.map((timer) => {
          if (timer.isRunning && timer.remaining > 0) {
            return { ...timer, remaining: timer.remaining - 1 }
          }
          return timer
        })
      )
    }, 1000)

    return () => clearInterval(interval)
  }, [])

  const addTimer = (name: string, duration: number) => {
    const newTimer: Timer = {
      id: Date.now().toString(),
      name,
      duration,
      remaining: duration,
      isRunning: false,
    }
    setTimers([...timers, newTimer])
  }

  const toggleTimer = (id: string) => {
    setTimers((prev) =>
      prev.map((timer) =>
        timer.id === id ? { ...timer, isRunning: !timer.isRunning } : timer
      )
    )
  }

  const resetTimer = (id: string) => {
    setTimers((prev) =>
      prev.map((timer) =>
        timer.id === id
          ? { ...timer, remaining: timer.duration, isRunning: false }
          : timer
      )
    )
  }

  const deleteTimer = (id: string) => {
    setTimers((prev) => prev.filter((timer) => timer.id !== id))
  }

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60)
    const secs = seconds % 60
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
  }

  return (
    <div className="space-y-4">
      <div className="flex gap-2">
        <button
          onClick={() => addTimer('Timer', 300)}
          className="bg-m3-primary-main text-m3-on-primary px-4 py-2 rounded-lg"
        >
          Add 5 Min Timer
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {timers.map((timer) => (
          <div
            key={timer.id}
            className="bg-m3-surface-container p-4 rounded-lg shadow-elevation-2"
          >
            <h3 className="font-semibold mb-2">{timer.name}</h3>
            <div className="text-3xl font-bold mb-4">{formatTime(timer.remaining)}</div>
            <div className="flex gap-2">
              <button
                onClick={() => toggleTimer(timer.id)}
                className="flex-1 bg-m3-primary-main text-m3-on-primary px-3 py-2 rounded-lg"
              >
                {timer.isRunning ? 'Pause' : 'Start'}
              </button>
              <button
                onClick={() => resetTimer(timer.id)}
                className="px-3 py-2 bg-m3-secondary-main text-m3-on-secondary rounded-lg"
              >
                Reset
              </button>
              <button
                onClick={() => deleteTimer(timer.id)}
                className="px-3 py-2 bg-m3-error text-m3-on-error rounded-lg"
              >
                Delete
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
