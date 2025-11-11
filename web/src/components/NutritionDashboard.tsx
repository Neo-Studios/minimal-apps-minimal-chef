'use client'

import { NutritionInfo } from '@/types/models'

interface NutritionDashboardProps {
  weeklyData: Array<{ date: string; nutrition: NutritionInfo }>
  goals?: { calories: number; protein: number; carbs: number; fat: number }
}

export default function NutritionDashboard({ weeklyData, goals }: NutritionDashboardProps) {
  const totals = weeklyData.reduce(
    (acc, day) => ({
      calories: acc.calories + day.nutrition.calories,
      protein: acc.protein + day.nutrition.protein,
      carbs: acc.carbs + day.nutrition.carbs,
      fat: acc.fat + day.nutrition.fat
    }),
    { calories: 0, protein: 0, carbs: 0, fat: 0 }
  )

  const averages = {
    calories: Math.round(totals.calories / weeklyData.length),
    protein: Math.round(totals.protein / weeklyData.length * 10) / 10,
    carbs: Math.round(totals.carbs / weeklyData.length * 10) / 10,
    fat: Math.round(totals.fat / weeklyData.length * 10) / 10
  }

  return (
    <div className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm">
      <h2 className="text-2xl font-bold mb-6">Nutrition Dashboard</h2>
      
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
        <div className="p-4 bg-orange-50 dark:bg-orange-900/20 rounded-xl">
          <p className="text-sm text-gray-600 dark:text-gray-400">Avg Calories</p>
          <p className="text-2xl font-bold text-orange-600">{averages.calories}</p>
          {goals && <p className="text-xs text-gray-500">Goal: {goals.calories}</p>}
        </div>
        
        <div className="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-xl">
          <p className="text-sm text-gray-600 dark:text-gray-400">Avg Protein</p>
          <p className="text-2xl font-bold text-blue-600">{averages.protein}g</p>
          {goals && <p className="text-xs text-gray-500">Goal: {goals.protein}g</p>}
        </div>
        
        <div className="p-4 bg-green-50 dark:bg-green-900/20 rounded-xl">
          <p className="text-sm text-gray-600 dark:text-gray-400">Avg Carbs</p>
          <p className="text-2xl font-bold text-green-600">{averages.carbs}g</p>
          {goals && <p className="text-xs text-gray-500">Goal: {goals.carbs}g</p>}
        </div>
        
        <div className="p-4 bg-purple-50 dark:bg-purple-900/20 rounded-xl">
          <p className="text-sm text-gray-600 dark:text-gray-400">Avg Fat</p>
          <p className="text-2xl font-bold text-purple-600">{averages.fat}g</p>
          {goals && <p className="text-xs text-gray-500">Goal: {goals.fat}g</p>}
        </div>
      </div>

      <div className="space-y-2">
        <h3 className="font-semibold mb-2">Weekly Breakdown</h3>
        {weeklyData.map((day, i) => (
          <div key={i} className="flex justify-between items-center p-2 hover:bg-gray-50 dark:hover:bg-gray-700 rounded">
            <span className="text-sm">{new Date(day.date).toLocaleDateString()}</span>
            <span className="text-sm font-medium">{day.nutrition.calories} cal</span>
          </div>
        ))}
      </div>
    </div>
  )
}
