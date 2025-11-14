/**
 * Image utility functions for handling image uploads and conversions
 */

const MAX_IMAGE_SIZE = 1024 * 1024 // 1MB max size
const MAX_WIDTH = 800
const MAX_HEIGHT = 800

/**
 * Convert a File to a base64 data URL
 */
export async function fileToDataURL(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    
    reader.onload = () => {
      if (typeof reader.result === 'string') {
        resolve(reader.result)
      } else {
        reject(new Error('Failed to read file'))
      }
    }
    
    reader.onerror = () => reject(reader.error)
    reader.readAsDataURL(file)
  })
}

/**
 * Resize and compress an image file
 */
export async function resizeImage(file: File, maxWidth = MAX_WIDTH, maxHeight = MAX_HEIGHT): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    
    reader.onload = (e) => {
      const img = new Image()
      
      img.onload = () => {
        // Calculate new dimensions
        let width = img.width
        let height = img.height
        
        if (width > height) {
          if (width > maxWidth) {
            height = (height * maxWidth) / width
            width = maxWidth
          }
        } else {
          if (height > maxHeight) {
            width = (width * maxHeight) / height
            height = maxHeight
          }
        }
        
        // Create canvas and resize
        const canvas = document.createElement('canvas')
        canvas.width = width
        canvas.height = height
        
        const ctx = canvas.getContext('2d')
        if (!ctx) {
          reject(new Error('Failed to get canvas context'))
          return
        }
        
        ctx.drawImage(img, 0, 0, width, height)
        
        // Convert to data URL with compression
        const dataUrl = canvas.toDataURL('image/jpeg', 0.8)
        resolve(dataUrl)
      }
      
      img.onerror = () => reject(new Error('Failed to load image'))
      img.src = e.target?.result as string
    }
    
    reader.onerror = () => reject(reader.error)
    reader.readAsDataURL(file)
  })
}

/**
 * Validate image file
 */
export function validateImageFile(file: File): { valid: boolean; error?: string } {
  // Check file type
  if (!file.type.startsWith('image/')) {
    return { valid: false, error: 'File must be an image' }
  }
  
  // Check file size (before compression)
  if (file.size > MAX_IMAGE_SIZE * 5) { // Allow 5MB before compression
    return { valid: false, error: 'Image must be smaller than 5MB' }
  }
  
  return { valid: true }
}

/**
 * Process image file for upload
 * Validates, resizes, and converts to data URL
 */
export async function processImageForUpload(file: File): Promise<string> {
  // Validate
  const validation = validateImageFile(file)
  if (!validation.valid) {
    throw new Error(validation.error)
  }
  
  // Resize and compress
  const dataUrl = await resizeImage(file)
  
  // Check final size
  const sizeInBytes = (dataUrl.length * 3) / 4 // Approximate size
  if (sizeInBytes > MAX_IMAGE_SIZE) {
    throw new Error('Compressed image is still too large. Try a smaller image.')
  }
  
  return dataUrl
}

/**
 * Get image dimensions from data URL
 */
export async function getImageDimensions(dataUrl: string): Promise<{ width: number; height: number }> {
  return new Promise((resolve, reject) => {
    const img = new Image()
    img.onload = () => resolve({ width: img.width, height: img.height })
    img.onerror = () => reject(new Error('Failed to load image'))
    img.src = dataUrl
  })
}
