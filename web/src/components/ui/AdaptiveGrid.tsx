'use client'

import { ReactNode } from 'react'

interface AdaptiveGridProps {
  children: ReactNode
  minItemWidth?: number
  gap?: number
  className?: string
}

export default function AdaptiveGrid({
  children,
  minItemWidth = 300,
  gap = 16,
  className = ''
}: AdaptiveGridProps) {
  return (
    <div
      className={`grid ${className}`}
      style={{
        gridTemplateColumns: `repeat(auto-fill, minmax(${minItemWidth}px, 1fr))`,
        gap: `${gap}px`
      }}
    >
      {children}
    </div>
  )
}
