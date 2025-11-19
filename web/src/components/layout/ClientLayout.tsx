'use client'

import React, { useEffect, useState } from 'react'
import { usePathname } from 'next/navigation'
import { useIsTablet } from '@/lib/hooks/useMediaQuery'
import { TabletLayout } from './TabletLayout'
import { MobileLayout } from './MobileLayout'
import { AuthGuard } from '@/components/auth/AuthGuard'
import { useAuthStore } from '@/lib/stores/authStore'
import { setupRecipeImporter } from '@/lib/utils/recipeImporter'
import { FeatureShowcase } from '@/components/onboarding/FeatureShowcase'
import { AppTour } from '@/components/onboarding/AppTour'

interface ClientLayoutProps {
  children: React.ReactNode
}

const PUBLIC_ROUTES = ['/login']

export function ClientLayout({ children }: ClientLayoutProps) {
  const isTablet = useIsTablet()
  const pathname = usePathname()
  const isPublicRoute = PUBLIC_ROUTES.includes(pathname)
  const { user, showOnboarding, completeOnboarding } = useAuthStore()
  const [showAppTour, setShowAppTour] = useState(false)

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

  const handleFeatureShowcaseComplete = () => {
    setShowAppTour(true)
  }

  const handleAppTourComplete = async () => {
    if (user) {
      await completeOnboarding(user.uid)
    }
    setShowAppTour(false)
  }

  // For public routes (like login), don't wrap in layout
  if (isPublicRoute) {
    return <AuthGuard>{children}</AuthGuard>
  }

  // If user is logged in and onboarding is needed
  if (user && showOnboarding) {
    if (showAppTour) {
      return <AppTour onSkip={handleAppTourComplete} onComplete={handleAppTourComplete} />
    }
    return <FeatureShowcase onSkip={handleAppTourComplete} onComplete={handleFeatureShowcaseComplete} />
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
