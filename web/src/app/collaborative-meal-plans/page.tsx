'use client'

import { useEffect, useState, useCallback } from 'react'
import { useAuth } from '@/lib/hooks/useAuth'
import { getCollaborativeMealPlans, createCollaborativeMealPlan } from '@/lib/firebase/collaborativeMealPlans'
import { CollaborativeMealPlan } from '@/types/collaborativeMealPlan'
import { Icon } from '@/components/ui/Icon'
import Link from 'next/link'

export default function CollaborativeMealPlansPage() {
  const { user } = useAuth()
  const [collaborativePlans, setCollaborativePlans] = useState<CollaborativeMealPlan[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [showCreateDialog, setShowCreateDialog] = useState(false)
  const [newPlanName, setNewPlanName] = useState('')

  const fetchCollaborativePlans = useCallback(async () => {
    if (!user) return
    setLoading(true)
    try {
      const fetchedPlans = await getCollaborativeMealPlans(user.uid)
      setCollaborativePlans(fetchedPlans)
    } catch (err) {
      console.error('Error fetching collaborative meal plans:', err)
      setError('Failed to load collaborative meal plans.')
    } finally {
      setLoading(false)
    }
  }, [user])

  useEffect(() => {
    if (user) {
      fetchCollaborativePlans()
    } else {
      setLoading(false)
    }
  }, [user, fetchCollaborativePlans])

  const handleCreatePlan = async () => {
    if (!user || newPlanName.trim() === '') return
    try {
      await createCollaborativeMealPlan(newPlanName, user.uid)
      setShowCreateDialog(false)
      setNewPlanName('')
      fetchCollaborativePlans()
    } catch (err) {
      console.error('Error creating collaborative meal plan:', err)
      setError('Failed to create collaborative meal plan.')
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading collaborative meal plans...</p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center p-8">
        <div className="text-center">
          <Icon name="utensils" size="6x" className="mb-4 mx-auto text-gray-400" />
          <h2 className="text-2xl font-bold mb-2">Error</h2>
          <p className="text-gray-600 mb-4">{error}</p>
        </div>
      </div>
    )
  }

  if (!user) {
    return (
      <div className="min-h-screen flex items-center justify-center p-8">
        <div className="text-center">
          <Icon name="lock" size="6x" className="mb-4 mx-auto text-gray-400" />
          <h2 className="text-2xl font-bold mb-2">Authentication Required</h2>
          <p className="text-gray-600 mb-4">Please log in to view collaborative meal plans.</p>
          <Link href="/login" className="text-primary hover:underline">Go to Login</Link>
        </div>
      </div>
    )
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      <div className="flex justify-between items-center mb-8">
        <h1 className="text-4xl font-bold">Collaborative Meal Plans</h1>
        <button
          onClick={() => setShowCreateDialog(true)}
          className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition"
        >
          <Icon name="plus" className="inline-block mr-2" /> Create New Plan
        </button>
      </div>

      {collaborativePlans.length === 0 ? (
        <div className="text-center py-12">
          <Icon name="users" size="6x" className="mb-4 mx-auto text-gray-400" />
          <p className="text-gray-600 text-xl">No collaborative meal plans yet. Create one or be invited!</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {collaborativePlans.map((plan) => (
            <Link href={`/collaborative-meal-plans/${plan.id}`} key={plan.id} className="block">
              <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden p-6">
                <h2 className="text-2xl font-semibold mb-2">{plan.name}</h2>
                <p className="text-gray-600 dark:text-gray-400 mb-4">Owner: {plan.ownerId}</p>
                <p className="text-sm text-gray-500">{plan.members.length} members</p>
              </div>
            </Link>
          ))}
        </div>
      )}

      {showCreateDialog && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white dark:bg-gray-800 rounded-lg max-w-md w-full p-6">
            <h2 className="text-2xl font-bold mb-4">Create New Collaborative Meal Plan</h2>
            <input
              type="text"
              value={newPlanName}
              onChange={(e) => setNewPlanName(e.target.value)}
              placeholder="Plan Name"
              className="w-full p-3 border border-gray-300 dark:border-gray-700 rounded-lg mb-4 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white"
            />
            <div className="flex justify-end gap-4">
              <button
                onClick={() => setShowCreateDialog(false)}
                className="px-4 py-2 rounded-lg text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 transition"
              >
                Cancel
              </button>
              <button
                onClick={handleCreatePlan}
                disabled={newPlanName.trim() === ''}
                className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition disabled:opacity-50"
              >
                Create
              </button>
            </div>
          </div>
        </div>
      )}
    </main>
  )
}
