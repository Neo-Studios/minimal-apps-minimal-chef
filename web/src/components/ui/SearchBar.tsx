'use client'

import React, { useState } from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'

interface SearchBarProps {
  value: string
  onChange: (value: string) => void
  placeholder?: string
  onFocus?: () => void
  onBlur?: () => void
  className?: string
}

export function SearchBar({
  value,
  onChange,
  placeholder = 'Search...',
  onFocus,
  onBlur,
  className = '',
}: SearchBarProps) {
  const [isFocused, setIsFocused] = useState(false)

  return (
    <div
      className={`
        relative flex items-center gap-3 px-4 py-3 rounded-full
        transition-all
        ${isFocused 
          ? 'bg-m3-surface-container-high shadow-elevation-2' 
          : 'bg-m3-surface-container shadow-elevation-1'
        }
        ${className}
      `}
      style={{
        transitionDuration: expressiveMotion.duration.short4,
        transitionTimingFunction: expressiveMotion.easing.emphasized,
      }}
    >
      <svg
        className={`w-5 h-5 transition-colors ${
          isFocused ? 'text-m3-primary-main' : 'text-m3-on-surface-variant'
        }`}
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
        />
      </svg>
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        onFocus={() => {
          setIsFocused(true)
          onFocus?.()
        }}
        onBlur={() => {
          setIsFocused(false)
          onBlur?.()
        }}
        placeholder={placeholder}
        className="flex-1 bg-transparent outline-none text-m3-on-surface placeholder:text-m3-on-surface-variant"
      />
      {value && (
        <button
          onClick={() => onChange('')}
          className="p-1 rounded-full hover:bg-m3-on-surface/10 transition-colors"
        >
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      )}
    </div>
  )
}
