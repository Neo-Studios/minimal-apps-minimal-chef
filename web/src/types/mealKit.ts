export interface MealKit {
  id: string;
  name: string;
  description: string;
  imageUrl: string;
  price: number;
  recipes: MealKitRecipe[];
  availableDates: string[]; // YYYY-MM-DD
}

export interface MealKitRecipe {
  recipeId: string;
  servings: number;
}
