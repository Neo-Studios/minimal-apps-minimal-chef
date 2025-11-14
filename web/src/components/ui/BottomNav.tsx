'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'

export default function BottomNav() {
  const pathname = usePathname()

  const links = [
    { href: '/recipes', label: 'Recipes' },
    { href: '/cookbooks', label: 'Cookbooks' },
    { href: '/meal-plan', label: 'Meal Plan' },
    { href: '/shopping', label: 'Shopping' },
    { href: '/settings', label: 'Settings' },
  ]

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-white border-t">
      <div className="flex justify-around p-4">
        {links.map(link => (
          <Link
            key={link.href}
            href={link.href}
            className={`text-sm ${pathname === link.href ? 'text-primary font-semibold' : 'text-gray-600'}`}
          >
            {link.label}
          </Link>
        ))}
      </div>
    </nav>
  )
}
