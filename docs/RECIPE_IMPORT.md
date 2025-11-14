# Recipe Import System

## Overview

Zest includes a browser console-based recipe import system that allows you to bulk import recipes from GitHub Gist URLs. This is useful for:
- Seeding the database with initial recipes
- Importing recipe collections
- Migrating recipes from other sources

## Setup

### 1. Set Import Password

Add the import password to your environment variables:

**Local Development** (`.env.local`):
```bash
NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD=your_secure_password_here
```

**Vercel Deployment**:
1. Go to your Vercel project settings
2. Navigate to Environment Variables
3. Add: `NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD` = `your_secure_password_here`
4. Redeploy

### 2. Prepare Recipe Data

Create a JSON file with your recipes in the expected format and upload it to a GitHub Gist.

**Expected Format** (`expected-recipe-format.json`):
```json
[
  {
    "name": "Recipe Name",
    "description": "Description",
    "imageUrl": "https://...",
    "instructions": ["Step 1", "Step 2"],
    "ingredients": [{"name": "Ingredient", "quantity": "1 cup"}],
    "cuisineType": "italian",
    "mealType": "dinner",
    "difficultyLevel": "easy",
    "prepTime": 30,
    "cookTime": 45,
    "servings": 4,
    "tags": ["tag1", "tag2"]
  }
]
```

### 3. Upload to GitHub Gist

1. Go to https://gist.github.com
2. Create a new gist
3. Paste your JSON data
4. Name the file (e.g., `recipes.json`)
5. Create public or secret gist
6. Copy the gist URL

## Usage

### Import Recipes

1. **Open your Zest app** (local or production)
2. **Sign in** to your account
3. **Open browser console** (F12 or Cmd+Option+J)
4. **Run the import command**:

```javascript
dev.recipeAdd("https://gist.github.com/username/gist-id")
```

5. **Enter password** when prompted
6. **Wait for import** to complete
7. **Refresh the page** to see imported recipes

### Example

```javascript
// Import from GitHub Gist
dev.recipeAdd("https://gist.github.com/yourusername/abc123def456")

// Console output:
// Fetching recipes from: https://gist.github.com/...
// Found 10 recipes to import
// ✓ Imported: Spaghetti Carbonara
// ✓ Imported: Chicken Tikka Masala
// ...
// === Import Complete ===
// ✓ Successfully imported: 10
// ✗ Failed: 0
// Refresh the page to see imported recipes.
```

## Recipe Format Details

### Required Fields

```typescript
{
  name: string                    // Recipe name
  instructions: string[]          // Array of instruction steps
  ingredients: Array<{            // Array of ingredients
    name: string                  // Ingredient name
    quantity: string              // Amount with unit (e.g., "1 cup", "2 tbsp")
  }>
  cuisineType: string             // Cuisine type (e.g., "italian", "mexican")
  difficultyLevel: string         // "easy", "medium", or "hard"
  prepTime: number                // Prep time in minutes
  cookTime: number                // Cook time in minutes
  servings: number                // Number of servings
}
```

### Optional Fields

```typescript
{
  description?: string            // Recipe description
  imageUrl?: string               // External image URL
  mealType?: string               // "breakfast", "lunch", "dinner", "snack"
  tags?: string[]                 // Dietary tags (e.g., ["vegetarian", "gluten-free"])
}
```

### Quantity Parsing

The system automatically parses quantity strings:

```javascript
"1 cup"       → { amount: 1, unit: "cup" }
"2 tbsp"      → { amount: 2, unit: "tbsp" }
"1/2 tsp"     → { amount: 0.5, unit: "tsp" }
"3.5 oz"      → { amount: 3.5, unit: "oz" }
"pinch"       → { amount: 1, unit: "pinch" }
```

### Difficulty Mapping

```javascript
"easy"   → "Easy"
"medium" → "Medium"
"hard"   → "Hard"
```

## Example Recipe Data

