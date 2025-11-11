import { Recipe, DietaryRestriction } from '@/types/models'

export interface SearchFilters {
  query?: string
  cuisineType?: string
  mealType?: string
  difficulty?: 'easy' | 'medium' | 'hard'
  dietaryRestrictions?: DietaryRestriction[]
  maxPrepTime?: number
  maxCookTime?: number
  minRating?: number
  ingredients?: string[]
}

export function searchRecipes(recipes: Recipe[], filters: SearchFilters): Recipe[] {
  return recipes.filter(recipe => {
    if (filters.query) {
      const query = filters.query.toLowerCase()
      const matchesName = recipe.name.toLowerCase().includes(query)
      const matchesIngredients = recipe.ingredients.some(ing => 
        ing.name.toLowerCase().includes(query)
      )
      if (!matchesName && !matchesIngredients) return false
    }
    
    if (filters.cuisineType && recipe.cuisineType !== filters.cuisineType) {
      return false
    }
    
    if (filters.mealType && recipe.mealType !== filters.mealType) {
      return false
    }
    
    if (filters.difficulty && recipe.difficulty !== filters.difficulty) {
      return false
    }
    
    if (filters.dietaryRestrictions && filters.dietaryRestrictions.length > 0) {
      const hasAllRestrictions = filters.dietaryRestrictions.every(restriction =>
        recipe.dietaryRestrictions?.includes(restriction)
      )
      if (!hasAllRestrictions) return false
    }
    
    if (filters.maxPrepTime && recipe.prepTime && recipe.prepTime > filters.maxPrepTime) {
      return false
    }
    
    if (filters.maxCookTime && recipe.cookTime && recipe.cookTime > filters.maxCookTime) {
      return false
    }
    
    if (filters.minRating && recipe.rating && recipe.rating < filters.minRating) {
      return false
    }
    
    if (filters.ingredients && filters.ingredients.length > 0) {
      const hasAllIngredients = filters.ingredients.every(filterIng =>
        recipe.ingredients.some(recipeIng => 
          recipeIng.name.toLowerCase().includes(filterIng.toLowerCase())
        )
      )
      if (!hasAllIngredients) return false
    }
    
    return true
  })
}
