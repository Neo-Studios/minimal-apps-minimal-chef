'use client'

import React, { useState } from 'react'
import { Material3Card } from '@/components/ui/Material3Card'
import { Material3Button } from '@/components/ui/Material3Button'
import { Icon } from '@/components/ui/Icon'

export default function NutritionPage() {
  const [selectedPeriod, setSelectedPeriod] = useState<'day' | 'week' | 'month'>('day')

  const nutritionData = {
    calories: { current: 1850, target: 2000 },
    protein: { current: 85, target: 100 },
    carbs: { current: 220, target: 250 },
    fat: { current: 65, target: 70 },
  }

  return (
    <div className="p-4 md:p-8 space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-4xl font-normal text-m3-on-surface mb-2">
          Nutrition Dashboard
        </h1>
        <p className="text-m3-on-surface-variant">
          Track your daily nutrition and reach your goals
        </p>
      </div>

      {/* Period selector */}
      <div className="flex gap-2">
        {(['day', 'week', 'month'] as const).map((period) => (
          <Material3Button
            key={period}
            variant={selectedPeriod === period ? 'filled' : 'outlined'}
            size="small"
            onClick={() => setSelectedPeriod(period)}
          >
            {period.charAt(0).toUpperCase() + period.slice(1)}
          </Material3Button>
        ))}
      </div>

      {/* Nutrition cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {Object.entries(nutritionData).map(([key, data]) => {
          const percentage = (data.current / data.target) * 100
          return (
            <Material3Card key={key} variant="elevated">
              <div className="p-6 space-y-4">
                <div className="flex items-center justify-between">
                  <h3 className="text-lg font-medium text-m3-on-surface capitalize">
                    {key}
                  </h3>
                  <Icon 
                    name={key === 'calories' ? 'fire' : key === 'protein' ? 'meat' : key === 'carbs' ? 'bread' : 'vegetable'} 
                    className="text-2xl"
                  />
                </div>
                
                <div>
                  <div className="flex items-baseline gap-2 mb-2">
                    <span className="text-3xl font-bold text-m3-primary-main">
                      {data.current}
                    </span>
                    <span className="text-m3-on-surface-variant">
                      / {data.target} {key === 'calories' ? 'kcal' : 'g'}
                    </span>
                  </div>
                  
                  {/* Progress bar */}
                  <div className="h-2 bg-m3-surface-container-high rounded-full overflow-hidden">
                    <div
                      className="h-full bg-m3-primary-main rounded-full transition-all"
                      style={{ width: `${Math.min(percentage, 100)}%` }}
                    />
                  </div>
                </div>
              </div>
            </Material3Card>
          )
        })}
      </div>

      {/* Recent meals */}
      <Material3Card variant="elevated">
        <div className="p-6 space-y-4">
          <h2 className="text-2xl font-semibold text-m3-on-surface">
            Recent Meals
          </h2>
          
          <div className="space-y-3">
            {[
              { name: 'Breakfast - Oatmeal with Berries', calories: 350, time: '8:00 AM' },
              { name: 'Lunch - Grilled Chicken Salad', calories: 450, time: '12:30 PM' },
              { name: 'Snack - Greek Yogurt', calories: 150, time: '3:00 PM' },
              { name: 'Dinner - Salmon with Vegetables', calories: 550, time: '7:00 PM' },
            ].map((meal, index) => (
              <div
                key={index}
                className="flex items-center justify-between p-4 bg-m3-surface-container rounded-lg"
              >
                <div>
                  <p className="font-medium text-m3-on-surface">{meal.name}</p>
                  <p className="text-sm text-m3-on-surface-variant">{meal.time}</p>
                </div>
                <span className="text-lg font-semibold text-m3-primary-main">
                  {meal.calories} kcal
                </span>
              </div>
            ))}
          </div>
        </div>
      </Material3Card>

      {/* Water intake */}
      <Material3Card variant="filled">
        <div className="p-6 space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="text-2xl font-semibold text-m3-on-surface">
              Water Intake
            </h2>
            <span className="text-3xl">💧</span>
          </div>
          
          <div className="flex items-center gap-4">
            <div className="flex-1">
              <div className="flex items-baseline gap-2 mb-2">
                <span className="text-3xl font-bold text-m3-secondary-main">
                  6
                </span>
                <span className="text-m3-on-surface-variant">/ 8 glasses</span>
              </div>
              <div className="h-2 bg-m3-surface-container-high rounded-full overflow-hidden">
                <div
                  className="h-full bg-m3-secondary-main rounded-full"
                  style={{ width: '75%' }}
                />
              </div>
            </div>
            <Material3Button variant="tonal" size="small">
              + Add
            </Material3Button>
          </div>
        </div>
      </Material3Card>
    </div>
  )
}
