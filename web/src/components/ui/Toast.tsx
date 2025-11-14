'use client'

import React, { useEffect, useState } from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'
import { Icon } from './Icon'

interface ToastProps {
  message: string
  type?: 'info' | 'success' | 'warning' | 'error'
  duration?: number
  onClose: () => void
}

export function Toast({ message, type = 'info', duration = 3000, onClose }: ToastProps) {
  const [isVisible, setIsVisible] = useState(true)

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsVisible(false)
      setTimeout(onClose, 300)
    }, duration)

    return () => clearTimeout(timer)
  }, [duration, onClose])

  const typeStyles = {
    info: 'bg-m3-surface-container-high text-m3-on-surface',
    success: 'bg-green-600 text-white',
    warning: 'bg-yellow-600 text-white',
    error: 'bg-m3-error text-m3-on-error',
  }

  const icons = {
    info: 'info' as const,
    success: 'success' as const,
    warning: 'warning' as const,
    error: 'error' as const,
  }

  return (
    <div
      className={`
        fixed bottom-24 md:bottom-8 left-1/2 -translate-x-1/2 z-50
        px-6 py-3 rounded-full shadow-elevation-3
        flex items-center gap-3
        transition-all
        ${typeStyles[type]}
        ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'}
      `}
      style={{
        transitionDuration: expressiveMotion.duration.medium2,
        transitionTimingFunction: expressiveMotion.easing.emphasized,
      }}
    >
      <Icon name={icons[type]} className="text-lg" />
      <span className="font-medium">{message}</span>
      <button
        onClick={() => {
          setIsVisible(false)
          setTimeout(onClose, 300)
        }}
        className="ml-2 p-1 rounded-full hover:bg-black/10 transition-colors"
      >
        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </div>
  )
}
