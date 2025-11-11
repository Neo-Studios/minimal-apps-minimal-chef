export async function requestNotificationPermission(): Promise<boolean> {
  if (!('Notification' in window)) return false
  
  if (Notification.permission === 'granted') return true
  
  const permission = await Notification.requestPermission()
  return permission === 'granted'
}

export function sendNotification(title: string, options?: NotificationOptions): void {
  if (Notification.permission === 'granted') {
    new Notification(title, {
      icon: '/icon-192.png',
      badge: '/icon-192.png',
      ...options
    })
  }
}

export function scheduleExpirationAlert(itemName: string, expirationDate: Date): void {
  const now = new Date()
  const daysUntilExpiration = Math.floor((expirationDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24))
  
  if (daysUntilExpiration <= 2 && daysUntilExpiration >= 0) {
    sendNotification('Ingredient Expiring Soon', {
      body: `${itemName} expires in ${daysUntilExpiration} day(s)`,
      tag: `expiration-${itemName}`
    })
  }
}

export function sendMealPrepReminder(mealName: string, time: string): void {
  sendNotification('Meal Prep Reminder', {
    body: `Time to prepare ${mealName} for ${time}`,
    tag: 'meal-prep'
  })
}

export function sendTimerComplete(timerName: string): void {
  sendNotification('Timer Complete', {
    body: `${timerName} is done!`,
    tag: 'timer',
    requireInteraction: true
  })
}
