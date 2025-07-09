import recipeDetails from '../data/recipeDetails.json';
import { getAllRecipes } from './recipeDatabase';
import { FullRecipe, RecipeDetailsDatabase } from '../types/recipe';

const typedRecipeDetails = recipeDetails as RecipeDetailsDatabase;

export const getRecipeDetails = (id: number): FullRecipe | null => {
  const basicRecipe = getAllRecipes().find(r => r.id === id);
  const detailedInfo = typedRecipeDetails[id.toString()];
  
  if (!basicRecipe) return null;
  
  return {
    id: basicRecipe.id,
    name: basicRecipe.name,
    title: basicRecipe.name,
    image: basicRecipe.image,
    cookTime: basicRecipe.cookTime,
    difficulty: basicRecipe.difficulty,
    region: basicRecipe.region,
    description: detailedInfo?.description || `A delicious ${basicRecipe.region} recipe with ${basicRecipe.difficulty.toLowerCase()} difficulty.`,
    prepTime: detailedInfo?.prepTime || '15 min',
    servings: detailedInfo?.servings || 4,
    calories: detailedInfo?.calories || 400,
    tags: [basicRecipe.region, basicRecipe.difficulty],
    ingredients: detailedInfo?.ingredients || [
      'Ingredients will be added soon',
      'Check back later for full recipe details'
    ],
    instructions: detailedInfo?.instructions || [
      'Full instructions coming soon',
      'This recipe is being developed'
    ],
    nutrition: detailedInfo?.nutrition || {
      calories: detailedInfo?.calories || 400,
      protein: '20g',
      carbs: '45g',
      fat: '15g',
      fiber: '4g'
    }
  };
};