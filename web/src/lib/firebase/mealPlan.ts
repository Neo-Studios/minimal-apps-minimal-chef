import { db } from './config'
import { collection, doc, setDoc, getDoc, onSnapshot } from 'firebase/firestore'

export async function saveMealPlan(userId: string, date: string, meals: string[]) {
  await setDoc(doc(db, 'mealPlans', userId, 'plans', date), { meals, date })
}

export async function getMealPlan(userId: string, date: string) {
  const docSnap = await getDoc(doc(db, 'mealPlans', userId, 'plans', date))
  return docSnap.exists() ? docSnap.data() : null
}

export function subscribeMealPlans(userId: string, callback: (data: any) => void) {
  return onSnapshot(collection(db, 'mealPlans', userId, 'plans'), (snapshot) => {
    const plans: Record<string, any> = {}
    snapshot.docs.forEach(doc => {
      plans[doc.id] = doc.data()
    })
    callback(plans)
  })
}
