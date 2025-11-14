'use client'

import { ReactNode, useEffect, useState } from 'react'

interface ResponsiveLayoutProps {
  children: ReactNode
  sidebar?: ReactNode
  navigation?: ReactNode
}

type ScreenSize = 'mobile' | 'tablet' | 'desktop'

export default function ResponsiveLayout({ 
  children, 
  sidebar, 
  navigation 
}: ResponsiveLayoutProps) {
  const [screenSize, setScreenSize] = useState<ScreenSize>('mobile')

  useEffect(() => {
    const handleResize = () => {
      const width = window.innerWidth
      if (width < 768) {
        setScreenSize('mobile')
      } else if (width < 1024) {
        setScreenSize('tablet')
      } else {
        setScreenSize('desktop')
      }
    }

    handleResize()
    window.addEventListener('resize', handleResize)
    return () => window.removeEventListener('resize', handleResize)
  }, [])

  if (screenSize === 'mobile') {
    return (
      <div className="flex flex-col min-h-screen">
        <main className="flex-1 pb-20">
          {children}
        </main>
        {navigation}
      </div>
    )
  }

  if (screenSize === 'tablet') {
    return (
      <div className="flex min-h-screen">
        {navigation && (
          <aside className="w-20 border-r border-gray-200 dark:border-gray-800">
            {navigation}
          </aside>
        )}
        <main className="flex-1">
          {children}
        </main>
      </div>
    )
  }

  // Desktop
  return (
    <div className="flex min-h-screen">
      {navigation && (
        <aside className="w-64 border-r border-gray-200 dark:border-gray-800">
          {navigation}
        </aside>
      )}
      <div className="flex-1 flex">
        <main className="flex-1 max-w-7xl mx-auto">
          {children}
        </main>
        {sidebar && (
          <aside className="w-80 border-l border-gray-200 dark:border-gray-800 p-6">
            {sidebar}
          </aside>
        )}
      </div>
    </div>
  )
}
