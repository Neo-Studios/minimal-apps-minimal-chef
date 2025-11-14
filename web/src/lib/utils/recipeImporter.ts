/**
 * Recipe Importer Utility
 * Allows importing recipes from GitHub Gist URLs via browser console
 */

import { db } from '@/lib/firebase/config'
import { collection, addDoc, Timestamp } from 'firebase/firestore'

interface ImportRecipe {
  name: string
  description?: string
  imageUrl?: string
  instructions: string[]
  ingredients: Array<{ name: string; quantity: string }>
  cuisineType: string
  mealType?: string
  difficultyLevel: 'easy' | 'medium' | 'hard'
  prepTime: number
  cookTime: number
  servings: number
  tags?: string[]
}

interface FirestoreRecipe {
  name: string
  description?: string
  cuisine: string
  cuisineType?: string
  mealType?: string
  prepTime: number
  cookTime: number
  servings: number
  difficulty: 'Easy' | 'Medium' | 'Hard'
  ingredients: Array<{ name: string; amount: number; unit: string }>
  instructions: string[]
  imageUrl?: string
  rating?: number
  dietaryRestrictions?: string[]
  userId: string
  createdAt: Timestamp
  updatedAt: Timestamp
}

/**
 * Parse quantity string into amount and unit
 * Examples: "1 cup" -> {amount: 1, unit: "cup"}
 */
function parseQuantity(quantity: string): { amount: number; unit: string } {
  const match = quantity.match(/^([\d.\/]+)\s*(.*)$/)
  if (!match) {
    return { amount: 1, unit: quantity }
  }
  
  let amount = 1
  const amountStr = match[1]
  const unit = match[2] || ''
  
  // Handle fractions like "1/2"
  if (amountStr.includes('/')) {
    const [num, den] = amountStr.split('/').map(Number)
    amount = num / den
  } else {
    amount = parseFloat(amountStr)
  }
  
  return { amount, unit }
}

/**
 * Convert import format to Firestore format
 */
function convertRecipe(recipe: ImportRecipe, userId: string): FirestoreRecipe {
  // Convert difficulty
  const difficultyMap: Record<string, 'Easy' | 'Medium' | 'Hard'> = {
    easy: 'Easy',
    medium: 'Medium',
    hard: 'Hard',
  }
  
  // Convert ingredients
  const ingredients = recipe.ingredients.map(ing => {
    const { amount, unit } = parseQuantity(ing.quantity)
    return {
      name: ing.name,
      amount,
      unit,
    }
  })
  
  return {
    name: recipe.name,
    description: recipe.description,
    cuisine: recipe.cuisineType,
    cuisineType: recipe.cuisineType,
    mealType: recipe.mealType,
    prepTime: recipe.prepTime,
    cookTime: recipe.cookTime,
    servings: recipe.servings,
    difficulty: difficultyMap[recipe.difficultyLevel] || 'Medium',
    ingredients,
    instructions: recipe.instructions,
    imageUrl: recipe.imageUrl,
    dietaryRestrictions: recipe.tags,
    userId,
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  }
}

/**
 * Fetch recipes from GitHub Gist URL
 */
async function fetchRecipesFromGist(url: string): Promise<ImportRecipe[]> {
  // Convert GitHub Gist URL to raw URL if needed
  let rawUrl = url
  
  if (url.includes('gist.github.com')) {
    // Extract gist ID and filename
    const gistMatch = url.match(/gist\.github\.com\/[^\/]+\/([a-f0-9]+)/)
    if (gistMatch) {
      const gistId = gistMatch[1]
      // Fetch gist metadata to get raw URL
      const gistApiUrl = `https://api.github.com/gists/${gistId}`
      const gistResponse = await fetch(gistApiUrl)
      const gistData = await gistResponse.json()
      
      // Get first file's raw URL
      const files = Object.values(gistData.files) as any[]
      if (files.length > 0) {
        rawUrl = files[0].raw_url
      }
    }
  }
  
  // Fetch the raw content
  const response = await fetch(rawUrl)
  if (!response.ok) {
    throw new Error(`Failed to fetch recipes: ${response.statusText}`)
  }
  
  const data = await response.json()
  
  // Validate it's an array
  if (!Array.isArray(data)) {
    throw new Error('Invalid format: Expected an array of recipes')
  }
  
  return data
}

/**
 * Import recipes to Firestore
 */
export async function importRecipes(url: string, password: string, userId: string): Promise<{ success: number; failed: number; errors: string[] }> {
  // Verify password
  const correctPassword = process.env.NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD
  if (!correctPassword) {
    throw new Error('Recipe import password not configured')
  }
  
  if (password !== correctPassword) {
    throw new Error('Invalid password')
  }
  
  // Verify Firestore is initialized
  if (!db) {
    throw new Error('Firestore not initialized')
  }
  
  // Fetch recipes
  console.log('Fetching recipes from:', url)
  const recipes = await fetchRecipesFromGist(url)
  console.log(`Found ${recipes.length} recipes to import`)
  
  // Import each recipe
  const results = {
    success: 0,
    failed: 0,
    errors: [] as string[],
  }
  
  for (let i = 0; i < recipes.length; i++) {
    const recipe = recipes[i]
    try {
      const firestoreRecipe = convertRecipe(recipe, userId)
      const recipesCol = collection(db, 'recipes')
      await addDoc(recipesCol, firestoreRecipe)
      results.success++
      console.log(`✓ Imported: ${recipe.name}`)
    } catch (error) {
      results.failed++
      const errorMsg = `Failed to import "${recipe.name}": ${error instanceof Error ? error.message : 'Unknown error'}`
      results.errors.push(errorMsg)
      console.error(`✗ ${errorMsg}`)
    }
  }
  
  return results
}

/**
 * Global function for browser console
 */
export function setupRecipeImporter(userId: string) {
  if (typeof window === 'undefined') return
  
  // @ts-ignore - Adding to window object
  window.dev = window.dev || {}
  
  // @ts-ignore
  window.dev.recipeAdd = async (url: string) => {
    try {
      const password = prompt('Enter recipe import password:')
      if (!password) {
        console.log('Import cancelled')
        return
      }
      
      console.log('Starting recipe import...')
      const results = await importRecipes(url, password, userId)
      
      console.log('\n=== Import Complete ===')
      console.log(`✓ Successfully imported: ${results.success}`)
      console.log(`✗ Failed: ${results.failed}`)
      
      if (results.errors.length > 0) {
        console.log('\nErrors:')
        results.errors.forEach(err => console.log(`  - ${err}`))
      }
      
      console.log('\nRefresh the page to see imported recipes.')
      
      return results
    } catch (error) {
      console.error('Import failed:', error instanceof Error ? error.message : error)
      throw error
    }
  }
  
  console.log('Recipe importer ready! Use: dev.recipeAdd("https://gist.github.com/...")')
}
