'use client'

import React, { useState, useEffect } from 'react'
import { Material3Card } from '@/components/ui/Material3Card'
import { Material3Button } from '@/components/ui/Material3Button'
import { Material3FAB } from '@/components/ui/Material3FAB'
import { SearchBar } from '@/components/ui/SearchBar'
import { useIsTablet } from '@/lib/hooks/useMediaQuery'
import Link from 'next/link'
import { Icon } from '@/components/ui/Icon'
import { collection, getDocs, query, where } from 'firebase/firestore'
import { db } from '@/lib/firebase/config'
import { useAuthStore } from '@/lib/stores/authStore'
import { useTranslation } from '@/components/providers/TranslationProvider'

interface Recipe {
  id: string
  name: string
  cuisine: string
  time: number
  servings: number
  difficulty: 'Easy' | 'Medium' | 'Hard'
  image?: string
  rating: number
  userId: string // Assuming recipes are associated with a user
}

export default function RecipesPage() {
  const { user } = useAuthStore()
  const { t } = useTranslation()
  const [recipes, setRecipes] = useState<Recipe[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedCuisine, setSelectedCuisine] = useState<string>('All')
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid')
  const [scrollY, setScrollY] = useState(0)
  const isTablet = useIsTablet()

  useEffect(() => {
    const fetchRecipes = async () => {
      if (!user) {
        setLoading(false)
        setError('User not logged in.')
        return
      }

      setLoading(true)
      setError(null)
      try {
        const q = query(collection(db, 'recipes'), where('userId', '==', user.uid))
        const querySnapshot = await getDocs(q)
        const fetchedRecipes: Recipe[] = querySnapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data() as Omit<Recipe, 'id'>
        }))
        setRecipes(fetchedRecipes)
      } catch (err: any) {
        console.error('Error fetching recipes:', err)
        setError(err.message || 'Failed to fetch recipes.')
      } finally {
        setLoading(false)
      }
    }

    fetchRecipes()
  }, [user])

  useEffect(() => {
    const handleScroll = () => {
      setScrollY(window.scrollY)
    }

    window.addEventListener('scroll', handleScroll)
    return () => {
      window.removeEventListener('scroll', handleScroll)
    }
  }, [])

  const scale = Math.max(0.8, 1 - scrollY / 300) // Shrink to 80%
  const translateY = scrollY > 0 ? Math.sin(scrollY / 50) * 5 : 0 // Bounce effect

  const cuisines = ['All', ...Array.from(new Set(recipes.map(r => r.cuisine)))]
  
  const filteredRecipes = recipes.filter(recipe => {
    const matchesSearch = recipe.name.toLowerCase().includes(searchQuery.toLowerCase())
    const matchesCuisine = selectedCuisine === 'All' || recipe.cuisine === selectedCuisine
    return matchesSearch && matchesCuisine
  })

  if (loading) {
    return (
      <div className="p-4 md:p-8 text-center">
        <p>{t('recipes.loading')}</p>
      </div>
    )
  }

  if (error) {
    return (
      <div className="p-4 md:p-8 text-center text-red-500">
        <p>{t('recipes.error')}: {error}</p>
      </div>
    )
  }

  return (
    <div className="p-4 md:p-8 space-y-6 pb-24 md:pb-8">
      {/* Header */}
      <div className="flex items-center justify-between flex-wrap gap-4">
        <div>
          <h1 
            className="text-4xl font-normal text-m3-on-surface mb-2 origin-top-left"
            style={{ 
              transform: `scale(${scale}) translateY(${translateY}px)`,
              transition: 'transform 0.1s ease-out' // Smooth transition for scale and bounce
            }}
          >
            {t('recipes.title')}
          </h1>
          <p className="text-m3-on-surface-variant">
            {t('recipes.count', { count: filteredRecipes.length })}
          </p>
        </div>
        {isTablet && (
          <Link href="/recipes/new">
            <Material3Button
              variant="filled"
              icon={
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                </svg>
              }
            >
              {t('recipes.newRecipe')}
            </Material3Button>
          </Link>
        )}
      </div>

      {/* Search and filters */}
      <div className="space-y-4">
        <SearchBar
          value={searchQuery}
          onChange={setSearchQuery}
          placeholder={t('recipes.searchPlaceholder')}
        />
        
        <div className="flex items-center gap-2 overflow-x-auto pb-2">
          {cuisines.map((cuisine) => (
            <Material3Button
              key={cuisine}
              variant={selectedCuisine === cuisine ? 'filled' : 'outlined'}
              size="small"
              onClick={() => setSelectedCuisine(cuisine)}
            >
              {cuisine === 'All' ? t('recipes.allCuisines') : cuisine}
            </Material3Button>
          ))}
          
          <div className="ml-auto flex gap-2">
            <button
              onClick={() => setViewMode('grid')}
              className={`p-2 rounded-lg transition-colors ${
                viewMode === 'grid' 
                  ? 'bg-m3-primary-container text-m3-on-primary-container' 
                  : 'hover:bg-m3-surface-container-high'
              }`}
            >
              <Icon name="chart" />
            </button>
            <button
              onClick={() => setViewMode('list')}
              className={`p-2 rounded-lg transition-colors ${
                viewMode === 'list' 
                  ? 'bg-m3-primary-container text-m3-on-primary-container' 
                  : 'hover:bg-m3-surface-container-high'
              }`}
            >
              <Icon name="book" />
            </button>
          </div>
        </div>
      </div>

      {/* Recipes grid/list */}
      {filteredRecipes.length === 0 ? (
        <Material3Card variant="outlined">
          <div className="p-12 text-center">
            <span className="text-6xl mb-4 block">🔍</span>
            <h3 className="text-xl font-medium text-m3-on-surface mb-2">
              {t('recipes.noRecipesFound')}
            </h3>
            <p className="text-m3-on-surface-variant mb-4">
              {t('recipes.adjustFilters')}
            </p>
            <Material3Button variant="tonal" onClick={() => {
              setSearchQuery('')
              setSelectedCuisine('All')
            }}>
              {t('recipes.clearFilters')}
            </Material3Button>
          </div>
        </Material3Card>
      ) : (
        <div className={
          viewMode === 'grid' 
            ? 'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4'
            : 'space-y-4'
        }>
          {filteredRecipes.map((recipe) => (
            <Material3Card key={recipe.id} variant="elevated" interactive>
              <Link href={`/recipes/${recipe.id}`}>
                <div className="p-6 space-y-3">
                  {/* Recipe image placeholder */}
                  <div className="w-full h-40 bg-gradient-to-br from-m3-primary-main/20 to-m3-secondary-main/20 rounded-lg flex items-center justify-center">
                    <Icon name="utensils" size="6x" />
                  </div>
                  
                  {/* Recipe info */}
                  <div>
                    <div className="flex items-start justify-between gap-2 mb-2">
                      <h3 className="text-lg font-semibold text-m3-on-surface line-clamp-2">
                        {recipe.name}
                      </h3>
                      <span className={`px-2 py-1 rounded-full text-xs font-medium whitespace-nowrap ${
                        recipe.difficulty === 'Easy' 
                          ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200'
                          : recipe.difficulty === 'Medium'
                          ? 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200'
                          : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200'
                      }`}>
                        {t(`recipes.difficulty.${recipe.difficulty.toLowerCase()}`)}
                      </span>
                    </div>
                    
                    <p className="text-sm text-m3-on-surface-variant mb-3">
                      {recipe.cuisine}
                    </p>
                    
                    <div className="flex items-center gap-4 text-sm text-m3-on-surface-variant">
                      <span className="flex items-center gap-1">
                        <Icon name="clock" /> {recipe.time}m
                      </span>
                      <span className="flex items-center gap-1">
                        👥 {recipe.servings}
                      </span>
                      <span className="flex items-center gap-1">
                        ⭐ {recipe.rating}
                      </span>
                    </div>
                  </div>
                </div>
              </Link>
            </Material3Card>
          ))}
        </div>
      )}

      {/* Floating Action Button (Mobile only) */}
      {!isTablet && (
        <div className="fixed bottom-20 right-4 z-10">
          <Link href="/recipes/new">
            <Material3FAB
              icon={
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                </svg>
              }
              onClick={() => {}}
            />
          </Link>
        </div>
      )}
    </div>
  )
}