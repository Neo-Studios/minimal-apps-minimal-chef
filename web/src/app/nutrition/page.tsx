'use client'

import React, { useState, useEffect } from 'react'
import { useAuth } from '@/lib/hooks/useAuth'
import { getDailyNutrition, getWeeklyNutrition, logRecipeNutrition, DailyNutrition } from '@/lib/firebase/nutrition'
import { getRecipes, Recipe } from '@/lib/firebase/recipes'
import { Material3Card } from '@/components/ui/Material3Card'
import { Material3Button } from '@/components/ui/Material3Button'
import { Icon } from '@/components/ui/Icon'

export default function NutritionPage() {
  const { user } = useAuth()
  const [selectedPeriod, setSelectedPeriod] = useState<'day' | 'week'>('day')
  const [selectedDate, setSelectedDate] = useState(new Date())
  const [dailyData, setDailyData] = useState<DailyNutrition | null>(null)
  const [weeklyData, setWeeklyData] = useState<DailyNutrition[]>([])
  const [recipes, setRecipes] = useState<Recipe[]>([])
  const [loading, setLoading] = useState(true)
  const [showLogDialog, setShowLogDialog] = useState(false)

  const dateKey = selectedDate.toISOString().split('T')[0]

  useEffect(() => {
    if (user) {
      loadData()
    }
  }, [user, selectedDate, selectedPeriod, loadData])

  const loadData = async () => {
    if (!user) return
    
    setLoading(true)
    try {
      if (selectedPeriod === 'day') {
        const data = await getDailyNutrition(user.uid, dateKey)
        setDailyData(data)
      } else {
        // Get start of week (Monday)
        const startOfWeek = new Date(selectedDate)
        const day = startOfWeek.getDay()
        const diff = startOfWeek.getDate() - day + (day === 0 ? -6 : 1)
        startOfWeek.setDate(diff)
        
        const data = await getWeeklyNutrition(user.uid, startOfWeek.toISOString().split('T')[0])
        setWeeklyData(data)
      }
      
      // Load recipes for logging
      const userRecipes = await getRecipes(user.uid)
      setRecipes(userRecipes.filter(r => r.nutrition))
    } catch (error) {
      console.error('Error loading nutrition data:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleLogRecipe = async (recipe: Recipe, servings: number) => {
    if (!user || !recipe.nutrition || !recipe.id) return
    
    const success = await logRecipeNutrition(
      user.uid,
      dateKey,
      recipe.id,
      recipe.name,
      recipe.nutrition,
      servings
    )
    
    if (success) {
      setShowLogDialog(false)
      await loadData()
    }
  }

  const changeDate = (days: number) => {
    const newDate = new Date(selectedDate)
    newDate.setDate(newDate.getDate() + days)
    setSelectedDate(newDate)
  }

  const nutritionData = selectedPeriod === 'day' && dailyData ? {
    calories: Math.round(dailyData.calories),
    protein: Math.round(dailyData.protein),
    carbs: Math.round(dailyData.carbs),
    fat: Math.round(dailyData.fat),
  } : {
    calories: Math.round(weeklyData.reduce((sum, day) => sum + day.calories, 0) / 7),
    protein: Math.round(weeklyData.reduce((sum, day) => sum + day.protein, 0) / 7),
    carbs: Math.round(weeklyData.reduce((sum, day) => sum + day.carbs, 0) / 7),
    fat: Math.round(weeklyData.reduce((sum, day) => sum + day.fat, 0) / 7),
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading nutrition data...</p>
        </div>
      </div>
    )
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-3xl font-bold">Nutrition Tracking</h1>
        <button
          onClick={() => setShowLogDialog(true)}
          className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition"
        >
          + Log Food
        </button>
      </div>

      {/* Period Selector */}
      <div className="flex gap-2 mb-6">
        <Material3Button
          variant={selectedPeriod === 'day' ? 'filled' : 'outlined'}
          onClick={() => setSelectedPeriod('day')}
        >
          Day
        </Material3Button>
        <Material3Button
          variant={selectedPeriod === 'week' ? 'filled' : 'outlined'}
          onClick={() => setSelectedPeriod('week')}
        >
          Week
        </Material3Button>
      </div>

      {/* Date Navigator */}
      <div className="flex items-center justify-between mb-6 bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm">
        <button
          onClick={() => changeDate(selectedPeriod === 'day' ? -1 : -7)}
          className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition"
        >
          ←
        </button>
        <div className="text-center">
          <h2 className="text-xl font-semibold">
            {selectedDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}
          </h2>
          <button
            onClick={() => setSelectedDate(new Date())}
            className="text-sm text-primary hover:underline mt-1"
          >
            Today
          </button>
        </div>
        <button
          onClick={() => changeDate(selectedPeriod === 'day' ? 1 : 7)}
          className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition"
        >
          →
        </button>
      </div>

      {/* Nutrition Summary */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
        {Object.entries(nutritionData).map(([key, value]) => (
          <Material3Card key={key} variant="elevated">
            <div className="p-6 text-center">
              <div className="flex items-center justify-center gap-2 mb-2">
                <h3 className="text-sm font-medium text-m3-on-surface-variant uppercase">
                  {key}
                </h3>
                <Icon 
                  name={key === 'calories' ? 'fire' : key === 'protein' ? 'meat' : key === 'carbs' ? 'bread' : 'vegetable'} 
                  className="text-2xl"
                />
              </div>
              <p className="text-3xl font-bold text-m3-primary-main">{value}</p>
              <p className="text-xs text-m3-on-surface-variant mt-1">
                {key === 'calories' ? 'kcal' : 'g'}
              </p>
            </div>
          </Material3Card>
        ))}
      </div>

      {/* Daily Entries */}
      {selectedPeriod === 'day' && dailyData && (
        <Material3Card variant="outlined">
          <div className="p-6">
            <h3 className="text-xl font-semibold mb-4">Today's Entries</h3>
            {dailyData.entries.length > 0 ? (
              <div className="space-y-2">
                {dailyData.entries.map((entry, index) => (
                  <div key={entry.id || index} className="p-4 bg-gray-50 dark:bg-gray-700 rounded-lg">
                    <div className="font-semibold">{entry.recipeName || 'Food Entry'}</div>
                    <div className="text-sm text-gray-600 dark:text-gray-400 mt-1">
                      {Math.round(entry.calories * entry.servings)} cal • 
                      {Math.round(entry.protein * entry.servings)}g protein • 
                      {Math.round(entry.carbs * entry.servings)}g carbs • 
                      {Math.round(entry.fat * entry.servings)}g fat
                      {entry.servings > 1 && ` • ${entry.servings} servings`}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-center text-gray-500 py-8">No entries logged today</p>
            )}
          </div>
        </Material3Card>
      )}

      {/* Weekly Chart */}
      {selectedPeriod === 'week' && weeklyData.length > 0 && (
        <Material3Card variant="outlined">
          <div className="p-6">
            <h3 className="text-xl font-semibold mb-4">Weekly Overview</h3>
            <div className="space-y-3">
              {weeklyData.map((day) => (
                <div key={day.date} className="flex items-center gap-4">
                  <div className="w-24 text-sm font-medium">
                    {new Date(day.date).toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' })}
                  </div>
                  <div className="flex-1 bg-gray-200 dark:bg-gray-700 rounded-full h-8 relative overflow-hidden">
                    <div
                      className="bg-primary h-full rounded-full flex items-center justify-end pr-2"
                      style={{ width: `${Math.min((day.calories / 2500) * 100, 100)}%` }}
                    >
                      <span className="text-xs font-semibold text-white">
                        {Math.round(day.calories)} cal
                      </span>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </Material3Card>
      )}

      {/* Log Food Dialog */}
      {showLogDialog && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white dark:bg-gray-800 rounded-lg max-w-2xl w-full max-h-[80vh] overflow-hidden flex flex-col">
            <div className="p-6 border-b border-gray-200 dark:border-gray-700">
              <div className="flex items-center justify-between">
                <h2 className="text-2xl font-bold">Log Food</h2>
                <button
                  onClick={() => setShowLogDialog(false)}
                  className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition"
                >
                  ✕
                </button>
              </div>
            </div>
            
            <div className="flex-1 overflow-y-auto p-6">
              {recipes.length > 0 ? (
                <div className="space-y-2">
                  {recipes.map(recipe => (
                    <div
                      key={recipe.id}
                      className="p-4 border border-gray-200 dark:border-gray-700 rounded-lg"
                    >
                      <div className="font-semibold mb-2">{recipe.name}</div>
                      <div className="text-sm text-gray-600 dark:text-gray-400 mb-3">
                        {recipe.nutrition?.calories} cal • {recipe.nutrition?.protein}g protein
                      </div>
                      <div className="flex gap-2">
                        <button
                          onClick={() => handleLogRecipe(recipe, 1)}
                          className="flex-1 bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition text-sm"
                        >
                          Log 1 Serving
                        </button>
                        <button
                          onClick={() => handleLogRecipe(recipe, 0.5)}
                          className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700 transition text-sm"
                        >
                          0.5x
                        </button>
                        <button
                          onClick={() => handleLogRecipe(recipe, 2)}
                          className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700 transition text-sm"
                        >
                          2x
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="text-center py-12">
                  <Icon name="utensils" size="3x" className="mx-auto mb-4 text-gray-400" />
                  <p className="text-gray-600 dark:text-gray-400 mb-4">
                    No recipes with nutrition info found
                  </p>
                  <p className="text-sm text-gray-500">
                    Add nutrition information to your recipes to track them here
                  </p>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </main>
  )
}
