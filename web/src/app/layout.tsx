'use client'

import './globals.css'
import useNotifications from '@/hooks/useNotifications'
import useInstallPrompt from '@/hooks/useInstallPrompt'
import BottomNav from '@/components/ui/BottomNav'

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  useNotifications()
  const { showInstallPrompt, handleInstall } = useInstallPrompt()

  return (
    <html lang="en">
      <head>
        <link rel="manifest" href="/manifest.json" />
        <link rel="preconnect" href="https://firebasestorage.googleapis.com" />
        <link rel="dns-prefetch" href="https://firebasestorage.googleapis.com" />
      </head>
      <body>
        {children}
        {showInstallPrompt && (
          <button
            onClick={handleInstall}
            className="fixed bottom-20 right-4 bg-primary text-white p-3 rounded-full shadow-lg"
          >
            Install App
          </button>
        )}
        <BottomNav />
      </body>
    </html>
  )
}
