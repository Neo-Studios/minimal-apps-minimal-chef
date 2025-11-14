'use client'

import { useState, useRef } from 'react'
import { processImageForUpload } from '@/lib/utils/imageUtils'
import { Icon } from './Icon'
import Image from 'next/image'

interface ImageUploadProps {
  value?: string
  onChange: (dataUrl: string | undefined) => void
  label?: string
  className?: string
}

export function ImageUpload({ value, onChange, label = 'Upload Image', className = '' }: ImageUploadProps) {
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const handleFileSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    setError(null)
    setUploading(true)

    try {
      const dataUrl = await processImageForUpload(file)
      onChange(dataUrl)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to process image')
      console.error('Image upload error:', err)
    } finally {
      setUploading(false)
    }
  }

  const handleRemove = () => {
    onChange(undefined)
    if (fileInputRef.current) {
      fileInputRef.current.value = ''
    }
  }

  const handleClick = () => {
    fileInputRef.current?.click()
  }

  return (
    <div className={className}>
      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        onChange={handleFileSelect}
        className="hidden"
      />

      {value ? (
        <div className="relative">
          <div className="relative w-full h-64 rounded-lg overflow-hidden bg-gray-100">
            <Image
              src={value}
              alt="Preview"
              fill
              className="object-cover"
            />
          </div>
          <div className="flex gap-2 mt-3">
            <button
              type="button"
              onClick={handleClick}
              disabled={uploading}
              className="flex-1 px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition disabled:opacity-50"
            >
              Change Image
            </button>
            <button
              type="button"
              onClick={handleRemove}
              disabled={uploading}
              className="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600 transition disabled:opacity-50"
            >
              <Icon name="trash" />
            </button>
          </div>
        </div>
      ) : (
        <button
          type="button"
          onClick={handleClick}
          disabled={uploading}
          className="w-full h-64 border-2 border-dashed border-gray-300 rounded-lg hover:border-gray-400 transition flex flex-col items-center justify-center gap-3 bg-gray-50 hover:bg-gray-100 disabled:opacity-50"
        >
          {uploading ? (
            <>
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
              <p className="text-gray-600">Processing image...</p>
            </>
          ) : (
            <>
              <Icon name="utensils" size="3x" className="text-gray-400" />
              <div className="text-center">
                <p className="text-gray-700 font-medium">{label}</p>
                <p className="text-sm text-gray-500 mt-1">Click to select an image</p>
                <p className="text-xs text-gray-400 mt-1">Max 5MB • Will be resized to 800x800</p>
              </div>
            </>
          )}
        </button>
      )}

      {error && (
        <div className="mt-2 p-3 bg-red-50 border border-red-200 rounded-lg flex items-start gap-2">
          <Icon name="error" className="text-red-600 mt-0.5" />
          <p className="text-sm text-red-600">{error}</p>
        </div>
      )}
    </div>
  )
}
