'use client'

import React, { useState } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { Icon, IconName } from '@/components/ui/Icon'

interface MobileLayoutProps {
  children: React.ReactNode
}

const navigation = [
  { name: 'Recipes', href: '/recipes', icon: 'book' as const },
  { name: 'Meal Plan', href: '/meal-plan', icon: 'calendar' as const },
  { name: 'Shopping', href: '/shopping', icon: 'cart' as const },
  { name: 'Settings', href: '/settings', icon: 'settings' as const },
]

const allNavigation = [
  { name: 'Recipes', href: '/recipes', icon: 'book' as const },
  { name: 'Meal Plan', href: '/meal-plan', icon: 'calendar' as const },
  { name: 'Shopping', href: '/shopping', icon: 'cart' as const },
  { name: 'Cookbooks', href: '/cookbooks', icon: 'cookbook' as const },
  { name: 'Nutrition', href: '/nutrition', icon: 'chart' as const },
  { name: 'Timers', href: '/timers', icon: 'clock' as const },
  { name: 'AI Assistant', href: '/ai-recipe-generator', icon: 'robot' as const },
  { name: 'Settings', href: '/settings', icon: 'settings' as const },
]

export function MobileLayout({ children }: MobileLayoutProps) {
  const pathname = usePathname()
  const [menuOpen, setMenuOpen] = useState(false)

  return (
    <div className="flex flex-col h-screen bg-m3-surface">
      {/* Top app bar */}
      <header className="bg-m3-surface-container border-b border-m3-outline-variant px-4 py-3 flex items-center justify-between">
        <button
          onClick={() => setMenuOpen(!menuOpen)}
          className="p-2 rounded-lg hover:bg-m3-primary-main/10 transition-colors"
        >
          <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
        <h1 className="text-xl font-bold text-m3-primary-main">Zest</h1>
        <div className="w-10" /> {/* Spacer for centering */}
      </header>

      {/* Drawer overlay */}
      {menuOpen && (
        <div
          className="fixed inset-0 bg-black/50 z-40"
          onClick={() => setMenuOpen(false)}
        />
      )}

      {/* Drawer */}
      <aside
        className={`fixed top-0 left-0 bottom-0 w-72 bg-m3-surface-container z-50 transform transition-transform duration-300 ${
          menuOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        <div className="p-4 border-b border-m3-outline-variant flex items-center justify-between">
          <h2 className="text-2xl font-bold text-m3-primary-main">Zest</h2>
          <button
            onClick={() => setMenuOpen(false)}
            className="p-2 rounded-lg hover:bg-m3-primary-main/10 transition-colors"
          >
            ✕
          </button>
        </div>
        <nav className="p-4 space-y-2">
          {allNavigation.map((item) => {
            const isActive = pathname.startsWith(item.href)
            return (
              <Link
                key={item.name}
                href={item.href}
                onClick={() => setMenuOpen(false)}
                className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-all ${
                  isActive
                    ? 'bg-m3-primary-container text-m3-on-primary-container'
                    : 'hover:bg-m3-surface-container-high text-m3-on-surface'
                }`}
              >
                <Icon name={item.icon} className="text-xl" />
                <span className="font-medium">{item.name}</span>
              </Link>
            )
          })}
        </nav>
      </aside>

      {/* Main content */}
      <main className="flex-1 overflow-y-auto pb-20">
        {children}
      </main>

      {/* Bottom navigation - only main items */}
      <nav className="fixed bottom-0 left-0 right-0 bg-m3-surface-container border-t border-m3-outline-variant">
        <div className="flex justify-around items-center h-16">
          {navigation.map((item) => {
            const isActive = pathname.startsWith(item.href)
            return (
              <Link
                key={item.name}
                href={item.href}
                className={`flex flex-col items-center justify-center flex-1 h-full transition-colors ${
                  isActive
                    ? 'text-m3-primary-main'
                    : 'text-m3-on-surface-variant'
                }`}
              >
                <Icon name={item.icon} className="text-xl mb-1" />
                <span className="text-xs font-medium">{item.name}</span>
              </Link>
            )
          })}
        </div>
      </nav>
    </div>
  )
}
