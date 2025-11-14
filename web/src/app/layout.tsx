import './globals.css'
import type { Metadata } from 'next'
import { ClientLayout } from '@/components/layout/ClientLayout'
import { AuthProvider } from '@/components/auth/AuthProvider'
import { ThemeProvider } from '@/components/providers/ThemeProvider'
import { SettingsProvider } from '@/components/providers/SettingsProvider'

export const metadata: Metadata = {
  title: 'Zest - Your Cooking Companion',
  description: 'Recipe management, meal planning, and smart cooking assistance',
  manifest: '/manifest.json',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <head>
        <link rel="manifest" href="/manifest.json" />
      </head>
      <body>
        {/* SVG Filters for Color Blind Modes */}
        <svg style={{ position: 'absolute', width: 0, height: 0 }} aria-hidden="true">
          <defs>
            {/* Protanopia (Red-Blind) */}
            <filter id="protanopia-filter">
              <feColorMatrix type="matrix" values="
                0.567, 0.433, 0,     0, 0
                0.558, 0.442, 0,     0, 0
                0,     0.242, 0.758, 0, 0
                0,     0,     0,     1, 0"/>
            </filter>
            
            {/* Deuteranopia (Green-Blind) */}
            <filter id="deuteranopia-filter">
              <feColorMatrix type="matrix" values="
                0.625, 0.375, 0,   0, 0
                0.7,   0.3,   0,   0, 0
                0,     0.3,   0.7, 0, 0
                0,     0,     0,   1, 0"/>
            </filter>
            
            {/* Tritanopia (Blue-Blind) */}
            <filter id="tritanopia-filter">
              <feColorMatrix type="matrix" values="
                0.95, 0.05,  0,     0, 0
                0,    0.433, 0.567, 0, 0
                0,    0.475, 0.525, 0, 0
                0,    0,     0,     1, 0"/>
            </filter>
          </defs>
        </svg>
        
        <AuthProvider>
          <ThemeProvider>
            <SettingsProvider>
              <ClientLayout>{children}</ClientLayout>
            </SettingsProvider>
          </ThemeProvider>
        </AuthProvider>
      </body>
    </html>
  )
}
