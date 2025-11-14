'use client'

import React, { useEffect } from 'react'
import { usePathname } from 'next/navigation'
import { useIsTablet } from '@/lib/hooks/useMediaQuery'
import { TabletLayout } from './TabletLayout'
import { MobileLayout } from './MobileLayout'
import { AuthGuard } from '@/components/auth/AuthGuard'
import { useAuthStore } from '@/lib/stores/authStore'
import { setupRecipeImporter } from '@/lib/utils/recipeImporter'

interface ClientLayoutProps {
  children: React.ReactNode
}

const PUBLIC_ROUTES = ['/login']

export function ClientLayout({ children }: ClientLayoutProps) {
  const isTablet = useIsTablet()
  const pathname = usePathname()
  const isPublicRoute = PUBLIC_ROUTES.includes(pathname)
  const { user } = useAuthStore()

  useEffect(() => {
    // Request notification permission
    if ('Notification' in window && Notification.permission === 'default') {
      Notification.requestPermission()
    }
    
    // Setup recipe importer for authenticated users
    if (user) {
      setupRecipeImporter(user.uid)
    }
  }, [user])

  // For public routes (like login), don't wrap in layout
  if (isPublicRoute) {
    return <AuthGuard>{children}</AuthGuard>
  }

  // For protected routes, wrap in layout
  return (
    <AuthGuard>
      {isTablet ? (
        <TabletLayout>{children}</TabletLayout>
      ) : (
        <MobileLayout>{children}</MobileLayout>
      )}
    </AuthGuard>
  )
}
