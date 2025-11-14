'use client'

import React from 'react'
import { useIsTablet } from '@/lib/hooks/useMediaQuery'
import { TabletLayout } from './TabletLayout'
import { MobileLayout } from './MobileLayout'

interface AdaptiveLayoutProps {
  children: React.ReactNode
}

export function AdaptiveLayout({ children }: AdaptiveLayoutProps) {
  const isTablet = useIsTablet()

  if (isTablet) {
    return <TabletLayout>{children}</TabletLayout>
  }

  return <MobileLayout>{children}</MobileLayout>
}
