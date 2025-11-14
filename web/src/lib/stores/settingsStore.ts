import { create } from 'zustand'
import { persist } from 'zustand/middleware'

export type FontSize = 'small' | 'medium' | 'large' | 'xlarge'
export type ColorBlindMode = 'none' | 'protanopia' | 'deuteranopia' | 'tritanopia'
export type Language = 'en' | 'es' | 'fr' | 'de' | 'ja' | 'zh' | 'ko' | 'pt' | 'it' | 'ru' | 'ar' | 'hi'

interface SettingsState {
  // Appearance
  fontSize: FontSize
  reducedMotion: boolean
  highContrast: boolean
  colorBlindMode: ColorBlindMode
  
  // Accessibility
  screenReader: boolean
  
  // General
  notifications: boolean
  offlineMode: boolean
  language: Language
  
  // Actions
  setFontSize: (size: FontSize) => void
  setReducedMotion: (enabled: boolean) => void
  setHighContrast: (enabled: boolean) => void
  setColorBlindMode: (mode: ColorBlindMode) => void
  setScreenReader: (enabled: boolean) => void
  setNotifications: (enabled: boolean) => void
  setOfflineMode: (enabled: boolean) => void
  setLanguage: (lang: Language) => void
}

export const useSettingsStore = create<SettingsState>()(
  persist(
    (set) => ({
      // Defaults
      fontSize: 'medium',
      reducedMotion: false,
      highContrast: false,
      colorBlindMode: 'none',
      screenReader: false,
      notifications: true,
      offlineMode: true,
      language: 'en',
      
      // Actions
      setFontSize: (fontSize) => set({ fontSize }),
      setReducedMotion: (reducedMotion) => set({ reducedMotion }),
      setHighContrast: (highContrast) => set({ highContrast }),
      setColorBlindMode: (colorBlindMode) => set({ colorBlindMode }),
      setScreenReader: (screenReader) => set({ screenReader }),
      setNotifications: (notifications) => set({ notifications }),
      setOfflineMode: (offlineMode) => set({ offlineMode }),
      setLanguage: (language) => set({ language }),
    }),
    {
      name: 'settings-storage',
    }
  )
)
