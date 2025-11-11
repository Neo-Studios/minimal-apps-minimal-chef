'use client'

import { useEffect, useState } from 'react'
import { useParams } from 'next/navigation'
import { doc, getDoc } from 'firebase/firestore'
import { db } from '@/lib/firebase/config'
import { Recipe } from '@/types/models'

export default function RecipeDetailPage() {
  const params = useParams()
  const [recipe, setRecipe] = useState<Recipe | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchRecipe = async () => {
      const docRef = doc(db, 'recipes', params.id as string)
      const docSnap = await getDoc(docRef)
      if (docSnap.exists()) {
        setRecipe({ id: docSnap.id, ...docSnap.data() } as Recipe)
      }
      setLoading(false)
    }
    fetchRecipe()
  }, [params.id])

  if (loading) return <div className="p-8">Loading...</div>
  if (!recipe) return <div className="p-8">Recipe not found</div>

  return (
    <main className="min-h-screen p-8 pb-24">
      {recipe.imageUrl && (
        <img src={recipe.imageUrl} alt={recipe.name} className="w-full h-64 object-cover rounded-lg mb-6" />
      )}
      <h1 className="text-4xl font-bold mb-4">{recipe.name}</h1>
      <div className="flex gap-4 mb-6 text-sm text-gray-600">
        <span>⏱️ Prep: {recipe.prepTime}m</span>
        <span>🔥 Cook: {recipe.cookTime}m</span>
        <span>🍽️ Servings: {recipe.servings}</span>
      </div>
      
      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Ingredients</h2>
        <ul className="space-y-2">
          {recipe.ingredients.map((ing, i) => (
            <li key={i} className="flex gap-2">
              <span className="font-medium">{ing.amount} {ing.unit}</span>
              <span>{ing.name}</span>
            </li>
          ))}
        </ul>
      </section>

      <section>
        <h2 className="text-2xl font-semibold mb-4">Instructions</h2>
        <ol className="space-y-3">
          {recipe.instructions.map((step, i) => (
            <li key={i} className="flex gap-3">
              <span className="font-bold text-primary">{i + 1}.</span>
              <span>{step}</span>
            </li>
          ))}
        </ol>
      </section>
    </main>
  )
}
