import { describe, it, expect } from 'vitest'
import { generateShoppingList } from '../generateShoppingList'
import { Recipe } from '@/types/models'

describe('generateShoppingList', () => {
  it('combines duplicate ingredients', () => {
    const recipes: Recipe[] = [
      {
        name: 'Recipe 1',
        ingredients: [{ name: 'flour', amount: '2', unit: 'cups' }],
        userId: '1',
        instructions: [],
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        cuisineType: 'italian',
        mealType: 'dinner',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Recipe 2',
        ingredients: [{ name: 'flour', amount: '1', unit: 'cup' }],
        userId: '1',
        instructions: [],
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        cuisineType: 'italian',
        mealType: 'dinner',
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ]

    const result = generateShoppingList(recipes)
    expect(result).toHaveLength(1)
    expect(result[0].name).toBe('flour')
  })
})
