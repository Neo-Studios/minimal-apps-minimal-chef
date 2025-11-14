'use client'

import { useEffect } from 'react'
import { useRouter, usePathname } from 'next/navigation'
import { useAuthStore } from '@/lib/stores/authStore'

interface AuthGuardProps {
  children: React.ReactNode
}

const PUBLIC_ROUTES = ['/login']

export function AuthGuard({ children }: AuthGuardProps) {
  const router = useRouter()
  const pathname = usePathname()
  const { user, loading } = useAuthStore()

  useEffect(() => {
    if (!loading) {
      const isPublicRoute = PUBLIC_ROUTES.includes(pathname)
      
      if (!user && !isPublicRoute) {
        // User is not authenticated and trying to access protected route
        router.push('/login')
      } else if (user && isPublicRoute) {
        // User is authenticated and on login page, redirect to app
        router.push('/recipes')
      }
    }
  }, [user, loading, pathname, router])

  // Show loading state while checking authentication
  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-16 w-16 border-b-4 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600 text-lg">Loading...</p>
        </div>
      </div>
    )
  }

  // Don't render protected content until we verify authentication
  const isPublicRoute = PUBLIC_ROUTES.includes(pathname)
  if (!user && !isPublicRoute) {
    return null // Will redirect in useEffect
  }

  return <>{children}</>
}
