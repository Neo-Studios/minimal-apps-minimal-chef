'use client'

import { useEffect, useState } from 'react'
import { useAuth } from '@/lib/hooks/useAuth'
import { useCookbookStore } from '@/lib/stores/cookbookStore'
import Link from 'next/link'

export default function CookbooksPage() {
  const { user } = useAuth()
  const { cookbooks, loading, fetchCookbooks, addCookbook, removeCookbook } = useCookbookStore()
  const [showCreateDialog, setShowCreateDialog] = useState(false)
  const [newCookbookName, setNewCookbookName] = useState('')
  const [newCookbookDescription, setNewCookbookDescription] = useState('')

  useEffect(() => {
    if (user) {
      fetchCookbooks(user.uid)
    }
  }, [user, fetchCookbooks])

  const handleCreate = async () => {
    if (!user || !newCookbookName.trim()) return
    
    try {
      await addCookbook({
        name: newCookbookName,
        description: newCookbookDescription,
        recipeIds: [],
        userId: user.uid,
        isPublic: false
      })
      setNewCookbookName('')
      setNewCookbookDescription('')
      setShowCreateDialog(false)
    } catch (error) {
      console.error('Failed to create cookbook:', error)
    }
  }

  const handleDelete = async (id: string) => {
    if (confirm('Are you sure you want to delete this cookbook?')) {
      try {
        await removeCookbook(id)
      } catch (error) {
        console.error('Failed to delete cookbook:', error)
      }
    }
  }

  if (!user) {
    return (
      <div className="container mx-auto px-4 py-8">
        <p className="text-center text-gray-600">Please sign in to view your cookbooks.</p>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-center mb-8">
        <h1 className="text-3xl font-bold">My Cookbooks</h1>
        <button
          onClick={() => setShowCreateDialog(true)}
          className="bg-primary text-white px-6 py-2 rounded-lg hover:bg-primary/90 transition"
        >
          Create Cookbook
        </button>
      </div>

      {loading ? (
        <div className="text-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto"></div>
        </div>
      ) : cookbooks.length === 0 ? (
        <div className="text-center py-12">
          <p className="text-gray-600 mb-4">You haven't created any cookbooks yet.</p>
          <button
            onClick={() => setShowCreateDialog(true)}
            className="text-primary hover:underline"
          >
            Create your first cookbook
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {cookbooks.map((cookbook) => (
            <div key={cookbook.id} className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition">
              <Link href={`/cookbooks/${cookbook.id}`}>
                <h3 className="text-xl font-semibold mb-2 hover:text-primary transition">
                  {cookbook.name}
                </h3>
              </Link>
              {cookbook.description && (
                <p className="text-gray-600 mb-4 line-clamp-2">{cookbook.description}</p>
              )}
              <div className="flex justify-between items-center text-sm text-gray-500">
                <span>{cookbook.recipeIds.length} recipes</span>
                <button
                  onClick={() => cookbook.id && handleDelete(cookbook.id)}
                  className="text-red-600 hover:text-red-800 transition"
                >
                  Delete
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {showCreateDialog && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <h2 className="text-2xl font-bold mb-4">Create New Cookbook</h2>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium mb-1">Name</label>
                <input
                  type="text"
                  value={newCookbookName}
                  onChange={(e) => setNewCookbookName(e.target.value)}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-primary"
                  placeholder="e.g., Family Favorites"
                />
              </div>
              <div>
                <label className="block text-sm font-medium mb-1">Description (optional)</label>
                <textarea
                  value={newCookbookDescription}
                  onChange={(e) => setNewCookbookDescription(e.target.value)}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-primary"
                  rows={3}
                  placeholder="Describe your cookbook..."
                />
              </div>
              <div className="flex gap-3">
                <button
                  onClick={handleCreate}
                  className="flex-1 bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition"
                >
                  Create
                </button>
                <button
                  onClick={() => {
                    setShowCreateDialog(false)
                    setNewCookbookName('')
                    setNewCookbookDescription('')
                  }}
                  className="flex-1 bg-gray-200 text-gray-800 px-4 py-2 rounded-lg hover:bg-gray-300 transition"
                >
                  Cancel
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
