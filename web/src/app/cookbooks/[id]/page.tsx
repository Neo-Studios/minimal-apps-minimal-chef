'use client'

import { useEffect, useState } from 'react'
import { useParams, useRouter } from 'next/navigation'
import { useAuth } from '@/lib/hooks/useAuth'
import { getCookbook, Cookbook } from '@/lib/firebase/cookbooks'
import { getRecipe, Recipe } from '@/lib/firebase/recipes'
import { useCookbookStore } from '@/lib/stores/cookbookStore'
import Link from 'next/link'
import Image from 'next/image'

export default function CookbookDetailPage() {
  const params = useParams()
  const router = useRouter()
  const { updateCookbook, removeRecipe } = useCookbookStore()
  const [cookbook, setCookbook] = useState<Cookbook | null>(null)
  const [recipes, setRecipes] = useState<Recipe[]>([])
  const [loading, setLoading] = useState(true)
  const [isEditing, setIsEditing] = useState(false)
  const [editName, setEditName] = useState('')
  const [editDescription, setEditDescription] = useState('')

  useEffect(() => {
    loadCookbook()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [params.id])

  const loadCookbook = async () => {
    if (!params.id || typeof params.id !== 'string') return
    
    try {
      const cookbookData = await getCookbook(params.id)
      if (cookbookData) {
        setCookbook(cookbookData)
        setEditName(cookbookData.name)
        setEditDescription(cookbookData.description || '')
        
        const recipePromises = cookbookData.recipeIds.map(id => getRecipe(id))
        const recipesData = await Promise.all(recipePromises)
        setRecipes(recipesData.filter(r => r !== null) as Recipe[])
      }
    } catch (error) {
      console.error('Failed to load cookbook:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleSaveEdit = async () => {
    if (!cookbook?.id) return
    
    try {
      await updateCookbook(cookbook.id, {
        name: editName,
        description: editDescription
      })
      setCookbook({ ...cookbook, name: editName, description: editDescription })
      setIsEditing(false)
    } catch (error) {
      console.error('Failed to update cookbook:', error)
    }
  }

  const handleRemoveRecipe = async (recipeId: string) => {
    if (!cookbook?.id) return
    
    if (confirm('Remove this recipe from the cookbook?')) {
      try {
        await removeRecipe(cookbook.id, recipeId)
        setRecipes(recipes.filter(r => r.id !== recipeId))
      } catch (error) {
        console.error('Failed to remove recipe:', error)
      }
    }
  }

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto"></div>
        </div>
      </div>
    )
  }

  if (!cookbook) {
    return (
      <div className="container mx-auto px-4 py-8">
        <p className="text-center text-gray-600">Cookbook not found.</p>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <button
        onClick={() => router.back()}
        className="mb-4 text-primary hover:underline"
      >
        ← Back to Cookbooks
      </button>

      <div className="bg-white rounded-lg shadow-md p-6 mb-8">
        {isEditing ? (
          <div className="space-y-4">
            <input
              type="text"
              value={editName}
              onChange={(e) => setEditName(e.target.value)}
              className="w-full text-3xl font-bold px-3 py-2 border rounded-lg focus:ring-2 focus:ring-primary"
            />
            <textarea
              value={editDescription}
              onChange={(e) => setEditDescription(e.target.value)}
              className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-primary"
              rows={3}
              placeholder="Description..."
            />
            <div className="flex gap-3">
              <button
                onClick={handleSaveEdit}
                className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition"
              >
                Save
              </button>
              <button
                onClick={() => setIsEditing(false)}
                className="bg-gray-200 text-gray-800 px-4 py-2 rounded-lg hover:bg-gray-300 transition"
              >
                Cancel
              </button>
            </div>
          </div>
        ) : (
          <>
            <div className="flex justify-between items-start mb-4">
              <h1 className="text-3xl font-bold">{cookbook.name}</h1>
              <button
                onClick={() => setIsEditing(true)}
                className="text-primary hover:underline"
              >
                Edit
              </button>
            </div>
            {cookbook.description && (
              <p className="text-gray-600 mb-4">{cookbook.description}</p>
            )}
            <p className="text-sm text-gray-500">{recipes.length} recipes</p>
          </>
        )}
      </div>

      {recipes.length === 0 ? (
        <div className="text-center py-12">
          <p className="text-gray-600 mb-4">No recipes in this cookbook yet.</p>
          <Link href="/recipes" className="text-primary hover:underline">
            Browse recipes to add
          </Link>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {recipes.map((recipe) => (
            <div key={recipe.id} className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition">
              {recipe.imageUrl && (
                <div className="relative w-full h-48">
                  <Image 
                    src={recipe.imageUrl} 
                    alt={recipe.name} 
                    fill
                    className="object-cover"
                  />
                </div>
              )}
              <div className="p-4">
                <Link href={`/recipes/${recipe.id}`}>
                  <h3 className="text-xl font-semibold mb-2 hover:text-primary transition">
                    {recipe.name}
                  </h3>
                </Link>
                {recipe.description && (
                  <p className="text-gray-600 text-sm mb-3 line-clamp-2">{recipe.description}</p>
                )}
                <div className="flex justify-between items-center text-sm text-gray-500">
                  <span>{(recipe.prepTime || 0) + (recipe.cookTime || 0)} min</span>
                  <button
                    onClick={() => recipe.id && handleRemoveRecipe(recipe.id)}
                    className="text-red-600 hover:text-red-800 transition"
                  >
                    Remove
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
