import { create } from 'zustand'
import { User } from 'firebase/auth'
import { getUserProfile, setOnboardingStatus } from '../firebase/userProfile'

interface AuthState {
  user: User | null
  loading: boolean
  showOnboarding: boolean
  setUser: (user: User | null) => Promise<void>
  setLoading: (loading: boolean) => void
  completeOnboarding: (userId: string) => Promise<void>
}

export const useAuthStore = create<AuthState>((set, get) => ({
  user: null,
  loading: true,
  showOnboarding: false,
  setUser: async (user) => {
    set({ user, loading: false })
    if (user) {
      const profile = await getUserProfile(user.uid)
      set({ showOnboarding: !(profile?.hasCompletedOnboarding ?? false) })
    } else {
      set({ showOnboarding: false })
    }
  },
  setLoading: (loading) => set({ loading }),
  completeOnboarding: async (userId) => {
    await setOnboardingStatus(userId, true)
    set({ showOnboarding: false })
  },
}))
