import { Recipe } from '@/types/models'
import Link from 'next/link'

interface RecipeCardProps {
  recipe: Recipe
}

export default function RecipeCard({ recipe }: RecipeCardProps) {
  return (
    <Link href={`/recipes/${recipe.id}`}>
      <div className="border rounded-lg p-4 hover:shadow-lg transition-shadow">
        {recipe.imageUrl && (
          <img src={recipe.imageUrl} alt={recipe.name} className="w-full h-48 object-cover rounded-md mb-3" />
        )}
        <h3 className="text-lg font-semibold">{recipe.name}</h3>
        <p className="text-sm text-gray-600">{recipe.cuisineType}</p>
        <div className="flex gap-2 mt-2 text-xs text-gray-500">
          <span>⏱️ {(recipe.prepTime || 0) + (recipe.cookTime || 0)} min</span>
          <span>🍽️ {recipe.servings} servings</span>
        </div>
      </div>
    </Link>
  )
}
