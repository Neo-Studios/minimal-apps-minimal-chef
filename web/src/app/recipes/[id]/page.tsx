'use client'

import { useEffect, useState } from 'react'
import { useParams, useRouter } from 'next/navigation'
import { getRecipe, deleteRecipe, updateRecipe, Recipe } from '@/lib/firebase/recipes'
import { useAuth } from '@/lib/hooks/useAuth'
import { useCookbookStore } from '@/lib/stores/cookbookStore'
import Image from 'next/image'
import { Icon } from '@/components/ui/Icon'
import { StarRating } from '@/components/ui/StarRating'

export default function RecipeDetailPage() {
  const params = useParams()
  const router = useRouter()
  const { user } = useAuth()
  const { cookbooks, fetchCookbooks, addRecipe } = useCookbookStore()
  const [recipe, setRecipe] = useState<Recipe | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [servingMultiplier, setServingMultiplier] = useState(1)
  const [showCookbookDialog, setShowCookbookDialog] = useState(false)

  useEffect(() => {
    const fetchRecipe = async () => {
      try {
        if (!params.id) {
          setError('No recipe ID provided')
          setLoading(false)
          return
        }
        const recipeData = await getRecipe(params.id as string)
        if (recipeData) {
          setRecipe(recipeData)
        } else {
          setError('Recipe not found')
        }
      } catch (err) {
        console.error('Error fetching recipe:', err)
        setError('Failed to load recipe')
      } finally {
        setLoading(false)
      }
    }
    fetchRecipe()
  }, [params.id])

  useEffect(() => {
    if (user) {
      fetchCookbooks(user.uid)
    }
  }, [user, fetchCookbooks])

  const handleAddToCookbook = async (cookbookId: string) => {
    if (!recipe?.id) return
    try {
      await addRecipe(cookbookId, recipe.id)
      setShowCookbookDialog(false)
      alert('Recipe added to cookbook!')
    } catch (error) {
      console.error('Failed to add recipe to cookbook:', error)
    }
  }

  const handleDelete = async () => {
    if (!recipe?.id) return
    
    if (!confirm(`Are you sure you want to delete "${recipe.name}"? This action cannot be undone.`)) {
      return
    }
    
    try {
      const success = await deleteRecipe(recipe.id)
      if (success) {
        router.push('/recipes')
      } else {
        alert('Failed to delete recipe')
      }
    } catch (error) {
      console.error('Failed to delete recipe:', error)
      alert('Failed to delete recipe')
    }
  }

  const handleRating = async (rating: number) => {
    if (!recipe?.id) return
    
    try {
      const success = await updateRecipe(recipe.id, { rating })
      if (success) {
        setRecipe({ ...recipe, rating })
      }
    } catch (error) {
      console.error('Failed to update rating:', error)
    }
  }

  const scaleAmount = (amount: number) => {
    return (amount * servingMultiplier).toFixed(2).replace(/\.?0+$/, '')
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading recipe...</p>
        </div>
      </div>
    )
  }
  
  if (error || !recipe) {
    return (
      <div className="min-h-screen flex items-center justify-center p-8">
        <div className="text-center">
          <Icon name="utensils" size="6x" className="mb-4 mx-auto text-gray-400" />
          <h2 className="text-2xl font-bold mb-2">{error || 'Recipe not found'}</h2>
          <p className="text-gray-600 mb-4">The recipe you're looking for doesn't exist or couldn't be loaded.</p>
          <a href="/recipes" className="text-primary hover:underline">← Back to Recipes</a>
        </div>
      </div>
    )
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      {recipe.imageUrl && (
        <div className="relative w-full h-64 rounded-lg overflow-hidden mb-6">
          <Image 
            src={recipe.imageUrl} 
            alt={recipe.name} 
            fill
            className="object-cover"
          />
        </div>
      )}
      <div className="flex justify-between items-start mb-4">
        <h1 className="text-4xl font-bold">{recipe.name}</h1>
        {user && (
          <div className="flex gap-2">
            {recipe.userId === user.uid && (
              <>
                <button
                  onClick={() => router.push(`/recipes/${recipe.id}/edit`)}
                  className="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition flex items-center gap-2"
                >
                  <Icon name="settings" />
                  Edit
                </button>
                <button
                  onClick={handleDelete}
                  className="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 transition flex items-center gap-2"
                >
                  <Icon name="trash" />
                  Delete
                </button>
              </>
            )}
            <button
              onClick={() => setShowCookbookDialog(true)}
              className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition"
            >
              Add to Cookbook
            </button>
          </div>
        )}
      </div>
      <div className="flex gap-4 mb-4 text-sm text-gray-600">
        <span className="flex items-center gap-1"><Icon name="clock" /> Prep: {recipe.prepTime}m</span>
        <span className="flex items-center gap-1"><Icon name="fire" /> Cook: {recipe.cookTime}m</span>
        <span className="flex items-center gap-1"><Icon name="utensils" /> Servings: {recipe.servings}</span>
      </div>

      {/* Rating */}
      <div className="mb-6">
        <label className="block text-sm font-medium mb-2">Rate this recipe:</label>
        <StarRating
          value={recipe.rating || 0}
          onChange={handleRating}
          readonly={!user || recipe.userId !== user.uid}
          size="lg"
        />
      </div>

      <div className="mb-6 bg-gray-100 p-4 rounded-lg">
        <label className="block text-sm font-medium mb-2">Scale Recipe</label>
        <div className="flex items-center gap-4">
          <button
            onClick={() => setServingMultiplier(Math.max(0.5, servingMultiplier - 0.5))}
            className="bg-white px-3 py-1 rounded border hover:bg-gray-50"
          >
            -
          </button>
          <span className="font-semibold">
            {Math.round(recipe.servings * servingMultiplier)} servings (×{servingMultiplier})
          </span>
          <button
            onClick={() => setServingMultiplier(servingMultiplier + 0.5)}
            className="bg-white px-3 py-1 rounded border hover:bg-gray-50"
          >
            +
          </button>
          <button
            onClick={() => setServingMultiplier(1)}
            className="text-primary hover:underline text-sm"
          >
            Reset
          </button>
        </div>
      </div>
      
      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Ingredients</h2>
        <ul className="space-y-2">
          {recipe.ingredients.map((ing, i) => (
            <li key={i} className="flex gap-2">
              <span className="font-medium">{scaleAmount(ing.amount)} {ing.unit}</span>
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

      {showCookbookDialog && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <h2 className="text-2xl font-bold mb-4">Add to Cookbook</h2>
            {cookbooks.length === 0 ? (
              <p className="text-gray-600 mb-4">You don't have any cookbooks yet. Create one first!</p>
            ) : (
              <div className="space-y-2 mb-4">
                {cookbooks.map((cookbook) => (
                  <button
                    key={cookbook.id}
                    onClick={() => cookbook.id && handleAddToCookbook(cookbook.id)}
                    className="w-full text-left p-3 border rounded-lg hover:bg-gray-50 transition"
                  >
                    <div className="font-semibold">{cookbook.name}</div>
                    <div className="text-sm text-gray-600">{cookbook.recipeIds.length} recipes</div>
                  </button>
                ))}
              </div>
            )}
            <button
              onClick={() => setShowCookbookDialog(false)}
              className="w-full bg-gray-200 text-gray-800 px-4 py-2 rounded-lg hover:bg-gray-300 transition"
            >
              Cancel
            </button>
          </div>
        </div>
      )}
    </main>
  )
}
