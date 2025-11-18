import { db } from '@/lib/firebase/firestore'
import { collection, getDocs, doc, getDoc, query, where } from 'firebase/firestore'
import { MealKit } from '@/types/mealKit'

export async function getMealKits(): Promise<MealKit[]> {
  const mealKitsCol = collection(db, 'mealKits')
  const mealKitSnapshot = await getDocs(mealKitsCol)
  const mealKitList = mealKitSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as MealKit))
  return mealKitList
}

export async function getMealKit(id: string): Promise<MealKit | null> {
  const mealKitDoc = doc(db, 'mealKits', id)
  const mealKitSnapshot = await getDoc(mealKitDoc)
  if (mealKitSnapshot.exists()) {
    return { id: mealKitSnapshot.id, ...mealKitSnapshot.data() } as MealKit
  }
  return null
}

export async function getAvailableMealKits(date: string): Promise<MealKit[]> {
  const mealKitsCol = collection(db, 'mealKits')
  const q = query(mealKitsCol, where('availableDates', 'array-contains', date))
  const mealKitSnapshot = await getDocs(q)
  const mealKitList = mealKitSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as MealKit))
  return mealKitList
}
