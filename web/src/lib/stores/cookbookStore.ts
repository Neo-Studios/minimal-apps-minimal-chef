import { create } from 'zustand'
import {
  getCookbooks,
  createCookbook,
  updateCookbook,
  deleteCookbook,
  addRecipeToCookbook,
  removeRecipeFromCookbook,
  Cookbook,
} from '@/lib/firebase/cookbooks'

interface CookbookState {
  cookbooks: Cookbook[]
  loading: boolean
  error: string | null
  fetchCookbooks: (userId: string) => Promise<void>
  addCookbook: (cookbook: Omit<Cookbook, 'id' | 'createdAt' | 'updatedAt'>) => Promise<void>
  updateCookbook: (id: string, updates: Partial<Cookbook>) => Promise<void>
  removeCookbook: (id: string) => Promise<void>
  addRecipe: (cookbookId: string, recipeId: string) => Promise<void>
  removeRecipe: (cookbookId: string, recipeId: string) => Promise<void>
}

export const useCookbookStore = create<CookbookState>((set, get) => ({
  cookbooks: [],
  loading: false,
  error: null,

  fetchCookbooks: async (userId: string) => {
    set({ loading: true, error: null })
    try {
      const cookbooks = await getCookbooks(userId)
      set({ cookbooks, loading: false })
    } catch (_error) {
      set({ error: 'Failed to fetch cookbooks', loading: false })
    }
  },

  addCookbook: async (cookbook) => {
    set({ loading: true, error: null })
    try {
      const id = await createCookbook(cookbook)
      if (id) {
        await get().fetchCookbooks(cookbook.userId)
      }
      set({ loading: false })
    } catch (_error) {
      set({ error: 'Failed to create cookbook', loading: false })
    }
  },

  updateCookbook: async (id, updates) => {
    set({ loading: true, error: null })
    try {
      await updateCookbook(id, updates)
      const cookbooks = get().cookbooks.map(c =>
        c.id === id ? { ...c, ...updates } : c
      )
      set({ cookbooks, loading: false })
    } catch (_error) {
      set({ error: 'Failed to update cookbook', loading: false })
    }
  },

  removeCookbook: async (id) => {
    set({ loading: true, error: null })
    try {
      await deleteCookbook(id)
      const cookbooks = get().cookbooks.filter(c => c.id !== id)
      set({ cookbooks, loading: false })
    } catch (_error) {
      set({ error: 'Failed to delete cookbook', loading: false })
    }
  },

  addRecipe: async (cookbookId, recipeId) => {
    set({ loading: true, error: null })
    try {
      await addRecipeToCookbook(cookbookId, recipeId)
      const cookbooks = get().cookbooks.map(c =>
        c.id === cookbookId
          ? { ...c, recipeIds: [...c.recipeIds, recipeId] }
          : c
      )
      set({ cookbooks, loading: false })
    } catch (_error) {
      set({ error: 'Failed to add recipe', loading: false })
    }
  },

  removeRecipe: async (cookbookId, recipeId) => {
    set({ loading: true, error: null })
    try {
      await removeRecipeFromCookbook(cookbookId, recipeId)
      const cookbooks = get().cookbooks.map(c =>
        c.id === cookbookId
          ? { ...c, recipeIds: c.recipeIds.filter(id => id !== recipeId) }
          : c
      )
      set({ cookbooks, loading: false })
    } catch (_error) {
      set({ error: 'Failed to remove recipe', loading: false })
    }
  },
}))
