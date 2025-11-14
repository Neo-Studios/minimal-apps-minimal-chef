import { db } from './config'
import {
  collection,
  doc,
  getDocs,
  addDoc,
  query,
  where,
  Timestamp,
  orderBy,
} from 'firebase/firestore'

export interface NutritionEntry {
  id?: string
  userId: string
  date: string // ISO date string (YYYY-MM-DD)
  recipeId?: string
  recipeName?: string
  calories: number
  protein: number
  carbs: number
  fat: number
  fiber?: number
  sugar?: number
  sodium?: number
  servings: number
  createdAt?: Timestamp
}

export interface DailyNutrition {
  date: string
  calories: number
  protein: number
  carbs: number
  fat: number
  fiber: number
  sugar: number
  sodium: number
  entries: NutritionEntry[]
}

/**
 * Log nutrition entry
 */
export async function logNutrition(entry: Omit<NutritionEntry, 'id' | 'createdAt'>): Promise<string | null> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return null
    }

    const nutritionCol = collection(db, 'nutrition')
    const docRef = await addDoc(nutritionCol, {
      ...entry,
      createdAt: Timestamp.now()
    })
    
    return docRef.id
  } catch (error) {
    console.error('Error logging nutrition:', error)
    return null
  }
}

/**
 * Get nutrition entries for a date range
 */
export async function getNutritionEntries(
  userId: string,
  startDate: string,
  endDate: string
): Promise<NutritionEntry[]> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return []
    }

    const nutritionCol = collection(db, 'nutrition')
    const q = query(
      nutritionCol,
      where('userId', '==', userId),
      where('date', '>=', startDate),
      where('date', '<=', endDate),
      orderBy('date', 'desc'),
      orderBy('createdAt', 'desc')
    )
    
    const querySnapshot = await getDocs(q)
    return querySnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    })) as NutritionEntry[]
  } catch (error) {
    console.error('Error getting nutrition entries:', error)
    return []
  }
}

/**
 * Get daily nutrition summary
 */
export async function getDailyNutrition(userId: string, date: string): Promise<DailyNutrition> {
  const entries = await getNutritionEntries(userId, date, date)
  
  const summary: DailyNutrition = {
    date,
    calories: 0,
    protein: 0,
    carbs: 0,
    fat: 0,
    fiber: 0,
    sugar: 0,
    sodium: 0,
    entries
  }
  
  entries.forEach(entry => {
    summary.calories += entry.calories * entry.servings
    summary.protein += entry.protein * entry.servings
    summary.carbs += entry.carbs * entry.servings
    summary.fat += entry.fat * entry.servings
    summary.fiber += (entry.fiber || 0) * entry.servings
    summary.sugar += (entry.sugar || 0) * entry.servings
    summary.sodium += (entry.sodium || 0) * entry.servings
  })
  
  return summary
}

/**
 * Get weekly nutrition summary
 */
export async function getWeeklyNutrition(userId: string, startDate: string): Promise<DailyNutrition[]> {
  const endDate = new Date(startDate)
  endDate.setDate(endDate.getDate() + 6)
  
  const entries = await getNutritionEntries(userId, startDate, endDate.toISOString().split('T')[0])
  
  // Group by date
  const dailyMap: Record<string, NutritionEntry[]> = {}
  entries.forEach(entry => {
    if (!dailyMap[entry.date]) {
      dailyMap[entry.date] = []
    }
    dailyMap[entry.date].push(entry)
  })
  
  // Create daily summaries
  const dailySummaries: DailyNutrition[] = []
  for (let i = 0; i < 7; i++) {
    const date = new Date(startDate)
    date.setDate(date.getDate() + i)
    const dateKey = date.toISOString().split('T')[0]
    
    const dayEntries = dailyMap[dateKey] || []
    const summary: DailyNutrition = {
      date: dateKey,
      calories: 0,
      protein: 0,
      carbs: 0,
      fat: 0,
      fiber: 0,
      sugar: 0,
      sodium: 0,
      entries: dayEntries
    }
    
    dayEntries.forEach(entry => {
      summary.calories += entry.calories * entry.servings
      summary.protein += entry.protein * entry.servings
      summary.carbs += entry.carbs * entry.servings
      summary.fat += entry.fat * entry.servings
      summary.fiber += (entry.fiber || 0) * entry.servings
      summary.sugar += (entry.sugar || 0) * entry.servings
      summary.sodium += (entry.sodium || 0) * entry.servings
    })
    
    dailySummaries.push(summary)
  }
  
  return dailySummaries
}

/**
 * Log nutrition from recipe
 */
export async function logRecipeNutrition(
  userId: string,
  date: string,
  recipeId: string,
  recipeName: string,
  nutrition: {
    calories: number
    protein: number
    carbs: number
    fat: number
    fiber?: number
    sugar?: number
    sodium?: number
  },
  servings: number = 1
): Promise<string | null> {
  return logNutrition({
    userId,
    date,
    recipeId,
    recipeName,
    calories: nutrition.calories,
    protein: nutrition.protein,
    carbs: nutrition.carbs,
    fat: nutrition.fat,
    fiber: nutrition.fiber,
    sugar: nutrition.sugar,
    sodium: nutrition.sodium,
    servings
  })
}
