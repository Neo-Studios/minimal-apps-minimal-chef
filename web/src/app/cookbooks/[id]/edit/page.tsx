'use client'

import { useState, useEffect } from 'react'
import { useRouter, useParams } from 'next/navigation'
import { useAuth } from '@/lib/hooks/useAuth'
import { getCookbooks, updateCookbook, Cookbook } from '@/lib/firebase/cookbooks'

export default function EditCookbookPage() {
  const router = useRouter()
  const params = useParams()
  const { user } = useAuth()
  
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [name, setName] = useState('')
  const [description, setDescription] = useState('')
  const [isPublic, setIsPublic] = useState(false)

  useEffect(() => {
    const loadCookbook = async () => {
      if (!user || !params.id) return
      
      const cookbooks = await getCookbooks(user.uid)
      const cookbook = cookbooks.find(c => c.id === params.id)
      
      if (!cookbook) {
        alert('Cookbook not found')
        router.push('/cookbooks')
        return
      }
      
      setName(cookbook.name)
      setDescription(cookbook.description || '')
      setIsPublic(cookbook.isPublic || false)
      setLoading(false)
    }
    
    if (user) {
      loadCookbook()
    }
  }, [user, params.id, router])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!user || !params.id) return

    setSaving(true)
    try {
      const success = await updateCookbook(params.id as string, {
        name,
        description,
        isPublic
      })
      
      if (success) {
        router.push(`/cookbooks/${params.id}`)
      } else {
        alert('Failed to update cookbook')
      }
    } catch (error) {
      console.error('Error updating cookbook:', error)
      alert('Failed to update cookbook')
    } finally {
      setSaving(false)
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-gray-600">Loading cookbook...</p>
        </div>
      </div>
    )
  }

  return (
    <main className="min-h-screen p-8 pb-24">
      <div className="max-w-2xl">
        <h1 className="text-3xl font-bold mb-6">Edit Cookbook</h1>
        
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-2">Name</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-primary"
              placeholder="e.g., Family Favorites"
              required
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium mb-2">Description (optional)</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-primary"
              rows={3}
              placeholder="Describe your cookbook..."
            />
          </div>
          
          <div className="flex items-center gap-2">
            <input
              type="checkbox"
              id="isPublic"
              checked={isPublic}
              onChange={(e) => setIsPublic(e.target.checked)}
              className="w-4 h-4"
            />
            <label htmlFor="isPublic" className="text-sm font-medium">
              Make this cookbook public
            </label>
          </div>
          
          <div className="flex gap-3 pt-6">
            <button
              type="submit"
              disabled={saving}
              className="flex-1 bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition disabled:opacity-50"
            >
              {saving ? 'Saving...' : 'Save Changes'}
            </button>
            <button
              type="button"
              onClick={() => router.back()}
              className="px-6 bg-gray-200 text-gray-800 px-4 py-2 rounded-lg hover:bg-gray-300 transition"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </main>
  )
}
