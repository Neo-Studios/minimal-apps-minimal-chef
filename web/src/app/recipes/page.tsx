'use client'

import React, { useState, useEffect } from 'react'
import { Material3Card } from '@/components/ui/Material3Card'
import { Material3Button } from '@/components/ui/Material3Button'
import { Material3FAB } from '@/components/ui/Material3FAB'
import { SearchBar } from '@/components/ui/SearchBar'
import { useIsTablet } from '@/lib/hooks/useMediaQuery'
import Link from 'next/link'
import { Icon } from '@/components/ui/Icon'

interface Recipe {
  id: string
  name: string
  cuisine: string
  time: number
  servings: number
  difficulty: 'Easy' | 'Medium' | 'Hard'
  image?: string
  rating: number
}

const SAMPLE_RECIPES: Recipe[] = [
  { id: '1', name: 'Spaghetti Carbonara', cuisine: 'Italian', time: 30, servings: 4, difficulty: 'Medium', rating: 4.5 },
  { id: '2', name: 'Chicken Tikka Masala', cuisine: 'Indian', time: 45, servings: 6, difficulty: 'Medium', rating: 4.8 },
  { id: '3', name: 'Caesar Salad', cuisine: 'American', time: 15, servings: 2, difficulty: 'Easy', rating: 4.2 },
  { id: '4', name: 'Pad Thai', cuisine: 'Thai', time: 25, servings: 2, difficulty: 'Medium', rating: 4.6 },
  { id: '5', name: 'Beef Tacos', cuisine: 'Mexican', time: 20, servings: 4, difficulty: 'Easy', rating: 4.4 },
  { id: '6', name: 'Sushi Rolls', cuisine: 'Japanese', time: 60, servings: 4, difficulty: 'Hard', rating: 4.9 },
]

export default function RecipesPage() {
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedCuisine, setSelectedCuisine] = useState<string>('All')
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid')
  const [scrollY, setScrollY] = useState(0)
  const isTablet = useIsTablet()

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

  const cuisines = ['All', ...Array.from(new Set(SAMPLE_RECIPES.map(r => r.cuisine)))]
  
  const filteredRecipes = SAMPLE_RECIPES.filter(recipe => {
    const matchesSearch = recipe.name.toLowerCase().includes(searchQuery.toLowerCase())
    const matchesCuisine = selectedCuisine === 'All' || recipe.cuisine === selectedCuisine
    return matchesSearch && matchesCuisine
  })

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
            Recipes
          </h1>
          <p className="text-m3-on-surface-variant">
            {filteredRecipes.length} recipes available
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
              New Recipe
            </Material3Button>
          </Link>
        )}
      </div>

      {/* Search and filters */}
      <div className="space-y-4">
        <SearchBar
          value={searchQuery}
          onChange={setSearchQuery}
          placeholder="Search recipes..."
        />
        
        <div className="flex items-center gap-2 overflow-x-auto pb-2">
          {cuisines.map((cuisine) => (
            <Material3Button
              key={cuisine}
              variant={selectedCuisine === cuisine ? 'filled' : 'outlined'}
              size="small"
              onClick={() => setSelectedCuisine(cuisine)}
            >
              {cuisine}
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
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
              </svg>
            </button>
            <button
              onClick={() => setViewMode('list')}
              className={`p-2 rounded-lg transition-colors ${
                viewMode === 'list' 
                  ? 'bg-m3-primary-container text-m3-on-primary-container' 
                  : 'hover:bg-m3-surface-container-high'
              }`}
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              </svg>
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
              No recipes found
            </h3>
            <p className="text-m3-on-surface-variant mb-4">
              Try adjusting your search or filters
            </p>
            <Material3Button variant="tonal" onClick={() => {
              setSearchQuery('')
              setSelectedCuisine('All')
            }}>
              Clear Filters
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
                        {recipe.difficulty}
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
