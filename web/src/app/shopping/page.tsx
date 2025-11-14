'use client'

import { useState, useEffect } from 'react'
import { useAuthStore } from '@/lib/stores/authStore'
import { collection, addDoc, getDocs, updateDoc, deleteDoc, doc, query, orderBy } from 'firebase/firestore'
import { db } from '@/lib/firebase/config'
import { ShoppingListItem } from '@/types/models'
import { Icon } from '@/components/ui/Icon'

const CATEGORIES = ['Produce', 'Meat', 'Dairy', 'Bakery', 'Pantry', 'Frozen', 'Other']

// Auto-detect category based on item name
function detectCategory(itemName: string): string {
  const name = itemName.toLowerCase()
  
  // Produce
  const produce = ['apple', 'banana', 'orange', 'lettuce', 'tomato', 'potato', 'onion', 'carrot', 'celery', 'cucumber', 'pepper', 'broccoli', 'spinach', 'kale', 'avocado', 'lemon', 'lime', 'garlic', 'ginger', 'mushroom', 'zucchini', 'squash', 'berry', 'berries', 'grape', 'melon', 'peach', 'pear', 'plum', 'cherry', 'strawberry', 'blueberry', 'raspberry', 'vegetable', 'fruit', 'salad', 'herb', 'basil', 'cilantro', 'parsley']
  if (produce.some(item => name.includes(item))) return 'Produce'
  
  // Meat
  const meat = ['chicken', 'beef', 'pork', 'turkey', 'fish', 'salmon', 'tuna', 'shrimp', 'steak', 'bacon', 'sausage', 'ham', 'lamb', 'meat', 'ground']
  if (meat.some(item => name.includes(item))) return 'Meat'
  
  // Dairy
  const dairy = ['milk', 'cheese', 'yogurt', 'butter', 'cream', 'egg', 'sour cream', 'cottage cheese', 'mozzarella', 'cheddar', 'parmesan', 'dairy']
  if (dairy.some(item => name.includes(item))) return 'Dairy'
  
  // Bakery
  const bakery = ['bread', 'bagel', 'roll', 'bun', 'croissant', 'muffin', 'donut', 'cake', 'cookie', 'pastry', 'tortilla', 'pita']
  if (bakery.some(item => name.includes(item))) return 'Bakery'
  
  // Frozen
  const frozen = ['frozen', 'ice cream', 'popsicle', 'pizza']
  if (frozen.some(item => name.includes(item))) return 'Frozen'
  
  // Pantry
  const pantry = ['rice', 'pasta', 'bean', 'flour', 'sugar', 'salt', 'pepper', 'oil', 'vinegar', 'sauce', 'spice', 'cereal', 'oat', 'can', 'canned', 'jar', 'box', 'bag']
  if (pantry.some(item => name.includes(item))) return 'Pantry'
  
  return 'Other'
}

export default function ShoppingPage() {
  const { user } = useAuthStore()
  const [items, setItems] = useState<ShoppingListItem[]>([])
  const [newItem, setNewItem] = useState('')
  const [newAmount, setNewAmount] = useState('')
  const [groupByCategory, setGroupByCategory] = useState(true)

  useEffect(() => {
    if (user) loadItems()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user])

  const loadItems = async () => {
    if (!user) return
    const q = query(collection(db, 'shoppingLists', user.uid, 'items'), orderBy('createdAt', 'desc'))
    const snapshot = await getDocs(q)
    setItems(snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as ShoppingListItem)))
  }

  const addItem = async () => {
    if (!user || !newItem) return
    const detectedCategory = detectCategory(newItem)
    await addDoc(collection(db, 'shoppingLists', user.uid, 'items'), {
      name: newItem,
      amount: newAmount,
      category: detectedCategory,
      checked: false,
      createdAt: new Date()
    })
    setNewItem('')
    setNewAmount('')
    loadItems()
  }

  const toggleItem = async (item: ShoppingListItem) => {
    if (!user || !item.id) return
    await updateDoc(doc(db, 'shoppingLists', user.uid, 'items', item.id), {
      checked: !item.checked
    })
    loadItems()
  }

  const deleteItem = async (itemId: string) => {
    if (!user) return
    await deleteDoc(doc(db, 'shoppingLists', user.uid, 'items', itemId))
    loadItems()
  }

  const clearChecked = async () => {
    if (!user) return
    const checkedItems = items.filter(item => item.checked)
    await Promise.all(checkedItems.map(item => item.id && deleteDoc(doc(db, 'shoppingLists', user.uid, 'items', item.id))))
    loadItems()
  }

  const groupedItems = groupByCategory
    ? CATEGORIES.map(cat => ({
        category: cat,
        items: items.filter(item => item.category === cat)
      })).filter(group => group.items.length > 0)
    : [{ category: 'All', items }]

  return (
    <main className="min-h-screen p-8 pb-24">
      <h1 className="text-3xl font-bold mb-6">Shopping List</h1>
      
      <div className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-sm mb-6">
        <div className="space-y-3">
          <input
            type="text"
            placeholder="Item name"
            value={newItem}
            onChange={(e) => setNewItem(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && addItem()}
            className="w-full p-3 border rounded-lg dark:bg-gray-700"
          />
          <input
            type="text"
            placeholder="Amount (optional)"
            value={newAmount}
            onChange={(e) => setNewAmount(e.target.value)}
            className="w-full p-3 border rounded-lg dark:bg-gray-700"
          />
          <button onClick={addItem} className="w-full bg-blue-500 text-white py-3 rounded-lg font-semibold">
            Add Item
          </button>
        </div>
      </div>

      <div className="flex justify-between items-center mb-4">
        <button
          onClick={() => setGroupByCategory(!groupByCategory)}
          className="text-blue-500 font-medium flex items-center gap-2"
        >
          <Icon name={groupByCategory ? 'clipboard' : 'folder'} />
          {groupByCategory ? 'Show All' : 'Group by Category'}
        </button>
        {items.some(item => item.checked) && (
          <button onClick={clearChecked} className="text-red-500 font-medium flex items-center gap-2">
            <Icon name="trash" />
            Clear Checked
          </button>
        )}
      </div>

      <div className="space-y-6">
        {groupedItems.map(group => (
          <div key={group.category}>
            {groupByCategory && (
              <h2 className="text-xl font-bold mb-3 text-gray-700 dark:text-gray-300">
                {group.category}
              </h2>
            )}
            <div className="space-y-2">
              {group.items.map(item => (
                <div key={item.id} className="flex items-center gap-3 p-4 bg-white dark:bg-gray-800 rounded-xl shadow-sm">
                  <input
                    type="checkbox"
                    checked={item.checked}
                    onChange={() => toggleItem(item)}
                    className="w-5 h-5"
                  />
                  <div className="flex-1">
                    <span className={item.checked ? 'line-through text-gray-500' : 'font-medium'}>
                      {item.name}
                    </span>
                    {item.amount && (
                      <span className="text-sm text-gray-500 ml-2">({item.amount})</span>
                    )}
                    {item.recipeName && (
                      <div className="text-xs text-blue-500 mt-1">From: {item.recipeName}</div>
                    )}
                  </div>
                  <button onClick={() => item.id && deleteItem(item.id)} className="text-red-500 px-3">
                    ✕
                  </button>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>

      {items.length === 0 && (
        <div className="text-center py-12 text-gray-500">
          <Icon name="cart" size="6x" className="mb-4" />
          <p>Your shopping list is empty</p>
        </div>
      )}
    </main>
  )
}
