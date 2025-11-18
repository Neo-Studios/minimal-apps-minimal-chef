'use client'

import { useState, useEffect, useCallback } from 'react'
import { useAuth } from '@/lib/hooks/useAuth'
import { getMealPlans, addMealToDate, removeMealFromDate, MealPlan } from '@/lib/firebase/mealPlans'
import { getRecipes, Recipe } from '@/lib/firebase/recipes'
import { Icon } from '@/components/ui/Icon'

export default function MealPlanPage() {
  const { user } = useAuth()
  const [selectedDate, setSelectedDate] = useState(new Date())
  const [mealPlans, setMealPlans] = useState<Record<string, MealPlan>>({})
  const [recipes, setRecipes] = useState<Recipe[]>([])
  const [loading, setLoading] = useState(true)
  const [showRecipeSelector, setShowRecipeSelector] = useState(false)
  const [selectedMealType, setSelectedMealType] = useState<'breakfast' | 'lunch' | 'dinner' | 'snacks'>('breakfast')

  const dateKey = selectedDate.toISOString().split('T')[0]
  const currentPlan = mealPlans[dateKey]

  const loadData = useCallback(async () => {
    if (!user) return
    
    setLoading(true)
    try {
      // Load meal plans for current week
      const startDate = new Date(selectedDate)
      startDate.setDate(startDate.getDate() - 3)
      const endDate = new Date(selectedDate)
      endDate.setDate(endDate.getDate() + 3)
      
      const plans = await getMealPlans(
        user.uid,
        startDate.toISOString().split('T')[0],
        endDate.toISOString().split('T')[0]
      )
      
      // Convert to map
      const plansMap: Record<string, MealPlan> = {}
      plans.forEach(plan => {
        if (plan.date) {
          plansMap[plan.date] = plan
        }
      })
      setMealPlans(plansMap)
      
      // Load user's recipes
      const userRecipes = await getRecipes(user.uid)
      setRecipes(userRecipes)
    } catch (error) {
      console.error('Error loading meal plan data:', error)
    } finally {
      setLoading(false)
    }
  }, [user, selectedDate])

  useEffect(() => {
    if (user) {
      loadData()
    }
  }, [user, selectedDate, loadData])

  const handleAddMeal = async (recipeId: string) => {
    if (!user) return
    
    const success = await addMealToDate(user.uid, dateKey, selectedMealType, recipeId)
    if (success) {
      await loadData()
      setShowRecipeSelector(false)
    }
  }

  const handleRemoveMeal = async (mealType: 'breakfast' | 'lunch' | 'dinner' | 'snacks', recipeId: string) => {
    if (!user) return
    
    const success = await removeMealFromDate(user.uid, dateKey, mealType, recipeId)
    if (success) {
      await loadData()
    }
  }

  const openRecipeSelector = (mealType: 'breakfast' | 'lunch' | 'dinner' | 'snacks') => {
    setSelectedMealType(mealType)
    setShowRecipeSelector(true)
  }

  const getRecipeName = (recipeId: string) => {
    const recipe = recipes.find(r => r.id === recipeId)
    return recipe?.name || 'Unknown Recipe'
  }

  const changeDate = (days: number) => {
    const newDate = new Date(selectedDate)
    newDate.setDate(newDate.getDate() + days)
    setSelectedDate(newDate)
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading meal plan...</p>
        </div>
      </div>
    )
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-3xl font-bold mb-6">Meal Plan</h1>
      
      {/* Date Navigator */}
      <div className="flex items-center justify-between mb-6 bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm">
        <button
          onClick={() => changeDate(-1)}
          className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition"
        >
          ←
        </button>
        <div className="text-center">
          <h2 className="text-xl font-semibold">
            {selectedDate.toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}
          </h2>
          <button
            onClick={() => setSelectedDate(new Date())}
            className="text-sm text-primary hover:underline mt-1"
          >
            Today
          </button>
        </div>
        <button
          onClick={() => changeDate(1)}
          className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition"
        >
          →
        </button>
      </div>

      {/* Meal Sections */}
      <div className="space-y-6">
        {(['breakfast', 'lunch', 'dinner', 'snacks'] as const).map(mealType => (
          <div key={mealType} className="bg-white dark:bg-gray-800 rounded-lg p-6 shadow-sm">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-xl font-semibold capitalize">{mealType}</h3>
              <button
                onClick={() => openRecipeSelector(mealType)}
                className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition text-sm"
              >
                + Add Recipe
              </button>
            </div>
            
            <div className="space-y-2">
              {currentPlan?.meals[mealType]?.length ? (
                currentPlan.meals[mealType]!.map((recipeId, index) => (
                  <div
                    key={`${recipeId}-${index}`}
                    className="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-700 rounded-lg"
                  >
                    <span className="font-medium">{getRecipeName(recipeId)}</span>
                    <button
                      onClick={() => handleRemoveMeal(mealType, recipeId)}
                      className="text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 p-2 rounded transition"
                    >
                      <Icon name="trash" />
                    </button>
                  </div>
                ))
              ) : (
                <p className="text-gray-500 text-center py-4">No recipes planned</p>
              )}
            </div>
          </div>
        ))}
      </div>

      {/* Recipe Selector Dialog */}
      {showRecipeSelector && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white dark:bg-gray-800 rounded-lg max-w-2xl w-full max-h-[80vh] overflow-hidden flex flex-col">
            <div className="p-6 border-b border-gray-200 dark:border-gray-700">
              <div className="flex items-center justify-between">
                <h2 className="text-2xl font-bold">Select Recipe for {selectedMealType}</h2>
                <button
                  onClick={() => setShowRecipeSelector(false)}
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
                    <button
                      key={recipe.id}
                      onClick={() => recipe.id && handleAddMeal(recipe.id)}
                      className="w-full text-left p-4 border border-gray-200 dark:border-gray-700 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-700 transition"
                    >
                      <div className="font-semibold">{recipe.name}</div>
                      <div className="text-sm text-gray-600 dark:text-gray-400 mt-1">
                        {recipe.cuisine} • {recipe.prepTime + recipe.cookTime} min
                      </div>
                    </button>
                  ))}
                </div>
              ) : (
                <div className="text-center py-12">
                  <Icon name="utensils" size="3x" className="mx-auto mb-4 text-gray-400" />
                  <p className="text-gray-600 dark:text-gray-400 mb-4">No recipes found</p>
                  <a
                    href="/recipes/new"
                    className="text-primary hover:underline"
                  >
                    Create your first recipe
                  </a>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </main>
  )
}
