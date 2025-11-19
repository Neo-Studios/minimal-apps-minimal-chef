import { doc, getDoc, setDoc } from 'firebase/firestore'
import { db } from './config'

interface UserProfile {
  hasCompletedOnboarding?: boolean
}

export const getUserProfile = async (userId: string): Promise<UserProfile | null> => {
  const userDocRef = doc(db, 'users', userId)
  const docSnap = await getDoc(userDocRef)

  if (docSnap.exists()) {
    return docSnap.data() as UserProfile
  } else {
    // If user profile doesn't exist, create a basic one
    await setDoc(userDocRef, { hasCompletedOnboarding: false }, { merge: true })
    return { hasCompletedOnboarding: false }
  }
}

export const setOnboardingStatus = async (userId: string, status: boolean) => {
  const userDocRef = doc(db, 'users', userId)
  await setDoc(userDocRef, { hasCompletedOnboarding: status }, { merge: true })
}
