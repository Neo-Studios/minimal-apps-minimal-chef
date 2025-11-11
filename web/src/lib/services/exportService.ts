import { Recipe } from '@/types/models'

export function exportRecipeToPDF(recipe: Recipe): void {
  const content = `
    <html>
      <head>
        <style>
          body { font-family: Arial, sans-serif; padding: 40px; }
          h1 { color: #FFA500; }
          .section { margin: 20px 0; }
          .ingredient { margin: 5px 0; }
        </style>
      </head>
      <body>
        <h1>${recipe.name}</h1>
        ${recipe.description ? `<p>${recipe.description}</p>` : ''}
        
        <div class="section">
          <h2>Ingredients</h2>
          ${recipe.ingredients.map(ing => 
            `<div class="ingredient">• ${ing.amount} ${ing.unit} ${ing.name}</div>`
          ).join('')}
        </div>
        
        <div class="section">
          <h2>Instructions</h2>
          ${recipe.instructions.map((step, i) => 
            `<p><strong>${i + 1}.</strong> ${step}</p>`
          ).join('')}
        </div>
        
        ${recipe.nutrition ? `
          <div class="section">
            <h2>Nutrition (per serving)</h2>
            <p>Calories: ${recipe.nutrition.calories}</p>
            <p>Protein: ${recipe.nutrition.protein}g</p>
            <p>Carbs: ${recipe.nutrition.carbs}g</p>
            <p>Fat: ${recipe.nutrition.fat}g</p>
          </div>
        ` : ''}
      </body>
    </html>
  `
  
  const blob = new Blob([content], { type: 'text/html' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${recipe.name.replace(/\s+/g, '-')}.html`
  a.click()
  URL.revokeObjectURL(url)
}

export function exportRecipeToJSON(recipe: Recipe): void {
  const json = JSON.stringify(recipe, null, 2)
  const blob = new Blob([json], { type: 'application/json' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${recipe.name.replace(/\s+/g, '-')}.json`
  a.click()
  URL.revokeObjectURL(url)
}

export function exportRecipesToBackup(recipes: Recipe[]): void {
  const backup = {
    version: '2.0.0',
    exportDate: new Date().toISOString(),
    recipes
  }
  const json = JSON.stringify(backup, null, 2)
  const blob = new Blob([json], { type: 'application/json' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `minimal-chef-backup-${Date.now()}.json`
  a.click()
  URL.revokeObjectURL(url)
}
