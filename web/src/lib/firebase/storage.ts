import { storage } from './config'
import { ref, uploadBytes, getDownloadURL, deleteObject } from 'firebase/storage'

export async function uploadRecipeImage(file: File, recipeId: string): Promise<string> {
  const storageRef = ref(storage, `recipes/${recipeId}/${Date.now()}_${file.name}`)
  const snapshot = await uploadBytes(storageRef, file)
  const downloadURL = await getDownloadURL(snapshot.ref)
  return downloadURL
}

export async function uploadUserProfileImage(file: File, userId: string): Promise<string> {
  const storageRef = ref(storage, `users/${userId}/profile/${Date.now()}_${file.name}`)
  const snapshot = await uploadBytes(storageRef, file)
  const downloadURL = await getDownloadURL(snapshot.ref)
  return downloadURL
}

export async function uploadCookbookCover(file: File, cookbookId: string): Promise<string> {
  const storageRef = ref(storage, `cookbooks/${cookbookId}/${Date.now()}_${file.name}`)
  const snapshot = await uploadBytes(storageRef, file)
  const downloadURL = await getDownloadURL(snapshot.ref)
  return downloadURL
}

export async function deleteImage(imageUrl: string): Promise<void> {
  try {
    const imageRef = ref(storage, imageUrl)
    await deleteObject(imageRef)
  } catch (error) {
    console.error('Error deleting image:', error)
  }
}
