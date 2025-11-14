import { Timestamp } from 'firebase/firestore'

export type DietaryRestriction = 
  | 'vegetarian'
  | 'vegan'
  | 'gluten-free'
  | 'dairy-free'
  | 'nut-free'
  | 'keto'
  | 'paleo'
  | 'halal'
  | 'kosher'

export interface Recipe {
  id?: string
  name: string
  description?: string
  cuisine: string
  cuisineType?: string
  mealType?: string
  prepTime: number
  cookTime: number
  servings: number
  difficulty: 'Easy' | 'Medium' | 'Hard'
  ingredients: Ingredient[]
  instructions: string[]
  imageUrl?: string
  rating?: number
  dietaryRestrictions?: DietaryRestriction[]
  nutrition?: {
    calories: number
    protein: number
    carbs: number
    fat: number
    fiber?: number
    sugar?: number
    sodium?: number
  }
  userId: string
  createdAt?: Timestamp
  updatedAt?: Timestamp
}

export interface Ingredient {
  name: string
  amount: number
  unit: string
}

export interface Cookbook {
  id?: string
  name: string
  description?: string
  recipeIds: string[]
  userId: string
  isPublic?: boolean
  createdAt?: Timestamp
  updatedAt?: Timestamp
}

export interface MealPlan {
  id?: string
  userId: string
  date: string
  meals: {
    breakfast?: string[]
    lunch?: string[]
    dinner?: string[]
    snacks?: string[]
  }
  createdAt?: Timestamp
  updatedAt?: Timestamp
}

export interface ShoppingList {
  id?: string
  userId: string
  name: string
  items: ShoppingItem[]
  createdAt?: Timestamp
  updatedAt?: Timestamp
}

export interface ShoppingItem {
  id: string
  name: string
  amount?: number
  unit?: string
  checked: boolean
  category?: string
}

export interface ShoppingListItem {
  id: string
  name: string
  amount?: string
  unit?: string
  category: string
  checked: boolean
  recipeName?: string
  createdAt?: Date
}

export interface Timer {
  id: string
  name: string
  duration: number
  remaining: number
  isRunning: boolean
}

export interface CookingTimer {
  id: string
  name: string
  duration: number
  remainingTime: number
  isRunning: boolean
}

export interface NutritionData {
  calories: number
  protein: number
  carbs: number
  fat: number
  fiber?: number
  sugar?: number
  sodium?: number
}

export interface NutritionInfo {
  calories: number
  protein: number
  carbs: number
  fat: number
  fiber?: number
  sugar?: number
  sodium?: number
}

export interface RecipeRecommendation {
  recipeId: string
  score: number
  reason: string
}
