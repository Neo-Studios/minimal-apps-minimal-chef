import { enableIndexedDbPersistence } from 'firebase/firestore'
import { db } from './firebase/config'

export async function enableOfflineMode() {
  try {
    await enableIndexedDbPersistence(db)
    console.log('Offline persistence enabled')
  } catch (err: any) {
    if (err.code === 'failed-precondition') {
      console.warn('Multiple tabs open, persistence enabled in first tab only')
    } else if (err.code === 'unimplemented') {
      console.warn('Browser does not support offline persistence')
    }
  }
}
