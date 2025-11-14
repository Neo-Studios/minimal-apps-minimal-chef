'use client'

import { Icon } from '@/components/ui/Icon'

export default function AIRecipeGeneratorPage() {
  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-3xl font-bold mb-6">AI Recipe Generator</h1>

      <div className="bg-blue-50 dark:bg-blue-900/20 rounded-2xl p-8 text-center">
        <Icon name="mobile" size="6x" className="mb-4 mx-auto" />
        <h2 className="text-2xl font-bold mb-4">AI Features Available on Mobile</h2>
        <p className="text-gray-600 dark:text-gray-300 mb-6">
          On-device AI recipe generation is available exclusively on mobile apps with supported devices:
        </p>
        <div className="space-y-2 text-left max-w-md mx-auto mb-6">
          <div className="flex items-center gap-2">
            <span className="text-green-500">✓</span>
            <span>Google Pixel 8+ (Gemini Nano)</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-green-500">✓</span>
            <span>Samsung Galaxy S23+, S24 series</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-green-500">✓</span>
            <span>iPhone 15 Pro+, iPhone 16 series</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-green-500">✓</span>
            <span>Xiaomi 14, OPPO Find X7, OnePlus 12</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-green-500">✓</span>
            <span>Any Snapdragon 8 Gen 3 device</span>
          </div>
        </div>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          Download the Android or iOS app to access AI-powered recipe generation, ingredient analysis, and cooking assistance.
        </p>
      </div>
    </main>
  )
}
