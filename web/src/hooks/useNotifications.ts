
import { useEffect } from 'react'
import { getMessaging, getToken, onMessage } from 'firebase/messaging'
import app from '@/lib/firebase/config'

const useNotifications = () => {
  useEffect(() => {
    const requestPermission = async () => {
      try {
        if (typeof window !== 'undefined' && 'serviceWorker' in navigator) {
          const messaging = getMessaging(app)
          const permission = await Notification.requestPermission()

          if (permission === 'granted') {
            const token = await getToken(messaging, {
              vapidKey: process.env.NEXT_PUBLIC_FIREBASE_VAPID_KEY,
            })
            console.log('FCM Token:', token)

            onMessage(messaging, (payload) => {
              console.log('Message received. ', payload)
              if (payload.notification) {
                new Notification(payload.notification.title || 'New Message', {
                  body: payload.notification.body || '',
                  icon: payload.notification.icon || '',
                })
              }
            })
          }
        }
      } catch (error) {
        console.error('Error getting FCM token:', error)
      }
    }

    requestPermission()
  }, [])
}

export default useNotifications
