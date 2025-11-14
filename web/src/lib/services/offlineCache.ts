// Offline cache service for PWA functionality

const CACHE_NAME = 'zest-cache-v1'
const CACHE_URLS = [
  '/',
  '/recipes',
  '/meal-plan',
  '/shopping',
  '/settings',
]

export async function registerCache() {
  if ('serviceWorker' in navigator) {
    try {
      const registration = await navigator.serviceWorker.register('/sw.js')
      console.log('Service Worker registered:', registration)
    } catch (error) {
      console.error('Service Worker registration failed:', error)
    }
  }
}

export async function cacheResources() {
  if ('caches' in window) {
    try {
      const cache = await caches.open(CACHE_NAME)
      await cache.addAll(CACHE_URLS)
      console.log('Resources cached successfully')
    } catch (error) {
      console.error('Failed to cache resources:', error)
    }
  }
}

export async function getCachedData(url: string) {
  if ('caches' in window) {
    try {
      const cache = await caches.open(CACHE_NAME)
      const response = await cache.match(url)
      if (response) {
        return await response.json()
      }
    } catch (error) {
      console.error('Failed to get cached data:', error)
    }
  }
  return null
}

export async function setCachedData(url: string, data: unknown) {
  if ('caches' in window) {
    try {
      const cache = await caches.open(CACHE_NAME)
      const response = new Response(JSON.stringify(data))
      await cache.put(url, response)
    } catch (error) {
      console.error('Failed to set cached data:', error)
    }
  }
}

export async function clearCache() {
  if ('caches' in window) {
    try {
      const cacheNames = await caches.keys()
      await Promise.all(
        cacheNames.map((name) => caches.delete(name))
      )
      console.log('Cache cleared successfully')
    } catch (error) {
      console.error('Failed to clear cache:', error)
    }
  }
}
