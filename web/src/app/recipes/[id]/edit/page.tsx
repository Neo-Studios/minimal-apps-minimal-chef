'use client'

import { useState, useEffect } from 'react'
import { useRouter, useParams } from 'next/navigation'
import { useAuth } from '@/lib/hooks/useAuth'
import { getRecipe, updateRecipe, Ingredient } from '@/lib/firebase/recipes'
import { ImageUpload } from '@/components/ui/ImageUpload'
import { Icon } from '@/components/ui/Icon'

export default function EditRecipePage() {
  const router = useRouter()
  const params = useParams()
  const { user } = useAuth()
  
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [name, setName] = useState('')
  const [cuisine, setCuisine] = useState('')
  const [description, setDescription] = useState('')
  const [prepTime, setPrepTime] = useState(0)
  const [cookTime, setCookTime] = useState(0)
  const [servings, setServings] = useState(1)
  const [difficulty, setDifficulty] = useState<'Easy' | 'Medium' | 'Hard'>('Medium')
  const [imageUrl, setImageUrl] = useState<string | undefined>(undefined)
  const [ingredients, setIngredients] = useState<Ingredient[]>([{ name: '', amount: 0, unit: '' }])
  const [instructions, setInstructions] = useState([''])

  useEffect(() => {
    const loadRecipe = async () => {
      if (!params.id) return
      
      const recipe = await getRecipe(params.id as string)
      if (!recipe) {
        alert('Recipe not found')
        router.push('/recipes')
        return
      }
      
      // Check if user owns this recipe
      if (recipe.userId !== user?.uid) {
        alert('You can only edit your own recipes')
        router.push('/recipes')
        return
      }
      
      // Populate form
      setName(recipe.name)
      setCuisine(recipe.cuisine)
      setDescription(recipe.description || '')
      setPrepTime(recipe.prepTime)
      setCookTime(recipe.cookTime)
      setServings(recipe.servings)
      setDifficulty(recipe.difficulty)
      setImageUrl(recipe.imageUrl)
      setIngredients(recipe.ingredients.length > 0 ? recipe.ingredients : [{ name: '', amount: 0, unit: '' }])
      setInstructions(recipe.instructions.length > 0 ? recipe.instructions : [''])
      setLoading(false)
    }
    
    if (user) {
      loadRecipe()
    }
  }, [params.id, user, router])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!user || !params.id) return

    setSaving(true)
    try {
      const success = await updateRecipe(params.id as string, {
        name,
        description,
        cuisine,
        prepTime,
        cookTime,
        servings,
        difficulty,
        imageUrl,
        ingredients: ingredients.filter(i => i.name),
        instructions: instructions.filter(i => i),
      })
      
      if (success) {
        router.push(`/recipes/${params.id}`)
      } else {
        alert('Failed to update recipe')
      }
    } catch (error) {
      console.error('Error updating recipe:', error)
      alert('Failed to update recipe')
    } finally {
      setSaving(false)
    }
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

  return (
    <main className="min-h-screen p-8 pb-24">
      <div className="max-w-2xl">
        <div className="flex items-center gap-4 mb-6">
          <button
            onClick={() => router.back()}
            className="p-2 hover:bg-gray-100 rounded-lg transition"
          >
            <Icon name="utensils" />
          </button>
          <h1 className="text-3xl font-bold">Edit Recipe</h1>
        </div>
        
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            placeholder="Recipe Name"
            value={name}
            onChange={(e) => setName(e.target.value)}
            className="w-full p-3 border rounded-lg"
            required
          />
          
          <textarea
            placeholder="Description (optional)"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            className="w-full p-3 border rounded-lg"
            rows={3}
          />
          
          <ImageUpload
            value={imageUrl}
            onChange={setImageUrl}
            label="Recipe Image"
          />
          
          <input
            type="text"
            placeholder="Cuisine Type (e.g., Italian, Mexican)"
            value={cuisine}
            onChange={(e) => setCuisine(e.target.value)}
            className="w-full p-3 border rounded-lg"
            required
          />
          
          <div>
            <label className="block text-sm font-medium mb-2">Difficulty</label>
            <select
              value={difficulty}
              onChange={(e) => setDifficulty(e.target.value as 'Easy' | 'Medium' | 'Hard')}
              className="w-full p-3 border rounded-lg"
            >
              <option value="Easy">Easy</option>
              <option value="Medium">Medium</option>
              <option value="Hard">Hard</option>
            </select>
          </div>
          
          <div className="grid grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium mb-2">Prep Time (min)</label>
              <input
                type="number"
                value={prepTime}
                onChange={(e) => setPrepTime(Number(e.target.value))}
                className="w-full p-3 border rounded-lg"
                min="0"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">Cook Time (min)</label>
              <input
                type="number"
                value={cookTime}
                onChange={(e) => setCookTime(Number(e.target.value))}
                className="w-full p-3 border rounded-lg"
                min="0"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">Servings</label>
              <input
                type="number"
                value={servings}
                onChange={(e) => setServings(Number(e.target.value))}
                className="w-full p-3 border rounded-lg"
                min="1"
              />
            </div>
          </div>
          
          <h3 className="text-xl font-semibold mt-6">Ingredients</h3>
          {ingredients.map((ing, i) => (
            <div key={i} className="grid grid-cols-[1fr_1fr_2fr_auto] gap-2">
              <input
                type="number"
                placeholder="Amount"
                value={ing.amount || ''}
                onChange={(e) => {
                  const newIng = [...ingredients]
                  newIng[i].amount = Number(e.target.value)
                  setIngredients(newIng)
                }}
                className="p-2 border rounded"
                step="0.01"
              />
              <input
                placeholder="Unit"
                value={ing.unit}
                onChange={(e) => {
                  const newIng = [...ingredients]
                  newIng[i].unit = e.target.value
                  setIngredients(newIng)
                }}
                className="p-2 border rounded"
              />
              <input
                placeholder="Ingredient"
                value={ing.name}
                onChange={(e) => {
                  const newIng = [...ingredients]
                  newIng[i].name = e.target.value
                  setIngredients(newIng)
                }}
                className="p-2 border rounded"
              />
              {ingredients.length > 1 && (
                <button
                  type="button"
                  onClick={() => setIngredients(ingredients.filter((_, idx) => idx !== i))}
                  className="p-2 text-red-500 hover:bg-red-50 rounded"
                >
                  <Icon name="trash" />
                </button>
              )}
            </div>
          ))}
          <button
            type="button"
            onClick={() => setIngredients([...ingredients, { name: '', amount: 0, unit: '' }])}
            className="text-primary hover:underline"
          >
            + Add Ingredient
          </button>

          <h3 className="text-xl font-semibold mt-6">Instructions</h3>
          {instructions.map((step, i) => (
            <div key={i} className="flex gap-2">
              <textarea
                placeholder={`Step ${i + 1}`}
                value={step}
                onChange={(e) => {
                  const newSteps = [...instructions]
                  newSteps[i] = e.target.value
                  setInstructions(newSteps)
                }}
                className="flex-1 p-3 border rounded-lg"
                rows={2}
              />
              {instructions.length > 1 && (
                <button
                  type="button"
                  onClick={() => setInstructions(instructions.filter((_, idx) => idx !== i))}
                  className="p-2 text-red-500 hover:bg-red-50 rounded h-fit"
                >
                  <Icon name="trash" />
                </button>
              )}
            </div>
          ))}
          <button
            type="button"
            onClick={() => setInstructions([...instructions, ''])}
            className="text-primary hover:underline"
          >
            + Add Step
          </button>

          <div className="flex gap-3 pt-6">
            <button
              type="submit"
              disabled={saving}
              className="flex-1 bg-primary text-white p-3 rounded-lg font-semibold hover:bg-primary/90 transition disabled:opacity-50"
            >
              {saving ? 'Saving...' : 'Save Changes'}
            </button>
            <button
              type="button"
              onClick={() => router.back()}
              className="px-6 bg-gray-200 text-gray-800 p-3 rounded-lg font-semibold hover:bg-gray-300 transition"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </main>
  )
}
