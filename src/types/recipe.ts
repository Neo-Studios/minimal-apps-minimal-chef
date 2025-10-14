export interface Recipe {
  id: number;
  name: string;
  region: string;
  difficulty: 'Easy' | 'Medium' | 'Hard';
  cookTime: string;
  image: string;

  // Optional detailed properties
  description?: string;
  prepTime?: string;
  servings?: number;
  calories?: number;
  ingredients?: string[];
  instructions?: string[];
  nutrition?: {
    calories?: number;
    protein?: string;
    carbs?: string;
    fat?: string;
    fiber?: string;
  };
  tags?: string[];
  
  // Optional UI properties
  cuisine?: string;
  rating?: number;
  source?: 'database' | 'imported' | 'custom';
  createdAt?: string;
}

export interface RecipeDatabase {
  [cuisine: string]: Recipe[];
}

// The detail part of a recipe
export type RecipeDetail = Omit<Recipe, 'id' | 'name' | 'region' | 'difficulty' | 'cookTime' | 'image' | 'cuisine' | 'rating'>;

export interface RecipeDetailsDatabase {
  [id: string]: RecipeDetail;
}
