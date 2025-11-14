'use client'

import React from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'

interface ChipProps {
  label: string
  selected?: boolean
  onClick?: () => void
  onDelete?: () => void
  icon?: React.ReactNode
  variant?: 'filled' | 'outlined' | 'elevated'
  size?: 'small' | 'medium'
  className?: string
}

export function Chip({
  label,
  selected = false,
  onClick,
  onDelete,
  icon,
  variant = 'outlined',
  size = 'medium',
  className = '',
}: ChipProps) {
  const sizeClasses = {
    small: 'px-3 py-1 text-xs',
    medium: 'px-4 py-2 text-sm',
  }

  const variantClasses = {
    filled: selected
      ? 'bg-m3-primary-container text-m3-on-primary-container'
      : 'bg-m3-surface-container-high text-m3-on-surface',
    outlined: selected
      ? 'border-2 border-m3-primary-main bg-m3-primary-container text-m3-on-primary-container'
      : 'border border-m3-outline text-m3-on-surface',
    elevated: selected
      ? 'bg-m3-primary-container text-m3-on-primary-container shadow-elevation-2'
      : 'bg-m3-surface-container text-m3-on-surface shadow-elevation-1',
  }

  return (
    <button
      onClick={onClick}
      className={`
        inline-flex items-center gap-2 rounded-full font-medium
        transition-all hover:shadow-elevation-2 active:scale-95
        ${sizeClasses[size]}
        ${variantClasses[variant]}
        ${onClick ? 'cursor-pointer' : 'cursor-default'}
        ${className}
      `}
      style={{
        transitionDuration: expressiveMotion.duration.short4,
        transitionTimingFunction: expressiveMotion.easing.emphasized,
      }}
    >
      {icon && <span className="flex-shrink-0">{icon}</span>}
      <span>{label}</span>
      {onDelete && (
        <button
          onClick={(e) => {
            e.stopPropagation()
            onDelete()
          }}
          className="flex-shrink-0 p-0.5 rounded-full hover:bg-black/10 transition-colors"
        >
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      )}
    </button>
  )
}
