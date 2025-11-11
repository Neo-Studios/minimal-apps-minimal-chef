'use client'

import { useState } from 'react'

export default function MealPlanPage() {
  const [selectedDate, setSelectedDate] = useState(new Date())
  const [meals, setMeals] = useState<Record<string, string[]>>({})

  const dateKey = selectedDate.toISOString().split('T')[0]

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-3xl font-bold mb-6">Meal Plan</h1>
      
      <div className="grid grid-cols-7 gap-2 mb-6">
        {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map(day => (
          <div key={day} className="text-center font-semibold">{day}</div>
        ))}
      </div>

      <div className="border rounded-lg p-4">
        <h2 className="text-xl font-semibold mb-4">
          {selectedDate.toLocaleDateString()}
        </h2>
        <div className="space-y-2">
          {meals[dateKey]?.map((meal, i) => (
            <div key={i} className="p-2 bg-gray-100 rounded">{meal}</div>
          )) || <p className="text-gray-500">No meals planned</p>}
        </div>
      </div>
    </main>
  )
}
