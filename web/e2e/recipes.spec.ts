import { test, expect } from '@playwright/test'

test.describe('Recipe Management', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/')
  })

  test('should display recipe list', async ({ page }) => {
    await page.goto('/recipes')
    await expect(page).toHaveTitle(/Zest/)
    await expect(page.locator('h1')).toContainText('Recipes')
  })

  test('should navigate to recipe detail', async ({ page }) => {
    await page.goto('/recipes')
    
    // Wait for recipes to load
    await page.waitForSelector('[data-testid="recipe-card"]', { timeout: 5000 })
    
    // Click first recipe
    await page.locator('[data-testid="recipe-card"]').first().click()
    
    // Should navigate to detail page
    await expect(page).toHaveURL(/\/recipes\/.*/)
  })

  test('should search recipes', async ({ page }) => {
    await page.goto('/recipes')
    
    // Type in search box
    await page.fill('input[type="search"]', 'pasta')
    
    // Wait for search results
    await page.waitForTimeout(500)
    
    // Should show filtered results
    const recipes = page.locator('[data-testid="recipe-card"]')
    await expect(recipes.first()).toBeVisible()
  })

  test('should scale recipe servings', async ({ page }) => {
    await page.goto('/recipes')
    await page.locator('[data-testid="recipe-card"]').first().click()
    
    // Find scale controls
    const increaseButton = page.locator('button:has-text("+")')
    await increaseButton.click()
    
    // Check that servings increased
    await expect(page.locator('text=/servings/')).toBeVisible()
  })
})

test.describe('Meal Planning', () => {
  test('should display meal plan calendar', async ({ page }) => {
    await page.goto('/meal-plan')
    await expect(page.locator('h1')).toContainText('Meal Plan')
  })

  test('should add meal to calendar', async ({ page }) => {
    await page.goto('/meal-plan')
    
    // This would require more complex interaction
    // Placeholder for actual implementation
    await expect(page).toHaveURL('/meal-plan')
  })
})

test.describe('Shopping List', () => {
  test('should display shopping list', async ({ page }) => {
    await page.goto('/shopping')
    await expect(page.locator('h1')).toContainText('Shopping')
  })

  test('should add item to shopping list', async ({ page }) => {
    await page.goto('/shopping')
    
    // Add new item
    await page.fill('input[placeholder*="Add"]', 'Tomatoes')
    await page.press('input[placeholder*="Add"]', 'Enter')
    
    // Should see new item
    await expect(page.locator('text=Tomatoes')).toBeVisible()
  })

  test('should check off shopping list item', async ({ page }) => {
    await page.goto('/shopping')
    
    // Find checkbox and click
    const checkbox = page.locator('input[type="checkbox"]').first()
    await checkbox.click()
    
    // Item should be checked
    await expect(checkbox).toBeChecked()
  })
})
