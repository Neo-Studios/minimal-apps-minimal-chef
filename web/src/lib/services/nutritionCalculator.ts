import { NutritionInfo, Ingredient } from '@/types/models'

const nutritionDatabase: Record<string, NutritionInfo> = {
  'chicken breast': { calories: 165, protein: 31, carbs: 0, fat: 3.6 },
  'rice': { calories: 130, protein: 2.7, carbs: 28, fat: 0.3 },
  'broccoli': { calories: 55, protein: 3.7, carbs: 11, fat: 0.6 },
  'olive oil': { calories: 884, protein: 0, carbs: 0, fat: 100 },
  'egg': { calories: 155, protein: 13, carbs: 1.1, fat: 11 },
  'milk': { calories: 61, protein: 3.2, carbs: 4.8, fat: 3.3 },
  'bread': { calories: 265, protein: 9, carbs: 49, fat: 3.2 },
  'pasta': { calories: 131, protein: 5, carbs: 25, fat: 1.1 },
  'tomato': { calories: 18, protein: 0.9, carbs: 3.9, fat: 0.2 },
  'cheese': { calories: 402, protein: 25, carbs: 1.3, fat: 33 }
}

export function calculateNutrition(ingredients: Ingredient[], servings: number): NutritionInfo {
  let totalCalories = 0
  let totalProtein = 0
  let totalCarbs = 0
  let totalFat = 0

  ingredients.forEach(ing => {
    const key = ing.name.toLowerCase()
    const nutrition = nutritionDatabase[key]
    
    if (nutrition) {
      const factor = ing.amount / 100
      totalCalories += nutrition.calories * factor
      totalProtein += nutrition.protein * factor
      totalCarbs += nutrition.carbs * factor
      totalFat += nutrition.fat * factor
    }
  })

  return {
    calories: Math.round(totalCalories / servings),
    protein: Math.round(totalProtein / servings * 10) / 10,
    carbs: Math.round(totalCarbs / servings * 10) / 10,
    fat: Math.round(totalFat / servings * 10) / 10
  }
}

export function estimateCost(ingredients: Ingredient[]): number {
  const avgCostPerItem = 2.5
  return Math.round(ingredients.length * avgCostPerItem * 100) / 100
}
