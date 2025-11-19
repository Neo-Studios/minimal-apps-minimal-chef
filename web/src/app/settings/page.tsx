'use client'

import { useAuthStore } from '@/lib/stores/authStore'
import { useThemeStore } from '@/lib/stores/themeStore'
import { useSettingsStore, Language, FontSize, ColorBlindMode } from '@/lib/stores/settingsStore'
import { signOut } from '@/lib/firebase/auth'
import { useRouter } from 'next/navigation'
import { useTranslation } from '@/components/providers/TranslationProvider'

export default function SettingsPage() {
  const router = useRouter()
  const { user } = useAuthStore()
  const { theme, setTheme } = useThemeStore()
  const { t } = useTranslation()
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
      <h1 className="text-3xl font-bold mb-8">{t('settings.title')}</h1>
      
      <div className="space-y-6 max-w-2xl">
        {/* General */}
        <section className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm">
          <h2 className="text-xl font-semibold mb-4">{t('settings.general')}</h2>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.theme')}</label>
              <select
                value={theme}
                onChange={(e) => setTheme(e.target.value as any)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="light">{t('settings.theme.light')}</option>
                <option value="dark">{t('settings.theme.dark')}</option>
                <option value="system">{t('settings.theme.automatic')}</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('general.language')}</label>
              <select
                value={language}
                onChange={(e) => setLanguage(e.target.value as Language)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="en">{t('language.en')}</option>
                <option value="es">{t('language.es')}</option>
                <option value="fr">{t('language.fr')}</option>
                <option value="de">{t('language.de')}</option>
                <option value="ja">{t('language.ja')}</option>
                <option value="zh">{t('language.zh')}</option>
                <option value="ko">{t('language.ko')}</option>
                <option value="pt">{t('language.pt')}</option>
                <option value="it">{t('language.it')}</option>
                <option value="ru">{t('language.ru')}</option>
                <option value="ar">{t('language.ar')}</option>
                <option value="hi">{t('language.hi')}</option>
                <option value="nl">{t('language.nl')}</option>
                <option value="sv">{t('language.sv')}</option>
                <option value="pl">{t('language.pl')}</option>
                <option value="tr">{t('language.tr')}</option>
                <option value="vi">{t('language.vi')}</option>
                <option value="th">{t('language.th')}</option>
                <option value="id">{t('language.id')}</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.notifications')}</label>
              <input
                type="checkbox"
                checked={notifications}
                onChange={(e) => setNotifications(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.offlineMode')}</label>
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
          <h2 className="text-xl font-semibold mb-4">{t('settings.accessibility')}</h2>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.fontSize')}</label>
              <select
                value={fontSize}
                onChange={(e) => setFontSize(e.target.value as FontSize)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="small">{t('settings.fontSize.small')}</option>
                <option value="medium">{t('settings.fontSize.medium')}</option>
                <option value="large">{t('settings.fontSize.large')}</option>
                <option value="xlarge">{t('settings.fontSize.xlarge')}</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.reduceMotion')}</label>
              <input
                type="checkbox"
                checked={reducedMotion}
                onChange={(e) => setReducedMotion(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.highContrast')}</label>
              <input
                type="checkbox"
                checked={highContrast}
                onChange={(e) => setHighContrast(e.target.checked)}
                className="w-5 h-5"
              />
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.colorBlindMode')}</label>
              <select
                value={colorBlindMode}
                onChange={(e) => setColorBlindMode(e.target.value as ColorBlindMode)}
                className="p-2 border rounded-lg bg-white dark:bg-gray-700"
              >
                <option value="none">{t('settings.colorBlindMode.none')}</option>
                <option value="protanopia">{t('settings.colorBlindMode.protanopia')}</option>
                <option value="deuteranopia">{t('settings.colorBlindMode.deuteranopia')}</option>
                <option value="tritanopia">{t('settings.colorBlindMode.tritanopia')}</option>
              </select>
            </div>
            <div className="flex items-center justify-between">
              <label className="font-medium">{t('settings.screenReaderOptimized')}</label>
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
          <h2 className="text-xl font-semibold mb-4">{t('settings.account')}</h2>
          <div className="space-y-4">
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">{t('settings.account.name')}</p>
              <p className="font-medium">{user?.displayName}</p>
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">{t('settings.account.email')}</p>
              <p className="font-medium">{user?.email}</p>
            </div>
            <button
              onClick={async () => {
                await signOut()
                router.push('/login')
              }}
              className="w-full bg-red-500 text-white px-6 py-3 rounded-lg font-medium hover:bg-red-600 transition"
            >
              {t('settings.account.signOut')}
            </button>
          </div>
        </section>

        {/* About */}
        <section className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm">
          <h2 className="text-xl font-semibold mb-4">{t('settings.about')}</h2>
          <div className="space-y-3">
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">{t('settings.about.version')}</p>
              <p className="font-medium">0.5.0</p>
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">{t('settings.about.developer')}</p>
              <p className="font-medium">Neo Studios</p>
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">{t('settings.about.license')}</p>
              <p className="font-medium">Neo Studios Public Repository License</p>
            </div>
          </div>
        </section>
      </div>
    </main>
  )
}
