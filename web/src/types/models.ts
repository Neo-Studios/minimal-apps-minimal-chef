export interface Recipe {
  id?: string
  name: string
  description?: string
  ingredients: Ingredient[]
  instructions: string[]
  prepTime?: number
  cookTime?: number
  servings: number
  imageUrl?: string
  userId?: string
  cuisineType?: string
  mealType?: string
  difficulty?: 'easy' | 'medium' | 'hard'
  dietaryRestrictions?: DietaryRestriction[]
  nutrition?: NutritionInfo
  rating?: number
  notes?: string
  costEstimate?: number
  createdAt?: Date
  updatedAt?: Date
}

export interface Ingredient {
  name: string
  amount: number
  unit: string
  category?: string
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

export type DietaryRestriction = 
  | 'vegetarian' 
  | 'vegan' 
  | 'gluten-free' 
  | 'dairy-free' 
  | 'keto' 
  | 'paleo' 
  | 'low-carb' 
  | 'halal' 
  | 'kosher'

export interface Cookbook {
  id?: string
  name: string
  description?: string
  recipeIds: string[]
  userId: string
  isPublic: boolean
  coverImageUrl?: string
  createdAt?: Date
  updatedAt?: Date
}

export interface CookingTimer {
  id: string
  name: string
  duration: number
  remainingTime: number
  isRunning: boolean
  recipeId?: string
}

export interface InventoryItem {
  id?: string
  name: string
  quantity: number
  unit: string
  expirationDate?: Date
  category?: string
  userId: string
  addedAt?: Date
}

export interface MealPlan {
  id?: string
  date: string
  recipeId: string
  mealType: 'breakfast' | 'lunch' | 'dinner' | 'snack'
  userId: string
}

export interface ShoppingListItem {
  id?: string
  name: string
  amount?: string
  category?: string
  checked: boolean
  userId?: string
  recipeId?: string
  recipeName?: string
  createdAt?: Date
}

export interface User {
  uid: string
  email: string | null
  displayName: string | null
  photoURL: string | null
}

export interface RecipeRecommendation {
  recipeId: string
  score: number
  reason: string
}

export interface NutritionGoal {
  id?: string
  userId: string
  dailyCalories: number
  dailyProtein: number
  dailyCarbs: number
  dailyFat: number
}
