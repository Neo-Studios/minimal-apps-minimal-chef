'use client'

import { useEffect, useState } from 'react'
import { useParams } from 'next/navigation'
import { useAuth } from '@/lib/hooks/useAuth'
import { getCollaborativeMealPlan, addMemberToCollaborativeMealPlan, removeMemberFromCollaborativeMealPlan, addMealPlanToCollaborativePlan, removeMealPlanFromCollaborativePlan } from '@/lib/firebase/collaborativeMealPlans'
import { CollaborativeMealPlan, CollaborativeMealPlanMember } from '@/types/collaborativeMealPlan'
import { Icon } from '@/components/ui/Icon'
import Link from 'next/link'

export default function CollaborativeMealPlanDetailPage() {
  const params = useParams()
  const { user } = useAuth()
  const [collaborativePlan, setCollaborativePlan] = useState<CollaborativeMealPlan | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [newMemberEmail, setNewMemberEmail] = useState('')
  const [mealPlanToAddId, setMealPlanToAddId] = useState('')

  useEffect(() => {
    if (user) {
      fetchCollaborativePlan()
    } else {
      setLoading(false)
    }
  }, [user, params.id, fetchCollaborativePlan])

  const fetchCollaborativePlan = async () => {
    if (!user || !params.id) return
    setLoading(true)
    try {
      const fetchedPlan = await getCollaborativeMealPlan(params.id as string)
      if (fetchedPlan) {
        setCollaborativePlan(fetchedPlan)
      } else {
        setError('Collaborative meal plan not found.')
      }
    } catch (err) {
      console.error('Error fetching collaborative meal plan:', err)
      setError('Failed to load collaborative meal plan.')
    } finally {
      setLoading(false)
    }
  }

  const handleAddMember = async () => {
    if (!collaborativePlan || newMemberEmail.trim() === '') return
    // In a real app, you'd resolve email to userId
    const dummyUserId = newMemberEmail.trim().toLowerCase().replace(/[^a-z0-9]/g, '') + '-id'
    const newMember: CollaborativeMealPlanMember = { userId: dummyUserId, role: 'viewer' }
    try {
      await addMemberToCollaborativeMealPlan(collaborativePlan.id, newMember)
      setNewMemberEmail('')
      fetchCollaborativePlan()
    } catch (err) {
      console.error('Error adding member:', err)
      setError('Failed to add member.')
    }
  }

  const handleRemoveMember = async (member: CollaborativeMealPlanMember) => {
    if (!collaborativePlan) return
    try {
      await removeMemberFromCollaborativeMealPlan(collaborativePlan.id, member)
      fetchCollaborativePlan()
    } catch (err) {
      console.error('Error removing member:', err)
      setError('Failed to remove member.')
    }
  }

  const handleAddMealPlan = async () => {
    if (!collaborativePlan || mealPlanToAddId.trim() === '') return
    try {
      await addMealPlanToCollaborativePlan(collaborativePlan.id, mealPlanToAddId.trim())
      setMealPlanToAddId('')
      fetchCollaborativePlan()
    } catch (err) {
      console.error('Error adding meal plan:', err)
      setError('Failed to add meal plan to collaborative plan.')
    }
  }

  const handleRemoveMealPlan = async (mealPlanId: string) => {
    if (!collaborativePlan) return
    try {
      await removeMealPlanFromCollaborativePlan(collaborativePlan.id, mealPlanId)
      fetchCollaborativePlan()
    } catch (err) {
      console.error('Error removing meal plan:', err)
      setError('Failed to remove meal plan from collaborative plan.')
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading collaborative meal plan...</p>
        </div>
      </div>
    )
  }

  if (error || !collaborativePlan) {
    return (
      <div className="min-h-screen flex items-center justify-center p-8">
        <div className="text-center">
          <Icon name="users" size="6x" className="mb-4 mx-auto text-gray-400" />
          <h2 className="text-2xl font-bold mb-2">{error || 'Collaborative meal plan not found'}</h2>
          <p className="text-gray-600 mb-4">The collaborative meal plan you're looking for doesn't exist or couldn't be loaded.</p>
          <Link href="/collaborative-meal-plans" className="text-primary hover:underline">← Back to Collaborative Meal Plans</Link>
        </div>
      </div>
    )
  }

  const isOwner = collaborativePlan.ownerId === user?.uid

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-4xl font-bold mb-4">{collaborativePlan.name}</h1>
      <p className="text-gray-600 dark:text-gray-400 mb-6">Owner: {collaborativePlan.ownerId}</p>

      {error && <div className="bg-red-100 text-red-800 p-3 rounded-lg mb-4">{error}</div>}

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Members</h2>
        <div className="space-y-2">
          {collaborativePlan.members.map((member, index) => (
            <div key={index} className="flex items-center justify-between bg-white dark:bg-gray-800 p-4 rounded-lg shadow-sm">
              <span>{member.userId} ({member.role})</span>
              {isOwner && member.userId !== user?.uid && (
                <button
                  onClick={() => handleRemoveMember(member)}
                  className="text-red-500 hover:text-red-700 transition"
                >
                  <Icon name="trash" />
                </button>
              )}
            </div>
          ))}
        </div>
        {isOwner && (
          <div className="mt-4 flex gap-2">
            <input
              type="email"
              value={newMemberEmail}
              onChange={(e) => setNewMemberEmail(e.target.value)}
              placeholder="Invite member by email"
              className="flex-grow p-3 border border-gray-300 dark:border-gray-700 rounded-lg bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white"
            />
            <button
              onClick={handleAddMember}
              disabled={newMemberEmail.trim() === ''}
              className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition disabled:opacity-50"
            >
              Add
            </button>
          </div>
        )}
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Linked Meal Plans</h2>
        <div className="space-y-2">
          {collaborativePlan.mealPlanIds.length === 0 ? (
            <p className="text-gray-600 dark:text-gray-400">No meal plans linked yet.</p>
          ) : (
            collaborativePlan.mealPlanIds.map((mealPlanId, index) => (
              <div key={index} className="flex items-center justify-between bg-white dark:bg-gray-800 p-4 rounded-lg shadow-sm">
                <span>Meal Plan ID: {mealPlanId}</span>
                {isOwner && (
                  <button
                    onClick={() => handleRemoveMealPlan(mealPlanId)}
                    className="text-red-500 hover:text-red-700 transition"
                  >
                    <Icon name="trash" />
                  </button>
                )}
              </div>
            ))
          )}
        </div>
        {isOwner && (
          <div className="mt-4 flex gap-2">
            <input
              type="text"
              value={mealPlanToAddId}
              onChange={(e) => setMealPlanToAddId(e.target.value)}
              placeholder="Enter Meal Plan ID to link"
              className="flex-grow p-3 border border-gray-300 dark:border-gray-700 rounded-lg bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white"
            />
            <button
              onClick={handleAddMealPlan}
              disabled={mealPlanToAddId.trim() === ''}
              className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition disabled:opacity-50"
            >
              Link
            </button>
          </div>
        )}
      </section>
    </main>
  )
}
