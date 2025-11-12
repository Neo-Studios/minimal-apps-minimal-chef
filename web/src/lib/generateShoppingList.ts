import { Recipe, Ingredient } from '@/types/models'

export function generateShoppingList(recipes: Recipe[]): Ingredient[] {
  const ingredientMap = new Map<string, Ingredient>()
  
  recipes.forEach(recipe => {
    recipe.ingredients.forEach(ing => {
      const key = ing.name.toLowerCase()
      if (ingredientMap.has(key)) {
        const existing = ingredientMap.get(key)!
        // Combine quantities
        existing.amount += ing.amount
      } else {
        ingredientMap.set(key, { ...ing })
      }
    })
  })
  
  return Array.from(ingredientMap.values())
}
