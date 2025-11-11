'use client'

import { useEffect, useState } from 'react'
import { useAuthStore } from '@/lib/stores/authStore'
import { getRecipes } from '@/lib/firebase/firestore'
import { Recipe } from '@/types/models'
import RecipeCard from '@/components/features/RecipeCard'

export default function RecipesPage() {
  const { user } = useAuthStore()
  const [recipes, setRecipes] = useState<Recipe[]>([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')

  useEffect(() => {
    if (user) {
      getRecipes(user.uid).then(data => {
        setRecipes(data)
        setLoading(false)
      })
    }
  }, [user])

  const filteredRecipes = recipes.filter(r => 
    r.name.toLowerCase().includes(search.toLowerCase())
  )

  if (loading) return <div className="p-8">Loading...</div>

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-3xl font-bold mb-6">Recipes</h1>
      <input
        type="text"
        placeholder="Search recipes..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        className="w-full p-3 border rounded-lg mb-6"
      />
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredRecipes.map(recipe => (
          <RecipeCard key={recipe.id} recipe={recipe} />
        ))}
      </div>
    </main>
  )
}
