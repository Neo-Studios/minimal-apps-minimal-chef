'use client'

import React from 'react'
import { Material3Card } from './Material3Card'
import { Material3Button } from './Material3Button'

interface EmptyStateProps {
  icon: string
  title: string
  description: string
  actionLabel?: string
  onAction?: () => void
  variant?: 'elevated' | 'filled' | 'outlined'
}

export function EmptyState({
  icon,
  title,
  description,
  actionLabel,
  onAction,
  variant = 'outlined',
}: EmptyStateProps) {
  return (
    <Material3Card variant={variant}>
      <div className="p-12 text-center">
        <span className="text-6xl mb-4 block animate-bounce-slow">{icon}</span>
        <h3 className="text-xl font-medium text-m3-on-surface mb-2">
          {title}
        </h3>
        <p className="text-m3-on-surface-variant mb-4 max-w-md mx-auto">
          {description}
        </p>
        {actionLabel && onAction && (
          <Material3Button variant="tonal" onClick={onAction}>
            {actionLabel}
          </Material3Button>
        )}
      </div>
    </Material3Card>
  )
}