```json
[
  {
    "name": "Classic Spaghetti Carbonara",
    "description": "A traditional Italian pasta dish with eggs, cheese, and pancetta",
    "imageUrl": "https://images.unsplash.com/photo-1612874742237-6526221588e3",
    "instructions": [
      "Bring a large pot of salted water to boil",
      "Cook spaghetti according to package directions",
      "Meanwhile, cook pancetta in a large skillet until crispy",
      "In a bowl, whisk together eggs, Parmesan, and black pepper",
      "Drain pasta, reserving 1 cup pasta water",
      "Add hot pasta to pancetta, remove from heat",
      "Quickly stir in egg mixture, adding pasta water to create a creamy sauce",
      "Serve immediately with extra Parmesan"
    ],
    "ingredients": [
      {"name": "Spaghetti", "quantity": "1 lb"},
      {"name": "Pancetta, diced", "quantity": "6 oz"},
      {"name": "Eggs", "quantity": "4"},
      {"name": "Parmesan cheese, grated", "quantity": "1 cup"},
      {"name": "Black pepper", "quantity": "1 tsp"},
      {"name": "Salt", "quantity": "to taste"}
    ],
    "cuisineType": "italian",
    "mealType": "dinner",
    "difficultyLevel": "medium",
    "prepTime": 10,
    "cookTime": 20,
    "servings": 4,
    "tags": ["pasta", "italian", "quick"]
  },
  {
    "name": "Avocado Toast",
    "description": "Simple and healthy breakfast with mashed avocado on toast",
    "imageUrl": "https://images.unsplash.com/photo-1541519227354-08fa5d50c44d",
    "instructions": [
      "Toast bread until golden brown",
      "Mash avocado with lime juice, salt, and pepper",
      "Spread avocado mixture on toast",
      "Top with cherry tomatoes and red pepper flakes",
      "Drizzle with olive oil"
    ],
    "ingredients": [
      {"name": "Bread slices", "quantity": "2"},
      {"name": "Ripe avocado", "quantity": "1"},
      {"name": "Lime juice", "quantity": "1 tbsp"},
      {"name": "Cherry tomatoes, halved", "quantity": "1/4 cup"},
      {"name": "Red pepper flakes", "quantity": "pinch"},
      {"name": "Olive oil", "quantity": "1 tsp"},
      {"name": "Salt and pepper", "quantity": "to taste"}
    ],
    "cuisineType": "american",
    "mealType": "breakfast",
    "difficultyLevel": "easy",
    "prepTime": 5,
    "cookTime": 5,
    "servings": 1,
    "tags": ["vegetarian", "healthy", "quick", "breakfast"]
  }
]
```

## Security

### Password Protection
- Import function requires password authentication
- Password stored in environment variables
- Not exposed in client code
- Prompt appears in browser for user input

### Access Control
- Only authenticated users can import
- Recipes are associated with the importing user's ID
- Each user can only import to their own account

### Rate Limiting
Consider implementing rate limiting if needed:
- Limit imports per user per day
- Limit total recipes per import
- Add cooldown between imports

## Troubleshooting

### "Recipe import password not configured"
- Add `NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD` to your environment variables
- Restart development server or redeploy

### "Invalid password"
- Check that password matches environment variable
- Ensure no extra spaces or characters
- Password is case-sensitive

### "Failed to fetch recipes"
- Verify GitHub Gist URL is correct
- Ensure gist is public or you have access
- Check browser console for network errors
- Try accessing the gist URL directly in browser

### "Invalid format: Expected an array of recipes"
- Ensure JSON file contains an array `[...]`
- Validate JSON syntax (use JSONLint.com)
- Check that file structure matches expected format

### "Firestore not initialized"
- Ensure you're signed in
- Check Firebase configuration
- Verify Firestore is enabled in Firebase Console

### Import succeeds but recipes don't appear
- Refresh the page
- Check browser console for errors
- Verify recipes were added in Firebase Console
- Check that recipes have correct userId

## Advanced Usage

### Import from Raw URL

You can also use raw GitHub URLs:

```javascript
dev.recipeAdd("https://raw.githubusercontent.com/user/repo/main/recipes.json")
```

### Programmatic Import

For advanced users, you can import programmatically:

```typescript
import { importRecipes } from '@/lib/utils/recipeImporter'

const results = await importRecipes(
  'https://gist.github.com/...',
  'password',
  'user-id'
)

console.log(results)
// { success: 10, failed: 0, errors: [] }
```

### Batch Processing

For large imports, consider splitting into smaller batches:

```javascript
// Import 50 recipes at a time
const batches = [
  "https://gist.github.com/.../batch1",
  "https://gist.github.com/.../batch2",
  "https://gist.github.com/.../batch3"
]

for (const url of batches) {
  await dev.recipeAdd(url)
  await new Promise(resolve => setTimeout(resolve, 2000)) // Wait 2s between batches
}
```

## Future Enhancements

- [ ] CSV import support
- [ ] Import from other recipe websites
- [ ] Duplicate detection
- [ ] Import preview before committing
- [ ] Undo import functionality
- [ ] Import history tracking
- [ ] Bulk edit imported recipes
- [ ] Import validation report
- [ ] Auto-categorization
- [ ] Image download and conversion to base64

## API Reference

### `dev.recipeAdd(url: string)`

Imports recipes from a GitHub Gist or raw JSON URL.

**Parameters:**
- `url` (string): GitHub Gist URL or raw JSON URL

**Returns:**
- Promise<{ success: number, failed: number, errors: string[] }>

**Example:**
```javascript
const results = await dev.recipeAdd("https://gist.github.com/...")
console.log(`Imported ${results.success} recipes`)
```

### `importRecipes(url: string, password: string, userId: string)`

Low-level import function.

**Parameters:**
- `url` (string): Recipe data URL
- `password` (string): Import password
- `userId` (string): User ID to associate recipes with

**Returns:**
- Promise<{ success: number, failed: number, errors: string[] }>

**Example:**
```typescript
import { importRecipes } from '@/lib/utils/recipeImporter'

const results = await importRecipes(url, password, userId)
```
