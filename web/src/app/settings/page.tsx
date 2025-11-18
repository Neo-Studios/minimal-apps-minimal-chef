'use client'

import { useAuthStore } from '@/lib/stores/authStore'
import { useThemeStore } from '@/lib/stores/themeStore'
import { useSettingsStore, Language, FontSize, ColorBlindMode } from '@/lib/stores/settingsStore'
import { signOut } from '@/lib/firebase/auth'
import { useRouter } from 'next/navigation'

export default function SettingsPage() {
  const router = useRouter()
  const { user } = useAuthStore()
  const { theme, setTheme } = useThemeStore()
  const {
    fontSize,
    setFontSize,
    notifications,
    setNotifications,
    reducedMotion,
    setReducedMotion,
    highContrast,
    setHighContrast,
    colorBlindMode,
    setColorBlindMode,
    screenReader,
    setScreenReader,
    language,
    setLanguage,
    offlineMode,
    setOfflineMode,
  } = useSettingsStore()

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-3xl font-bold mb-8">Settings</h1>
      
      <div className="space-y-6 max-w-2xl">
        {/* General */}
        <section className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm">
          <h2 className="text-xl font-semibold mb-4">General</h2>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="font-medium">Theme</label>
              <select
                value={theme}
                onChange={(e) => setTheme(e.target.value as any)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="light">Light</option>
                <option value="dark">Dark</option>
                <option value="system">Automatic</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">Language</label>
              <select
                value={language}
                onChange={(e) => setLanguage(e.target.value as Language)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="en">English</option>
                <option value="es">Español</option>
                <option value="fr">Français</option>
                <option value="de">Deutsch</option>
                <option value="ja">日本語</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">Notifications</label>
              <input
                type="checkbox"
                checked={notifications}
                onChange={(e) => setNotifications(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">Offline Mode</label>
              <input
                type="checkbox"
                checked={offlineMode}
                onChange={(e) => setOfflineMode(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
          </div>
        </section>

        {/* Accessibility */}
        <section className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm">
          <h2 className="text-xl font-semibold mb-4">Accessibility</h2>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="font-medium">Font Size</label>
              <select
                value={fontSize}
                onChange={(e) => setFontSize(e.target.value as FontSize)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="small">Small</option>
                <option value="medium">Medium</option>
                <option value="large">Large</option>
                <option value="xlarge">Extra Large</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">Reduce Motion</label>
              <input
                type="checkbox"
                checked={reducedMotion}
                onChange={(e) => setReducedMotion(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">High Contrast</label>
              <input
                type="checkbox"
                checked={highContrast}
                onChange={(e) => setHighContrast(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">Color Blind Mode</label>
              <select
                value={colorBlindMode}
                onChange={(e) => setColorBlindMode(e.target.value as ColorBlindMode)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="none">None</option>
                <option value="protanopia">Protanopia (Red-Blind)</option>
                <option value="deuteranopia">Deuteranopia (Green-Blind)</option>
                <option value="tritanopia">Tritanopia (Blue-Blind)</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">Screen Reader Optimized</label>
              <input
                type="checkbox"
                checked={screenReader}
                onChange={(e) => setScreenReader(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
          </div>
        </section>

        {/* Account */}
        <section className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm">
          <h2 className="text-xl font-semibold mb-4">Account</h2>
          <div className="space-y-4">
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">Name</p>
              <p className="font-medium">{user?.displayName}</p>
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">Email</p>
              <p className="font-medium">{user?.email}</p>
            </div>
            <button
              onClick={async () => {
                await signOut()
                router.push('/login')
              }}
              className="w-full bg-red-500 text-white px-6 py-3 rounded-lg font-medium hover:bg-red-600 transition"
            >
              Sign Out
            </button>
          </div>
        </section>

        {/* About */}
        <section className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm">
          <h2 className="text-xl font-semibold mb-4">About</h2>
          <div className="space-y-3">
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">Version</p>
              <p className="font-medium">0.5.0</p>
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">Developer</p>
              <p className="font-medium">Neo Studios</p>
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">License</p>
              <p className="font-medium">Neo Studios Public Repository License</p>
            </div>
          </div>
        </section>
      </div>
    </main>
  )
}
