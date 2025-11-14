'use client'

import React from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'

interface Material3FABProps {
  icon: React.ReactNode
  label?: string
  onClick: () => void
  extended?: boolean
  size?: 'small' | 'medium' | 'large'
  className?: string
}

export function Material3FAB({
  icon,
  label,
  onClick,
  extended = false,
  size = 'medium',
  className = '',
}: Material3FABProps) {
  const sizeClasses = {
    small: 'w-10 h-10',
    medium: 'w-14 h-14',
    large: 'w-24 h-24',
  }

  return (
    <button
      onClick={onClick}
      className={`
        ${extended ? 'px-6 h-14' : sizeClasses[size]}
        bg-m3-primary-container text-m3-on-primary-container
        rounded-full shadow-elevation-3 hover:shadow-elevation-4
        flex items-center justify-center gap-2
        transition-all active:scale-95
        ${className}
      `}
      style={{
        transitionDuration: expressiveMotion.duration.short4,
        transitionTimingFunction: expressiveMotion.easing.emphasized,
      }}
    >
      <span className="flex-shrink-0">{icon}</span>
      {extended && label && (
        <span className="font-medium whitespace-nowrap">{label}</span>
      )}
    </button>
  )
}
