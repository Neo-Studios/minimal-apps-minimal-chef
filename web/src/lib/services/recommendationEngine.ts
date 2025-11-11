import { Recipe, RecipeRecommendation } from '@/types/models'

export function getRecommendations(
  allRecipes: Recipe[],
  userHistory: string[],
  userFavorites: string[],
  limit: number = 5
): RecipeRecommendation[] {
  const scores = new Map<string, { score: number; reason: string }>()
  
  allRecipes.forEach(recipe => {
    if (!recipe.id) return
    
    let score = 0
    let reason = 'Recommended for you'
    
    // Boost if similar to favorites
    const favRecipes = allRecipes.filter(r => userFavorites.includes(r.id || ''))
    const hasSimilarCuisine = favRecipes.some(f => f.cuisineType === recipe.cuisineType)
    if (hasSimilarCuisine) {
      score += 30
      reason = `Similar to your favorites`
    }
    
    // Boost highly rated
    if (recipe.rating && recipe.rating >= 4.5) {
      score += 20
      reason = 'Highly rated'
    }
    
    // Boost quick recipes
    if (recipe.prepTime && recipe.cookTime && (recipe.prepTime + recipe.cookTime) <= 30) {
      score += 15
      reason = 'Quick & easy'
    }
    
    // Penalize if recently cooked
    if (userHistory.includes(recipe.id)) {
      score -= 50
    }
    
    // Boost by dietary match
    if (recipe.dietaryRestrictions && recipe.dietaryRestrictions.length > 0) {
      score += 10
    }
    
    // Random factor for variety
    score += Math.random() * 10
    
    scores.set(recipe.id, { score, reason })
  })
  
  return Array.from(scores.entries())
    .sort((a, b) => b[1].score - a[1].score)
    .slice(0, limit)
    .map(([recipeId, { score, reason }]) => ({
      recipeId,
      score,
      reason
    }))
}
