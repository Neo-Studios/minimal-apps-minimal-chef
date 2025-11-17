import { db } from '@/lib/firebase/firebase'
import { collection, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc, query, where, arrayUnion, arrayRemove, Timestamp } from 'firebase/firestore'
import { CollaborativeMealPlan, CollaborativeMealPlanMember } from '@/types/collaborativeMealPlan'

export async function getCollaborativeMealPlans(userId: string): Promise<CollaborativeMealPlan[]> {
  const q = query(collection(db, 'collaborativeMealPlans'), where('members', 'array-contains', { userId: userId, role: 'owner' })) // Simplified for now
  const snapshot = await getDocs(q)
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as CollaborativeMealPlan))
}

export async function getCollaborativeMealPlan(id: string): Promise<CollaborativeMealPlan | null> {
  const docRef = doc(db, 'collaborativeMealPlans', id)
  const docSnap = await getDoc(docRef)
  if (docSnap.exists()) {
    return { id: docSnap.id, ...docSnap.data() } as CollaborativeMealPlan
  }
  return null
}

export async function createCollaborativeMealPlan(name: string, ownerId: string): Promise<string> {
  const newPlan: Omit<CollaborativeMealPlan, 'id'> = {
    name,
    ownerId,
    members: [{ userId: ownerId, role: 'owner' }],
    mealPlanIds: [],
    createdAt: Timestamp.now().toMillis(),
    updatedAt: Timestamp.now().toMillis(),
  }
  const docRef = await addDoc(collection(db, 'collaborativeMealPlans'), newPlan)
  return docRef.id
}

export async function updateCollaborativeMealPlan(id: string, data: Partial<CollaborativeMealPlan>): Promise<void> {
  const docRef = doc(db, 'collaborativeMealPlans', id)
  await updateDoc(docRef, { ...data, updatedAt: Timestamp.now().toMillis() })
}

export async function deleteCollaborativeMealPlan(id: string): Promise<void> {
  const docRef = doc(db, 'collaborativeMealPlans', id)
  await deleteDoc(docRef)
}

export async function addMemberToCollaborativeMealPlan(planId: string, member: CollaborativeMealPlanMember): Promise<void> {
  const docRef = doc(db, 'collaborativeMealPlans', planId)
  await updateDoc(docRef, {
    members: arrayUnion(member),
    updatedAt: Timestamp.now().toMillis(),
  })
}

export async function removeMemberFromCollaborativeMealPlan(planId: string, member: CollaborativeMealPlanMember): Promise<void> {
  const docRef = doc(db, 'collaborativeMealPlans', planId)
  await updateDoc(docRef, {
    members: arrayRemove(member),
    updatedAt: Timestamp.now().toMillis(),
  })
}

export async function addMealPlanToCollaborativePlan(planId: string, mealPlanId: string): Promise<void> {
  const docRef = doc(db, 'collaborativeMealPlans', planId)
  await updateDoc(docRef, {
    mealPlanIds: arrayUnion(mealPlanId),
    updatedAt: Timestamp.now().toMillis(),
  })
}

export async function removeMealPlanFromCollaborativePlan(planId: string, mealPlanId: string): Promise<void> {
  const docRef = doc(db, 'collaborativeMealPlans', planId)
  await updateDoc(docRef, {
    mealPlanIds: arrayRemove(mealPlanId),
    updatedAt: Timestamp.now().toMillis(),
  })
}
