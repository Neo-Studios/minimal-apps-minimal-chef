'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { useAuth } from '@/lib/hooks/useAuth'
import { createRecipe, Ingredient } from '@/lib/firebase/recipes'
import { ImageUpload } from '@/components/ui/ImageUpload'

export default function NewRecipePage() {
  const router = useRouter()
  const { user } = useAuth()
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

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!user) {
      alert('Please sign in to create recipes')
      return
    }

    const recipeId = await createRecipe({
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
      userId: user.uid,
    })
    
    if (recipeId) {
      router.push('/recipes')
    } else {
      alert('Failed to create recipe')
    }
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-3xl font-bold mb-6">Add Recipe</h1>
      <form onSubmit={handleSubmit} className="space-y-4 max-w-2xl">
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
          label="Add Recipe Image"
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
          <input
            type="number"
            placeholder="Prep Time (min)"
            value={prepTime}
            onChange={(e) => setPrepTime(Number(e.target.value))}
            className="p-3 border rounded-lg"
          />
          <input
            type="number"
            placeholder="Cook Time (min)"
            value={cookTime}
            onChange={(e) => setCookTime(Number(e.target.value))}
            className="p-3 border rounded-lg"
          />
          <input
            type="number"
            placeholder="Servings"
            value={servings}
            onChange={(e) => setServings(Number(e.target.value))}
            className="p-3 border rounded-lg"
          />
        </div>
        
        <h3 className="text-xl font-semibold mt-6">Ingredients</h3>
        {ingredients.map((ing, i) => (
          <div key={i} className="grid grid-cols-3 gap-2">
            <input
              type="number"
              placeholder="Amount"
              value={ing.amount}
              onChange={(e) => {
                const newIng = [...ingredients]
                newIng[i].amount = Number(e.target.value)
                setIngredients(newIng)
              }}
              className="p-2 border rounded"
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
          </div>
        ))}
        <button
          type="button"
          onClick={() => setIngredients([...ingredients, { name: '', amount: 0, unit: '' }])}
          className="text-primary"
        >
          + Add Ingredient
        </button>

        <h3 className="text-xl font-semibold mt-6">Instructions</h3>
        {instructions.map((step, i) => (
          <textarea
            key={i}
            placeholder={`Step ${i + 1}`}
            value={step}
            onChange={(e) => {
              const newSteps = [...instructions]
              newSteps[i] = e.target.value
              setInstructions(newSteps)
            }}
            className="w-full p-3 border rounded-lg"
            rows={2}
          />
        ))}
        <button
          type="button"
          onClick={() => setInstructions([...instructions, ''])}
          className="text-primary"
        >
          + Add Step
        </button>

        <button type="submit" className="w-full bg-primary text-white p-3 rounded-lg font-semibold mt-6">
          Save Recipe
        </button>
      </form>
    </main>
  )
}
