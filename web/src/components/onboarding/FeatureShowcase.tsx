'use client'

import React, { useState } from 'react'
import { Material3Button } from '@/components/ui/Material3Button'
import { Material3Card } from '@/components/ui/Material3Card'
import { Icon } from '@/components/ui/Icon'

interface FeatureShowcaseProps {
  onSkip: () => void
  onComplete: () => void
}

const features = [
  {
    title: 'Welcome to Zest!',
    description: 'Your ultimate cooking companion. Let\'s explore some key features.',
    icon: 'utensils',
  },
  {
    title: 'Recipe Management',
    description: 'Organize, discover, and create your favorite recipes with ease.',
    icon: 'book',
  },
  {
    title: 'Meal Planning',
    description: 'Plan your meals for the week and generate smart shopping lists.',
    icon: 'calendar',
  },
  {
    title: 'AI Assistant',
    description: 'Get AI-powered recipe suggestions and cooking assistance.',
    icon: 'robot',
  },
]

export function FeatureShowcase({ onSkip, onComplete }: FeatureShowcaseProps) {
  const [currentIndex, setCurrentIndex] = useState(0)

  const handleNext = () => {
    if (currentIndex < features.length - 1) {
      setCurrentIndex(currentIndex + 1)
    } else {
      onComplete()
    }
  }

  const handlePrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1)
    }
  }

  const currentFeature = features[currentIndex]
  const isLastFeature = currentIndex === features.length - 1

  return (
    <div className="fixed inset-0 bg-m3-surface-container z-50 flex flex-col items-center justify-center p-4">
      <Material3Card className="w-full max-w-md p-6 space-y-6 text-center">
        <div className="flex justify-center">
          <Icon name={currentFeature.icon as any} size="4x" className="text-m3-primary-main" />
        </div>
        <h2 className="text-2xl font-bold text-m3-on-surface">
          {currentFeature.title}
        </h2>
        <p className="text-m3-on-surface-variant">
          {currentFeature.description}
        </p>

        <div className="flex justify-between items-center">
          <Material3Button variant="text" onClick={onSkip}>
            Skip
          </Material3Button>
          <div className="flex gap-2">
            <Material3Button variant="outlined" onClick={handlePrevious} disabled={currentIndex === 0}>
              Previous
            </Material3Button>
            <Material3Button variant="filled" onClick={handleNext}>
              {isLastFeature ? 'Get Started' : 'Next'}
            </Material3Button>
          </div>
        </div>
      </Material3Card>
    </div>
  )
}
