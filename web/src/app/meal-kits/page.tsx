'use client'

import { useEffect, useState } from 'react'
import { getMealKits } from '@/lib/firebase/mealKits'
import { MealKit } from '@/types/mealKit'
import { Icon } from '@/components/ui/Icon'
import Image from 'next/image'
import Link from 'next/link'

export default function MealKitsPage() {
  const [mealKits, setMealKits] = useState<MealKit[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchMealKits = async () => {
      try {
        const fetchedMealKits = await getMealKits()
        setMealKits(fetchedMealKits)
      } catch (err) {
        console.error('Error fetching meal kits:', err)
        setError('Failed to load meal kits.')
      } finally {
        setLoading(false)
      }
    }
    fetchMealKits()
  }, [])

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading meal kits...</p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center p-8">
        <div className="text-center">
          <Icon name="utensils" size="6x" className="mb-4 mx-auto text-gray-400" />
          <h2 className="text-2xl font-bold mb-2">Error</h2>
          <p className="text-gray-600 mb-4">{error}</p>
        </div>
      </div>
    )
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-4xl font-bold mb-8">Meal Kits</h1>

      {mealKits.length === 0 ? (
        <div className="text-center py-12">
          <Icon name="box" size="6x" className="mb-4 mx-auto text-gray-400" />
          <p className="text-gray-600 text-xl">No meal kits available right now.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {mealKits.map((mealKit) => (
            <Link href={`/meal-kits/${mealKit.id}`} key={mealKit.id} className="block">
              <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden">
                <div className="relative w-full h-48">
                  <Image
                    src={mealKit.imageUrl}
                    alt={mealKit.name}
                    fill
                    className="object-cover"
                  />
                </div>
                <div className="p-6">
                  <h2 className="text-2xl font-semibold mb-2">{mealKit.name}</h2>
                  <p className="text-gray-600 dark:text-gray-400 mb-4 line-clamp-2">{mealKit.description}</p>
                  <div className="flex justify-between items-center">
                    <span className="text-primary text-xl font-bold">${mealKit.price.toFixed(2)}</span>
                    <span className="text-sm text-gray-500">Available: {mealKit.availableDates.length} dates</span>
                  </div>
                </div>
              </div>
            </Link>
          ))}
        </div>
      )}
    </main>
  )
}
