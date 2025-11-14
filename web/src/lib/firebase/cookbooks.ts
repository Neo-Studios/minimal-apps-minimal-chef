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

export interface Cookbook {
  id: string
  name: string
  description?: string
  recipeIds: string[]
  userId: string
  isPublic?: boolean
  createdAt: Timestamp
  updatedAt: Timestamp
}

const cookbooksCollection = collection(db, 'cookbooks')

export async function getCookbook(id: string): Promise<Cookbook | null> {
  try {
    const docRef = doc(db, 'cookbooks', id)
    const docSnap = await getDoc(docRef)
    
    if (docSnap.exists()) {
      return { id: docSnap.id, ...docSnap.data() } as Cookbook
    }
    return null
  } catch (error) {
    console.error('Error getting cookbook:', error)
    return null
  }
}

export async function getCookbooks(userId: string): Promise<Cookbook[]> {
  try {
    const q = query(
      cookbooksCollection,
      where('userId', '==', userId),
      orderBy('createdAt', 'desc')
    )
    
    const querySnapshot = await getDocs(q)
    return querySnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    })) as Cookbook[]
  } catch (error) {
    console.error('Error getting cookbooks:', error)
    return []
  }
}

export async function createCookbook(cookbook: Omit<Cookbook, 'id' | 'createdAt' | 'updatedAt'>): Promise<string | null> {
  try {
    const docRef = await addDoc(cookbooksCollection, {
      ...cookbook,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    })
    return docRef.id
  } catch (error) {
    console.error('Error creating cookbook:', error)
    return null
  }
}

export async function updateCookbook(id: string, updates: Partial<Cookbook>): Promise<boolean> {
  try {
    const docRef = doc(db, 'cookbooks', id)
    await updateDoc(docRef, {
      ...updates,
      updatedAt: Timestamp.now(),
    })
    return true
  } catch (error) {
    console.error('Error updating cookbook:', error)
    return false
  }
}

export async function deleteCookbook(id: string): Promise<boolean> {
  try {
    const docRef = doc(db, 'cookbooks', id)
    await deleteDoc(docRef)
    return true
  } catch (error) {
    console.error('Error deleting cookbook:', error)
    return false
  }
}

export async function addRecipeToCookbook(cookbookId: string, recipeId: string): Promise<boolean> {
  try {
    const cookbook = await getCookbook(cookbookId)
    if (!cookbook) return false
    
    const recipeIds = [...cookbook.recipeIds, recipeId]
    return await updateCookbook(cookbookId, { recipeIds })
  } catch (error) {
    console.error('Error adding recipe to cookbook:', error)
    return false
  }
}

export async function removeRecipeFromCookbook(cookbookId: string, recipeId: string): Promise<boolean> {
  try {
    const cookbook = await getCookbook(cookbookId)
    if (!cookbook) return false
    
    const recipeIds = cookbook.recipeIds.filter(id => id !== recipeId)
    return await updateCookbook(cookbookId, { recipeIds })
  } catch (error) {
    console.error('Error removing recipe from cookbook:', error)
    return false
  }
}
