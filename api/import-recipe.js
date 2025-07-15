import * as cheerio from 'cheerio';

const RECIPE_SELECTORS = {
  title: [
    'h1[class*="recipe"]', 'h1[class*="title"]', '.recipe-title', '.entry-title',
    '[data-testid="recipe-title"]', '.recipe-header h1', '.post-title', 'h1'
  ],
  ingredients: [
    '.recipe-ingredient', '.ingredients li', '[class*="ingredient"] li',
    '.recipe-ingredients li', '[data-testid="ingredient"]', '.ingredient-list li',
    '.ingredients-section li', '.recipe-card-ingredients li', 'ul[class*="ingredient"] li'
  ],
  instructions: [
    '.recipe-instruction', '.instructions li', '.directions li', '.method li',
    '[class*="instruction"] li', '.recipe-instructions li', '[data-testid="instruction"]',
    '.directions-section li', '.recipe-card-instructions li', 'ol[class*="instruction"] li'
  ],
  servings: [
    '[class*="yield"]', '[class*="serving"]', '.recipe-yield', '.servings',
    '[data-testid="servings"]', '.recipe-servings'
  ],
  prepTime: [
    '[class*="prep-time"]', '.prep-time', '[data-testid="prep-time"]',
    '.recipe-prep-time', '.preparation-time'
  ],
  cookTime: [
    '[class*="cook-time"]', '.cook-time', '[data-testid="cook-time"]',
    '.recipe-cook-time', '.cooking-time'
  ],
  image: [
    '.recipe-image img', '.featured-image img', '.recipe-photo img',
    '[class*="recipe"] img', '.post-thumbnail img', '.recipe-card img'
  ]
};

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { url } = req.body;

  if (!url) {
    return res.status(400).json({ error: 'URL is required' });
  }

  try {
    const response = await fetch(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
      }
    });
    const html = await response.text();
    const $ = cheerio.load(html);

    let recipe = null;

    // Method 1: JSON-LD structured data
    $('script[type="application/ld+json"]').each((i, elem) => {
      try {
        const data = JSON.parse($(elem).html());
        const recipeData = Array.isArray(data) 
          ? data.find(item => item['@type'] === 'Recipe')
          : data['@type'] === 'Recipe' ? data : null;
        
        if (recipeData) {
          recipe = {
            name: recipeData.name,
            description: recipeData.description,
            image: recipeData.image?.url || recipeData.image?.[0]?.url || recipeData.image,
            prepTime: recipeData.prepTime,
            cookTime: recipeData.cookTime,
            totalTime: recipeData.totalTime,
            servings: recipeData.recipeYield || recipeData.yield,
            ingredients: Array.isArray(recipeData.recipeIngredient) ? recipeData.recipeIngredient : [],
            instructions: Array.isArray(recipeData.recipeInstructions) 
              ? recipeData.recipeInstructions.map(inst => inst.text || inst.name || inst)
              : []
          };
        }
      } catch (e) {}
    });

    // Method 2: Microdata
    if (!recipe) {
      const microdataRecipe = $('[itemtype*="Recipe"]').first();
      if (microdataRecipe.length) {
        recipe = {
          name: microdataRecipe.find('[itemprop="name"]').text().trim(),
          description: microdataRecipe.find('[itemprop="description"]').text().trim(),
          image: microdataRecipe.find('[itemprop="image"]').attr('src'),
          prepTime: microdataRecipe.find('[itemprop="prepTime"]').text().trim(),
          cookTime: microdataRecipe.find('[itemprop="cookTime"]').text().trim(),
          servings: microdataRecipe.find('[itemprop="recipeYield"]').text().trim(),
          ingredients: microdataRecipe.find('[itemprop="recipeIngredient"]').map((i, el) => $(el).text().trim()).get(),
          instructions: microdataRecipe.find('[itemprop="recipeInstructions"]').map((i, el) => $(el).text().trim()).get()
        };
      }
    }

    // Method 3: Comprehensive HTML scraping
    if (!recipe || !recipe.name) {
      const extractBySelectors = (selectors) => {
        for (const selector of selectors) {
          const element = $(selector).first();
          if (element.length && element.text().trim()) {
            return element.text().trim();
          }
        }
        return null;
      };

      const extractListBySelectors = (selectors) => {
        const items = [];
        for (const selector of selectors) {
          $(selector).each((i, elem) => {
            const text = $(elem).text().trim();
            if (text && text.length > 3 && text.length < 300) {
              items.push(text);
            }
          });
          if (items.length > 0) break;
        }
        return items;
      };

      recipe = {
        name: extractBySelectors(RECIPE_SELECTORS.title) || $('title').text().split('|')[0].trim(),
        description: $('meta[name="description"]').attr('content') || $('meta[property="og:description"]').attr('content') || '',
        image: $(RECIPE_SELECTORS.image.join(', ')).first().attr('src') || $('meta[property="og:image"]').attr('content'),
        prepTime: extractBySelectors(RECIPE_SELECTORS.prepTime),
        cookTime: extractBySelectors(RECIPE_SELECTORS.cookTime),
        servings: extractBySelectors(RECIPE_SELECTORS.servings) || '4',
        ingredients: extractListBySelectors(RECIPE_SELECTORS.ingredients),
        instructions: extractListBySelectors(RECIPE_SELECTORS.instructions)
      };
    }

    // Method 4: Fallback aggressive scraping
    if (!recipe.ingredients || recipe.ingredients.length === 0) {
      const fallbackIngredients = [];
      $('li, p').each((i, elem) => {
        const text = $(elem).text().trim();
        if (text.match(/\d+.*(?:cup|tbsp|tsp|oz|lb|gram|kg|ml|liter)/i) && text.length < 150) {
          fallbackIngredients.push(text);
        }
      });
      recipe.ingredients = fallbackIngredients.slice(0, 25);
    }

    if (!recipe.instructions || recipe.instructions.length === 0) {
      const fallbackInstructions = [];
      $('li, p').each((i, elem) => {
        const text = $(elem).text().trim();
        if (text.match(/\b(?:heat|cook|bake|mix|add|stir|combine|place|remove)/i) && text.length > 20 && text.length < 500) {
          fallbackInstructions.push(text);
        }
      });
      recipe.instructions = fallbackInstructions.slice(0, 20);
    }

    // Clean and validate data
    recipe.name = recipe.name || 'Imported Recipe';
    recipe.ingredients = (recipe.ingredients || []).filter(ing => ing && ing.length > 2).slice(0, 30);
    recipe.instructions = (recipe.instructions || []).filter(inst => inst && inst.length > 5).slice(0, 25);
    recipe.servings = parseInt(recipe.servings) || 4;
    
    // Fix relative image URLs
    if (recipe.image && recipe.image.startsWith('/')) {
      const urlObj = new URL(url);
      recipe.image = urlObj.origin + recipe.image;
    }

    res.status(200).json({ recipe });
  } catch (error) {
    console.error('Recipe import error:', error);
    res.status(500).json({ error: 'Failed to import recipe' });
  }
}