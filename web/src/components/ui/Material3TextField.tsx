'use client'

import React, { useState } from 'react'
import { expressiveMotion } from '@/lib/design/material3-expressive'

interface Material3TextFieldProps {
  label: string
  value: string
  onChange: (value: string) => void
  type?: 'text' | 'email' | 'password' | 'number'
  placeholder?: string
  helperText?: string
  error?: boolean
  disabled?: boolean
  icon?: React.ReactNode
  className?: string
}

export function Material3TextField({
  label,
  value,
  onChange,
  type = 'text',
  placeholder,
  helperText,
  error = false,
  disabled = false,
  icon,
  className = '',
}: Material3TextFieldProps) {
  const [isFocused, setIsFocused] = useState(false)
  
  const containerClasses = `
    relative flex items-center gap-3 px-4 py-3 rounded-lg
    border-2 transition-all
    ${error 
      ? 'border-m3-error bg-m3-error-container/10' 
      : isFocused 
        ? 'border-m3-primary-main bg-m3-primary-container/20' 
        : 'border-m3-outline-variant bg-m3-surface-container'
    }
    ${disabled ? 'opacity-50 cursor-not-allowed' : ''}
  `
  
  return (
    <div className={`flex flex-col gap-1 ${className}`}>
      <label className="text-sm font-medium text-m3-on-surface-variant px-1">
        {label}
      </label>
      <div
        className={containerClasses}
        style={{
          transitionDuration: expressiveMotion.duration.short4,
          transitionTimingFunction: expressiveMotion.easing.emphasized,
        }}
      >
        {icon && (
          <span className={`flex-shrink-0 ${error ? 'text-m3-error' : 'text-m3-on-surface-variant'}`}>
            {icon}
          </span>
        )}
        <input
          type={type}
          value={value}
          onChange={(e) => onChange(e.target.value)}
          onFocus={() => setIsFocused(true)}
          onBlur={() => setIsFocused(false)}
          placeholder={placeholder}
          disabled={disabled}
          className="flex-1 bg-transparent outline-none text-m3-on-surface placeholder:text-m3-on-surface-variant/60"
        />
      </div>
      {helperText && (
        <p className={`text-xs px-4 ${error ? 'text-m3-error' : 'text-m3-on-surface-variant'}`}>
          {helperText}
        </p>
      )}
    </div>
  )
}
