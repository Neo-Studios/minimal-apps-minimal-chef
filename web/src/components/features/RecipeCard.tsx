import { Recipe } from '@/types/models'
import Link from 'next/link'
import Image from 'next/image'
import { Icon } from '@/components/ui/Icon'

interface RecipeCardProps {
  recipe: Recipe
}

export default function RecipeCard({ recipe }: RecipeCardProps) {
  return (
    <Link href={`/recipes/${recipe.id}`}>
      <div className="border rounded-lg p-4 hover:shadow-lg transition-shadow">
        {recipe.imageUrl && (
          <div className="relative w-full h-48 rounded-md overflow-hidden mb-3">
            <Image 
              src={recipe.imageUrl} 
              alt={recipe.name} 
              fill
              className="object-cover"
            />
          </div>
        )}
        <h3 className="text-lg font-semibold">{recipe.name}</h3>
        <p className="text-sm text-gray-600">{recipe.cuisine}</p>
        <div className="flex gap-2 mt-2 text-xs text-gray-500">
          <span className="flex items-center gap-1"><Icon name="clock" /> {(recipe.prepTime || 0) + (recipe.cookTime || 0)} min</span>
          <span className="flex items-center gap-1"><Icon name="utensils" /> {recipe.servings} servings</span>
        </div>
      </div>
    </Link>
  )
}
