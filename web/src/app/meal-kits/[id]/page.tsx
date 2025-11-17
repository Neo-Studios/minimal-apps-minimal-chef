'use client'

import { useEffect, useState } from 'react'
import { useParams } from 'next/navigation'
import { getMealKit } from '@/lib/firebase/mealKits'
import { MealKit } from '@/types/mealKit'
import { Icon } from '@/components/ui/Icon'
import Image from 'next/image'
import Link from 'next/link'

export default function MealKitDetailPage() {
  const params = useParams()
  const [mealKit, setMealKit] = useState<MealKit | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchMealKit = async () => {
      try {
        if (!params.id) {
          setError('No meal kit ID provided.')
          setLoading(false)
          return
        }
        const fetchedMealKit = await getMealKit(params.id as string)
        if (fetchedMealKit) {
          setMealKit(fetchedMealKit)
        } else {
          setError('Meal kit not found.')
        }
      } catch (err) {
        console.error('Error fetching meal kit:', err)
        setError('Failed to load meal kit.')
      } finally {
        setLoading(false)
      }
    }
    fetchMealKit()
  }, [params.id])

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading meal kit...</p>
        </div>
      </div>
    )
  }

  if (error || !mealKit) {
    return (
      <div className="min-h-screen flex items-center justify-center p-8">
        <div className="text-center">
          <Icon name="box" size="6x" className="mb-4 mx-auto text-gray-400" />
          <h2 className="text-2xl font-bold mb-2">{error || 'Meal kit not found'}</h2>
          <p className="text-gray-600 mb-4">The meal kit you're looking for doesn't exist or couldn't be loaded.</p>
          <Link href="/meal-kits" className="text-primary hover:underline">← Back to Meal Kits</Link>
        </div>
      </div>
    )
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      {mealKit.imageUrl && (
        <div className="relative w-full h-64 rounded-lg overflow-hidden mb-6">
          <Image
            src={mealKit.imageUrl}
            alt={mealKit.name}
            fill
            className="object-cover"
          />
        </div>
      )}
      <h1 className="text-4xl font-bold mb-4">{mealKit.name}</h1>
      <p className="text-gray-700 dark:text-gray-300 text-lg mb-6">{mealKit.description}</p>

      <div className="flex items-center justify-between bg-gray-100 dark:bg-gray-800 p-4 rounded-lg mb-6">
        <span className="text-primary text-3xl font-bold">${mealKit.price.toFixed(2)}</span>
        <button className="bg-primary text-white px-6 py-3 rounded-lg text-lg font-semibold hover:bg-primary/90 transition">
          Add to Cart
        </button>
      </div>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Recipes Included</h2>
        <div className="space-y-4">
          {mealKit.recipes.map((mealKitRecipe, index) => (
            <div key={index} className="bg-white dark:bg-gray-800 p-4 rounded-lg shadow-sm">
              <p className="text-xl font-medium">{mealKitRecipe.recipeId} (Servings: {mealKitRecipe.servings})</p>
              {/* In a real app, you'd fetch recipe details here */}
            </div>
          ))}
        </div>
      </section>

      <section>
        <h2 className="text-2xl font-semibold mb-4">Available Dates</h2>
        <div className="flex flex-wrap gap-2">
          {mealKit.availableDates.map((date, index) => (
            <span key={index} className="bg-blue-100 text-blue-800 text-sm font-medium px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-100">
              {new Date(date).toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' })}
            </span>
          ))}
        </div>
      </section>
    </main>
  )
}
