import { Recipe } from '@/types/models'

const CACHE_NAME = 'minimal-chef-v1'
const RECIPE_CACHE_KEY = 'cached-recipes'

export async function cacheRecipe(recipe: Recipe): Promise<void> {
  if (typeof window === 'undefined') return
  
  const cached = await getCachedRecipes()
  const updated = [...cached.filter(r => r.id !== recipe.id), recipe]
  localStorage.setItem(RECIPE_CACHE_KEY, JSON.stringify(updated))
}

export async function getCachedRecipes(): Promise<Recipe[]> {
  if (typeof window === 'undefined') return []
  
  const cached = localStorage.getItem(RECIPE_CACHE_KEY)
  return cached ? JSON.parse(cached) : []
}

export async function getCachedRecipe(id: string): Promise<Recipe | null> {
  const recipes = await getCachedRecipes()
  return recipes.find(r => r.id === id) || null
}

export async function removeCachedRecipe(id: string): Promise<void> {
  const recipes = await getCachedRecipes()
  const filtered = recipes.filter(r => r.id !== id)
  localStorage.setItem(RECIPE_CACHE_KEY, JSON.stringify(filtered))
}

export async function clearCache(): Promise<void> {
  if (typeof window === 'undefined') return
  localStorage.removeItem(RECIPE_CACHE_KEY)
}

export function isOnline(): boolean {
  return typeof navigator !== 'undefined' ? navigator.onLine : true
}
