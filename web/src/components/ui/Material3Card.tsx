'use client'

import React from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'

interface Material3CardProps {
  children: React.ReactNode
  variant?: 'elevated' | 'filled' | 'outlined'
  interactive?: boolean
  onClick?: () => void
  className?: string
}

export function Material3Card({
  children,
  variant = 'elevated',
  interactive = false,
  onClick,
  className = '',
}: Material3CardProps) {
  const baseClasses = 'rounded-xl overflow-hidden transition-all'
  
  const variantClasses = {
    elevated: 'bg-m3-surface-container shadow-elevation-1 hover:shadow-elevation-2',
    filled: 'bg-m3-surface-container-highest',
    outlined: 'border border-m3-outline-variant bg-m3-surface',
  }
  
  const interactiveClasses = interactive
    ? 'cursor-pointer hover:scale-[1.02] active:scale-[0.98]'
    : ''
  
  return (
    <div
      onClick={onClick}
      className={`${baseClasses} ${variantClasses[variant]} ${interactiveClasses} ${className}`}
      style={{
        transitionDuration: expressiveMotion.duration.medium2,
        transitionTimingFunction: expressiveMotion.easing.emphasized,
      }}
    >
      {children}
    </div>
  )
}
