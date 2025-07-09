export interface Recipe {
  id: number;
  name: string;
  region: string;
  difficulty: 'Easy' | 'Medium' | 'Hard';
  cookTime: string;
  image: string;
}

export interface RecipeDetail {
  description: string;
  prepTime: string;
  servings: number;
  calories: number;
  ingredients: string[];
  instructions: string[];
  nutrition: {
    calories: number;
    protein: string;
    carbs: string;
    fat: string;
    fiber: string;
  };
}

export interface FullRecipe extends Recipe {
  title: string;
  tags: string[];
  description: string;
  prepTime: string;
  servings: number;
  calories: number;
  ingredients: string[];
  instructions: string[];
  nutrition: {
    calories: number;
    protein: string;
    carbs: string;
    fat: string;
    fiber: string;
  };
}

export interface RecipeDatabase {
  [cuisine: string]: Recipe[];
}

export interface RecipeDetailsDatabase {
  [id: string]: RecipeDetail;
}