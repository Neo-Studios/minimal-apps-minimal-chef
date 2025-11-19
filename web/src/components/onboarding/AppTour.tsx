'use client'

import React from 'react'
import { Material3Button } from '@/components/ui/Material3Button'
import { Material3Card } from '@/components/ui/Material3Card'
import { Icon } from '@/components/ui/Icon'

interface AppTourProps {
  onSkip: () => void
  onComplete: () => void
}

export function AppTour({ onSkip, onComplete }: AppTourProps) {
  return (
    <div className="fixed inset-0 bg-m3-surface-container z-50 flex flex-col items-center justify-center p-4">
      <Material3Card className="w-full max-w-md p-6 space-y-6 text-center">
        <div className="flex justify-center">
          <Icon name="book" size="4x" className="text-m3-primary-main" />
        </div>
        <h2 className="text-2xl font-bold text-m3-on-surface">
          App Tour
        </h2>
        <p className="text-m3-on-surface-variant">
          Let's take a quick tour of the app to show you around!
          (This would be a guided tour with highlights of different UI elements)
        </p>

        <div className="flex justify-between items-center">
          <Material3Button variant="text" onClick={onSkip}>
            Skip Tour
          </Material3Button>
          <Material3Button variant="filled" onClick={onComplete}>
            Start App
          </Material3Button>
        </div>
      </Material3Card>
    </div>
  )
}
