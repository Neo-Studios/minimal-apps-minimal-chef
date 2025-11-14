import { db } from './config'
import {
  collection,
  doc,
  getDoc,
  getDocs,
  addDoc,
  updateDoc,
  deleteDoc,
  query,
  where,
  Timestamp,
  setDoc,
} from 'firebase/firestore'

export interface MealPlan {
  id?: string
  userId: string
  date: string // ISO date string (YYYY-MM-DD)
  meals: {
    breakfast?: string[] // Recipe IDs
    lunch?: string[]
    dinner?: string[]
    snacks?: string[]
  }
  createdAt?: Timestamp
  updatedAt?: Timestamp
}

/**
 * Get meal plan for a specific date
 */
export async function getMealPlan(userId: string, date: string): Promise<MealPlan | null> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return null
    }

    const mealPlansCol = collection(db, 'mealPlans')
    const q = query(
      mealPlansCol,
      where('userId', '==', userId),
      where('date', '==', date)
    )
    
    const querySnapshot = await getDocs(q)
    
    if (querySnapshot.empty) {
      return null
    }
    
    const doc = querySnapshot.docs[0]
    return { id: doc.id, ...doc.data() } as MealPlan
  } catch (error) {
    console.error('Error getting meal plan:', error)
    return null
  }
}

/**
 * Get meal plans for a date range
 */
export async function getMealPlans(userId: string, startDate: string, endDate: string): Promise<MealPlan[]> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return []
    }

    const mealPlansCol = collection(db, 'mealPlans')
    const q = query(
      mealPlansCol,
      where('userId', '==', userId),
      where('date', '>=', startDate),
      where('date', '<=', endDate)
    )
    
    const querySnapshot = await getDocs(q)
    return querySnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    })) as MealPlan[]
  } catch (error) {
    console.error('Error getting meal plans:', error)
    return []
  }
}

/**
 * Add a recipe to a meal slot
 */
export async function addMealToDate(
  userId: string,
  date: string,
  mealType: 'breakfast' | 'lunch' | 'dinner' | 'snacks',
  recipeId: string
): Promise<boolean> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return false
    }

    // Check if meal plan exists for this date
    const existingPlan = await getMealPlan(userId, date)
    
    if (existingPlan && existingPlan.id) {
      // Update existing plan
      const currentMeals = existingPlan.meals[mealType] || []
      const updatedMeals = {
        ...existingPlan.meals,
        [mealType]: [...currentMeals, recipeId]
      }
      
      const docRef = doc(db, 'mealPlans', existingPlan.id)
      await updateDoc(docRef, {
        meals: updatedMeals,
        updatedAt: Timestamp.now()
      })
    } else {
      // Create new plan
      const mealPlansCol = collection(db, 'mealPlans')
      await addDoc(mealPlansCol, {
        userId,
        date,
        meals: {
          [mealType]: [recipeId]
        },
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now()
      })
    }
    
    return true
  } catch (error) {
    console.error('Error adding meal:', error)
    return false
  }
}

/**
 * Remove a recipe from a meal slot
 */
export async function removeMealFromDate(
  userId: string,
  date: string,
  mealType: 'breakfast' | 'lunch' | 'dinner' | 'snacks',
  recipeId: string
): Promise<boolean> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return false
    }

    const existingPlan = await getMealPlan(userId, date)
    
    if (!existingPlan || !existingPlan.id) {
      return false
    }
    
    const currentMeals = existingPlan.meals[mealType] || []
    const updatedMeals = {
      ...existingPlan.meals,
      [mealType]: currentMeals.filter(id => id !== recipeId)
    }
    
    const docRef = doc(db, 'mealPlans', existingPlan.id)
    await updateDoc(docRef, {
      meals: updatedMeals,
      updatedAt: Timestamp.now()
    })
    
    return true
  } catch (error) {
    console.error('Error removing meal:', error)
    return false
  }
}

/**
 * Delete entire meal plan for a date
 */
export async function deleteMealPlan(mealPlanId: string): Promise<boolean> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return false
    }

    const docRef = doc(db, 'mealPlans', mealPlanId)
    await deleteDoc(docRef)
    return true
  } catch (error) {
    console.error('Error deleting meal plan:', error)
    return false
  }
}
