import { getMessaging, getToken, onMessage } from 'firebase/messaging'
import app from '@/lib/firebase/config'

const vapidKey = process.env.NEXT_PUBLIC_FIREBASE_VAPID_KEY

export async function requestNotificationPermission(): Promise<string | null> {
  try {
    if (typeof window === 'undefined' || !('Notification' in window)) {
      console.log('Notifications not supported')
      return null
    }

    const permission = await Notification.requestPermission()
    
    if (permission === 'granted') {
      const messaging = getMessaging(app)
      const token = await getToken(messaging, { vapidKey })
      console.log('FCM Token:', token)
      return token
    } else {
      console.log('Notification permission denied')
      return null
    }
  } catch (error) {
    console.error('Error getting notification permission:', error)
    return null
  }
}

export function setupMessageListener(callback: (payload: any) => void) {
  if (typeof window === 'undefined') return

  try {
    const messaging = getMessaging(app)
    
    onMessage(messaging, (payload) => {
      console.log('Message received:', payload)
      callback(payload)
      
      // Show notification
      if (payload.notification) {
        new Notification(payload.notification.title || 'Zest', {
          body: payload.notification.body,
          icon: '/icon-192x192.png',
          badge: '/icon-192x192.png',
        })
      }
    })
  } catch (error) {
    console.error('Error setting up message listener:', error)
  }
}

export async function subscribeToTopic(token: string, topic: string): Promise<boolean> {
  try {
    // This would typically be done on the backend
    // For now, we'll just log it
    console.log(`Subscribing token ${token} to topic ${topic}`)
    return true
  } catch (error) {
    console.error('Error subscribing to topic:', error)
    return false
  }
}

export function checkNotificationSupport(): boolean {
  return typeof window !== 'undefined' && 
         'Notification' in window && 
         'serviceWorker' in navigator &&
         'PushManager' in window
}
