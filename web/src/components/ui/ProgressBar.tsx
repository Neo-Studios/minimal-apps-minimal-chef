'use client'

import React from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'

interface ProgressBarProps {
  value: number
  max?: number
  label?: string
  showPercentage?: boolean
  color?: 'primary' | 'secondary' | 'tertiary' | 'error'
  size?: 'small' | 'medium' | 'large'
  className?: string
}

export function ProgressBar({
  value,
  max = 100,
  label,
  showPercentage = false,
  color = 'primary',
  size = 'medium',
  className = '',
}: ProgressBarProps) {
  const percentage = Math.min((value / max) * 100, 100)
  
  const colorClasses = {
    primary: 'bg-m3-primary-main',
    secondary: 'bg-m3-secondary-main',
    tertiary: 'bg-m3-tertiary-main',
    error: 'bg-m3-error',
  }

  const sizeClasses = {
    small: 'h-1',
    medium: 'h-2',
    large: 'h-3',
  }

  return (
    <div className={`space-y-1 ${className}`}>
      {(label || showPercentage) && (
        <div className="flex items-center justify-between text-sm">
          {label && <span className="text-m3-on-surface-variant">{label}</span>}
          {showPercentage && (
            <span className="text-m3-on-surface font-medium">
              {Math.round(percentage)}%
            </span>
          )}
        </div>
      )}
      <div className={`w-full bg-m3-surface-container-high rounded-full overflow-hidden ${sizeClasses[size]}`}>
        <div
          className={`h-full rounded-full transition-all ${colorClasses[color]}`}
          style={{
            width: `${percentage}%`,
            transitionDuration: expressiveMotion.duration.medium2,
            transitionTimingFunction: expressiveMotion.easing.emphasized,
          }}
        />
      </div>
    </div>
  )
}
