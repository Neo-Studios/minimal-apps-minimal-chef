'use client'

import React, { useEffect } from 'react'
import { useIsTablet } from '@/lib/hooks/useMediaQuery'
import { TabletLayout } from './TabletLayout'
import { MobileLayout } from './MobileLayout'

interface ClientLayoutProps {
  children: React.ReactNode
}

export function ClientLayout({ children }: ClientLayoutProps) {
  const isTablet = useIsTablet()

  useEffect(() => {
    // Request notification permission
    if ('Notification' in window && Notification.permission === 'default') {
      Notification.requestPermission()
    }
  }, [])

  if (isTablet) {
    return <TabletLayout>{children}</TabletLayout>
  }

  return <MobileLayout>{children}</MobileLayout>
}
