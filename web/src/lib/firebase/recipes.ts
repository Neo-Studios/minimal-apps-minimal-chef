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
  orderBy,
  Timestamp,
} from 'firebase/firestore'

export interface Ingredient {
  name: string
  amount: number
  unit: string
}

export interface Recipe {
  id: string
  name: string
  description?: string
  cuisine: string
  prepTime: number
  cookTime: number
  servings: number
  difficulty: 'Easy' | 'Medium' | 'Hard'
  ingredients: Ingredient[]
  instructions: string[]
  imageUrl?: string
  rating?: number
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
  createdAt: Timestamp
  updatedAt: Timestamp
}

// Remove static collection reference since db might be undefined during SSR

export async function getRecipe(id: string): Promise<Recipe | null> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return null
    }
    const docRef = doc(db, 'recipes', id)
    const docSnap = await getDoc(docRef)
    
    if (docSnap.exists()) {
      return { id: docSnap.id, ...docSnap.data() } as Recipe
    }
    return null
  } catch (error) {
    console.error('Error getting recipe:', error)
    return null
  }
}

export async function getRecipes(userId?: string): Promise<Recipe[]> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return []
    }
    const recipesCol = collection(db, 'recipes')
    let q = query(recipesCol, orderBy('createdAt', 'desc'))
    
    if (userId) {
      q = query(recipesCol, where('userId', '==', userId), orderBy('createdAt', 'desc'))
    }
    
    const querySnapshot = await getDocs(q)
    return querySnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    })) as Recipe[]
  } catch (error) {
    console.error('Error getting recipes:', error)
    return []
  }
}

export async function createRecipe(recipe: Omit<Recipe, 'id' | 'createdAt' | 'updatedAt'>): Promise<string | null> {
  try {
    if (!db) {
      console.error('Firestore not initialized')
      return null
    }
    const recipesCol = collection(db, 'recipes')
    const docRef = await addDoc(recipesCol, {
      ...recipe,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    })
    return docRef.id
  } catch (error) {
    console.error('Error creating recipe:', error)
    return null
  }
}

export async function updateRecipe(id: string, updates: Partial<Recipe>): Promise<boolean> {
  try {
    const docRef = doc(db, 'recipes', id)
    await updateDoc(docRef, {
      ...updates,
      updatedAt: Timestamp.now(),
    })
    return true
  } catch (error) {
    console.error('Error updating recipe:', error)
    return false
  }
}

export async function deleteRecipe(id: string): Promise<boolean> {
  try {
    const docRef = doc(db, 'recipes', id)
    await deleteDoc(docRef)
    return true
  } catch (error) {
    console.error('Error deleting recipe:', error)
    return false
  }
}
