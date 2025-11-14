'use client'

import React from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'

interface Material3ButtonProps {
  children: React.ReactNode
  variant?: 'filled' | 'outlined' | 'text' | 'elevated' | 'tonal'
  size?: 'small' | 'medium' | 'large'
  icon?: React.ReactNode
  onClick?: () => void
  disabled?: boolean
  className?: string
}

export function Material3Button({
  children,
  variant = 'filled',
  size = 'medium',
  icon,
  onClick,
  disabled = false,
  className = '',
}: Material3ButtonProps) {
  const baseClasses = 'inline-flex items-center justify-center gap-2 font-medium transition-all rounded-full'
  
  const sizeClasses = {
    small: 'px-4 py-2 text-sm',
    medium: 'px-6 py-3 text-base',
    large: 'px-8 py-4 text-lg',
  }
  
  const variantClasses = {
    filled: 'bg-m3-primary-main text-m3-on-primary shadow-elevation-1 hover:shadow-elevation-2 active:shadow-elevation-1',
    outlined: 'border-2 border-m3-outline-main text-m3-primary-main hover:bg-m3-primary-main/10',
    text: 'text-m3-primary-main hover:bg-m3-primary-main/10',
    elevated: 'bg-m3-surface-container text-m3-primary-main shadow-elevation-2 hover:shadow-elevation-3',
    tonal: 'bg-m3-primary-container text-m3-on-primary-container hover:shadow-elevation-1',
  }
  
  const disabledClasses = disabled
    ? 'opacity-40 cursor-not-allowed pointer-events-none'
    : 'cursor-pointer active:scale-95'
  
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`${baseClasses} ${sizeClasses[size]} ${variantClasses[variant]} ${disabledClasses} ${className}`}
      style={{
        transitionDuration: expressiveMotion.duration.short4,
        transitionTimingFunction: expressiveMotion.easing.emphasized,
      }}
    >
      {icon && <span className="flex-shrink-0">{icon}</span>}
      {children}
    </button>
  )
}
