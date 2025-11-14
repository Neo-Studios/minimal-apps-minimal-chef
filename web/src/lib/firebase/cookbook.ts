import { db } from './config'
import { collection, addDoc, getDocs, getDoc, doc, updateDoc, deleteDoc, query, where, arrayUnion, arrayRemove } from 'firebase/firestore'
import { Cookbook } from '@/types/models'

const cookbooksCollection = collection(db, 'cookbooks')

export async function getCookbooks(userId: string): Promise<Cookbook[]> {
  const q = query(cookbooksCollection, where('userId', '==', userId))
  const snapshot = await getDocs(q)
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as Cookbook))
}

export async function getCookbook(id: string): Promise<Cookbook | null> {
  const docSnap = await getDoc(doc(cookbooksCollection, id))
  if (docSnap.exists()) {
    return { id: docSnap.id, ...docSnap.data() } as Cookbook
  }
  return null
}

export async function createCookbook(cookbook: Omit<Cookbook, 'id'>): Promise<string> {
  const docRef = await addDoc(cookbooksCollection, {
    ...cookbook,
    createdAt: new Date(),
    updatedAt: new Date()
  })
  return docRef.id
}

export async function updateCookbook(id: string, data: Partial<Cookbook>): Promise<void> {
  await updateDoc(doc(cookbooksCollection, id), {
    ...data,
    updatedAt: new Date()
  })
}

export async function deleteCookbook(id: string): Promise<void> {
  await deleteDoc(doc(cookbooksCollection, id))
}

export async function addRecipeToCookbook(cookbookId: string, recipeId: string): Promise<void> {
  await updateDoc(doc(cookbooksCollection, cookbookId), {
    recipeIds: arrayUnion(recipeId),
    updatedAt: new Date()
  })
}

export async function removeRecipeFromCookbook(cookbookId: string, recipeId: string): Promise<void> {
  await updateDoc(doc(cookbooksCollection, cookbookId), {
    recipeIds: arrayRemove(recipeId),
    updatedAt: new Date()
  })
}
