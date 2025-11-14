# Recipe Import - Quick Start Guide

## 5-Minute Setup

### Step 1: Set Password (1 min)

Add to your `.env.local`:
```bash
NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD=MySecurePassword123
```

For Vercel:
1. Project Settings → Environment Variables
2. Add `NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD` = `MySecurePassword123`
3. Redeploy

### Step 2: Create Gist (2 min)

1. Go to https://gist.github.com
2. Copy content from `web/example-recipes.json`
3. Create new gist (public or secret)
4. Copy the gist URL

### Step 3: Import (2 min)

1. Open your Zest app
2. Sign in
3. Press F12 (open console)
4. Run:
```javascript
dev.recipeAdd("https://gist.github.com/YOUR_USERNAME/YOUR_GIST_ID")
```
5. Enter password when prompted
6. Wait for completion
7. Refresh page

## Done! 🎉

Your recipes are now imported and ready to use.

## Example Console Output

```
> dev.recipeAdd("https://gist.github.com/...")
Starting recipe import...
Fetching recipes from: https://gist.github.com/...
Found 3 recipes to import
✓ Imported: Classic Spaghetti Carbonara
✓ Imported: Avocado Toast
✓ Imported: Chicken Tikka Masala

=== Import Complete ===
✓ Successfully imported: 3
✗ Failed: 0

Refresh the page to see imported recipes.
```

## Troubleshooting

**"dev is not defined"**
- Make sure you're signed in
- Refresh the page
- Check console for errors

**"Invalid password"**
- Password is case-sensitive
- Check `.env.local` or Vercel env vars
- Restart dev server after changing env

**"Failed to fetch"**
- Check gist URL is correct
- Ensure gist is public
- Try accessing gist URL in browser first

## Need Help?

See full documentation: `docs/RECIPE_IMPORT.md`
