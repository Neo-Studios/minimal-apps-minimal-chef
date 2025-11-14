'use client'

import React, { useState, useEffect } from 'react'
import { Material3Card } from '@/components/ui/Material3Card'
import { Material3Button } from '@/components/ui/Material3Button'
import { Material3TextField } from '@/components/ui/Material3TextField'
import { Material3FAB } from '@/components/ui/Material3FAB'
import { useIsTablet } from '@/lib/hooks/useMediaQuery'
import { Icon } from '@/components/ui/Icon'

interface Timer {
  id: string
  name: string
  duration: number
  remaining: number
  isRunning: boolean
}

const PRESET_TIMERS = [
  { name: 'Pasta', minutes: 10 },
  { name: 'Rice', minutes: 20 },
  { name: 'Eggs', minutes: 7 },
  { name: 'Steak', minutes: 15 },
]

export default function TimersPage() {
  const [timers, setTimers] = useState<Timer[]>([])
  const [newTimerName, setNewTimerName] = useState('')
  const [newTimerMinutes, setNewTimerMinutes] = useState('10')
  const [showAddForm, setShowAddForm] = useState(false)
  const isTablet = useIsTablet()

  // Request notification permission on mount
  useEffect(() => {
    if ('Notification' in window && Notification.permission === 'default') {
      Notification.requestPermission()
    }
  }, [])

  useEffect(() => {
    const interval = setInterval(() => {
      setTimers((prev) =>
        prev.map((timer) => {
          if (timer.isRunning && timer.remaining > 0) {
            const newRemaining = timer.remaining - 1
            if (newRemaining === 0) {
              // Timer finished - play notification
              if ('Notification' in window && Notification.permission === 'granted') {
                new Notification('Timer Complete!', {
                  body: `${timer.name} is done!`,
                })
              }
            }
            return { ...timer, remaining: newRemaining }
          }
          return timer
        })
      )
    }, 1000)

    return () => clearInterval(interval)
  }, [])

  const addTimer = () => {
    if (!newTimerName || !newTimerMinutes) return
    
    const duration = parseInt(newTimerMinutes) * 60
    const newTimer: Timer = {
      id: Date.now().toString(),
      name: newTimerName,
      duration,
      remaining: duration,
      isRunning: false,
    }
    
    setTimers([...timers, newTimer])
    setNewTimerName('')
    setNewTimerMinutes('10')
    setShowAddForm(false)
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

  const addPresetTimer = (preset: typeof PRESET_TIMERS[0]) => {
    const duration = preset.minutes * 60
    const newTimer: Timer = {
      id: Date.now().toString(),
      name: preset.name,
      duration,
      remaining: duration,
      isRunning: false,
    }
    setTimers([...timers, newTimer])
  }

  return (
    <div className="p-4 md:p-8 space-y-6 pb-24 md:pb-8">
      {/* Header */}
      <div className="flex items-center justify-between flex-wrap gap-4">
        <div>
          <h1 className="text-4xl font-normal text-m3-on-surface mb-2">
            Cooking Timers
          </h1>
          <p className="text-m3-on-surface-variant">
            Manage multiple timers for your cooking
          </p>
        </div>
        {isTablet && (
          <Material3Button
            variant="filled"
            onClick={() => setShowAddForm(!showAddForm)}
            icon={
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
              </svg>
            }
          >
            New Timer
          </Material3Button>
        )}
      </div>

      {/* Quick presets */}
      {timers.length === 0 && !showAddForm && (
        <div className="flex flex-wrap gap-2">
          <span className="text-sm text-m3-on-surface-variant">Quick start:</span>
          {PRESET_TIMERS.map((preset) => (
            <Material3Button
              key={preset.name}
              variant="tonal"
              size="small"
              onClick={() => addPresetTimer(preset)}
            >
              {preset.name} ({preset.minutes}m)
            </Material3Button>
          ))}
        </div>
      )}

      {/* Add timer form */}
      {showAddForm && (
        <Material3Card variant="elevated">
          <div className="p-6 space-y-4">
            <h2 className="text-xl font-semibold text-m3-on-surface">
              Create New Timer
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Material3TextField
                label="Timer Name"
                value={newTimerName}
                onChange={setNewTimerName}
                placeholder="e.g., Pasta"
              />
              <Material3TextField
                label="Duration (minutes)"
                value={newTimerMinutes}
                onChange={setNewTimerMinutes}
                type="number"
                placeholder="10"
              />
            </div>
            <div className="flex gap-2">
              <Material3Button variant="filled" onClick={addTimer}>
                Add Timer
              </Material3Button>
              <Material3Button variant="text" onClick={() => setShowAddForm(false)}>
                Cancel
              </Material3Button>
            </div>
          </div>
        </Material3Card>
      )}

      {/* Timers grid */}
      {timers.length === 0 && !showAddForm ? (
        <Material3Card variant="outlined">
          <div className="p-12 text-center">
            <Icon name="clock" size="6x" className="mb-4 block mx-auto" />
            <h3 className="text-xl font-medium text-m3-on-surface mb-2">
              No timers yet
            </h3>
            <p className="text-m3-on-surface-variant mb-4">
              Create your first cooking timer to get started
            </p>
            <Material3Button variant="tonal" onClick={() => setShowAddForm(true)}>
              Create Timer
            </Material3Button>
          </div>
        </Material3Card>
      ) : timers.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {timers.map((timer) => {
            const percentage = (timer.remaining / timer.duration) * 100
            const isFinished = timer.remaining === 0
            
            return (
              <Material3Card key={timer.id} variant="elevated">
                <div className="p-6 space-y-4">
                  <div className="flex items-center justify-between">
                    <h3 className="text-xl font-semibold text-m3-on-surface">
                      {timer.name}
                    </h3>
                    <button
                      onClick={() => deleteTimer(timer.id)}
                      className="text-m3-error hover:bg-m3-error-container/20 p-2 rounded-lg transition-colors"
                    >
                      <Icon name="trash" />
                    </button>
                  </div>

                  {/* Circular progress */}
                  <div className="relative w-32 h-32 mx-auto">
                    <svg className="w-full h-full transform -rotate-90">
                      <circle
                        cx="64"
                        cy="64"
                        r="56"
                        stroke="currentColor"
                        strokeWidth="8"
                        fill="none"
                        className="text-m3-surface-container-high"
                      />
                      <circle
                        cx="64"
                        cy="64"
                        r="56"
                        stroke="currentColor"
                        strokeWidth="8"
                        fill="none"
                        strokeDasharray={`${2 * Math.PI * 56}`}
                        strokeDashoffset={`${2 * Math.PI * 56 * (1 - percentage / 100)}`}
                        className={`transition-all ${
                          isFinished
                            ? 'text-m3-error'
                            : timer.isRunning
                            ? 'text-m3-primary-main'
                            : 'text-m3-secondary-main'
                        }`}
                        strokeLinecap="round"
                      />
                    </svg>
                    <div className="absolute inset-0 flex items-center justify-center">
                      <span className="text-3xl font-bold text-m3-on-surface">
                        {formatTime(timer.remaining)}
                      </span>
                    </div>
                  </div>

                  {/* Controls */}
                  <div className="flex gap-2">
                    <Material3Button
                      variant={timer.isRunning ? 'outlined' : 'filled'}
                      size="small"
                      onClick={() => toggleTimer(timer.id)}
                      className="flex-1"
                      disabled={isFinished}
                    >
                      {timer.isRunning ? 'Pause' : 'Start'}
                    </Material3Button>
                    <Material3Button
                      variant="outlined"
                      size="small"
                      onClick={() => resetTimer(timer.id)}
                    >
                      Reset
                    </Material3Button>
                  </div>
                </div>
              </Material3Card>
            )
          })}
        </div>
      ) : null}

      {/* Floating Action Button (Mobile only) */}
      {!isTablet && (
        <div className="fixed bottom-20 right-4 z-10">
          <Material3FAB
            icon={
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
              </svg>
            }
            onClick={() => setShowAddForm(true)}
          />
        </div>
      )}
    </div>
  )
}
