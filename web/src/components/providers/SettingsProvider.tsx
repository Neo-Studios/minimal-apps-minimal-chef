'use client'

import { useEffect } from 'react'
import { useSettingsStore } from '@/lib/stores/settingsStore'

export function SettingsProvider({ children }: { children: React.ReactNode }) {
  const {
    fontSize,
    reducedMotion,
    highContrast,
    colorBlindMode,
    screenReader,
  } = useSettingsStore()

  useEffect(() => {
    const root = window.document.documentElement

    // Apply font size
    root.classList.remove('text-sm', 'text-base', 'text-lg', 'text-xl')
    const fontSizeMap = {
      small: 'text-sm',
      medium: 'text-base',
      large: 'text-lg',
      xlarge: 'text-xl',
    }
    root.classList.add(fontSizeMap[fontSize])

    // Apply reduced motion
    if (reducedMotion) {
      root.style.setProperty('--motion-duration', '0.01ms')
      root.classList.add('reduce-motion')
    } else {
      root.style.removeProperty('--motion-duration')
      root.classList.remove('reduce-motion')
    }

    // Apply high contrast
    if (highContrast) {
      root.classList.add('high-contrast')
    } else {
      root.classList.remove('high-contrast')
    }

    // Apply color blind mode
    root.classList.remove('protanopia', 'deuteranopia', 'tritanopia')
    if (colorBlindMode !== 'none') {
      root.classList.add(colorBlindMode)
    }

    // Apply screen reader optimizations
    if (screenReader) {
      root.classList.add('screen-reader-optimized')
    } else {
      root.classList.remove('screen-reader-optimized')
    }
  }, [fontSize, reducedMotion, highContrast, colorBlindMode, screenReader])

  return <>{children}</>
}
