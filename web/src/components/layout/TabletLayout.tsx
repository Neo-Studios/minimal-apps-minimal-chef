'use client'

import React, { useState } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { Icon, IconName } from '@/components/ui/Icon'

interface TabletLayoutProps {
  children: React.ReactNode
}

const navigation = [
  { name: 'Recipes', href: '/recipes', icon: 'book' as const },
  { name: 'Meal Plan', href: '/meal-plan', icon: 'calendar' as const },
  { name: 'Shopping', href: '/shopping', icon: 'cart' as const },
  { name: 'Cookbooks', href: '/cookbooks', icon: 'cookbook' as const },
  { name: 'Nutrition', href: '/nutrition', icon: 'chart' as const },
  { name: 'Timers', href: '/timers', icon: 'clock' as const },
  { name: 'AI Assistant', href: '/ai-recipe-generator', icon: 'robot' as const },
  { name: 'Settings', href: '/settings', icon: 'settings' as const },
]

export function TabletLayout({ children }: TabletLayoutProps) {
  const pathname = usePathname()
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false)

  return (
    <div className="flex h-screen bg-m3-surface">
      {/* Sidebar - NO bottom navigation on tablets */}
      <aside
        className={`${
          sidebarCollapsed ? 'w-20' : 'w-64'
        } bg-m3-surface-container border-r border-m3-outline-variant transition-all duration-300 flex flex-col`}
      >
        {/* Header */}
        <div className="p-4 border-b border-m3-outline-variant flex items-center justify-between">
          {!sidebarCollapsed && (
            <h1 className="text-2xl font-bold text-m3-primary-main">Zest</h1>
          )}
          <button
            onClick={() => setSidebarCollapsed(!sidebarCollapsed)}
            className="p-2 rounded-lg hover:bg-m3-primary-main/10 transition-colors"
            aria-label={sidebarCollapsed ? 'Expand sidebar' : 'Collapse sidebar'}
          >
            {sidebarCollapsed ? '→' : '←'}
          </button>
        </div>

        {/* Navigation */}
        <nav className="flex-1 p-4 space-y-2 overflow-y-auto">
          {navigation.map((item) => {
            const isActive = pathname.startsWith(item.href)
            return (
              <Link
                key={item.name}
                href={item.href}
                className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-all ${
                  isActive
                    ? 'bg-m3-primary-container text-m3-on-primary-container'
                    : 'hover:bg-m3-surface-container-high text-m3-on-surface'
                }`}
                title={sidebarCollapsed ? item.name : undefined}
              >
                <Icon name={item.icon} className="text-xl" />
                {!sidebarCollapsed && (
                  <span className="font-medium">{item.name}</span>
                )}
              </Link>
            )
          })}
        </nav>

        {/* User section */}
        <div className="p-4 border-t border-m3-outline-variant">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-m3-primary-main flex items-center justify-center text-white font-bold flex-shrink-0">
              U
            </div>
            {!sidebarCollapsed && (
              <div className="flex-1 min-w-0">
                <p className="font-medium text-m3-on-surface truncate">User</p>
                <p className="text-sm text-m3-on-surface-variant truncate">user@example.com</p>
              </div>
            )}
          </div>
        </div>
      </aside>

      {/* Main content - full height, no bottom padding */}
      <main className="flex-1 overflow-y-auto">
        {children}
      </main>
    </div>
  )
}
