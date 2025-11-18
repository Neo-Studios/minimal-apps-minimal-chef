import { db } from './config'
import { collection, addDoc, getDocs, getDoc, doc, updateDoc, deleteDoc, query, where } from 'firebase/firestore'
import { Recipe, MealPlan, ShoppingListItem } from '@/types/models'

export { db }

export const recipesCollection = collection(db, 'recipes')
export const mealPlansCollection = collection(db, 'mealPlans')
export const shoppingListsCollection = collection(db, 'shoppingLists')

export const addRecipe = async (recipe: Omit<Recipe, 'id'>) => {
  const docRef = await addDoc(recipesCollection, recipe)
  return docRef.id
}

export const getRecipes = async (userId: string) => {
  const q = query(recipesCollection, where('userId', '==', userId))
  const snapshot = await getDocs(q)
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as Recipe))
}

export const updateRecipe = async (id: string, data: Partial<Recipe>) => {
  await updateDoc(doc(db, 'recipes', id), data)
}

export const deleteRecipe = async (id: string) => {
  await deleteDoc(doc(db, 'recipes', id))
}
