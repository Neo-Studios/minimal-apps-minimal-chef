import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { getAllRecipes, internationalRecipes } from '../utils/recipeDatabase';
import { Recipe } from '../types/recipe';
import RecipeCard from '../components/RecipeCard';
import CuisineFilter from '../components/CuisineFilter';
import {
  Box,
  Typography,
  Grid,
} from '@mui/material';

const Discover: React.FC = () => {
  const navigate = useNavigate();
  const [selectedCuisine, setSelectedCuisine] = useState('All');

  const recipes: Recipe[] = useMemo(() => {
    const allRecipes = getAllRecipes();
    return allRecipes.map(recipe => {
      const cuisineKey = Object.keys(internationalRecipes).find(country => 
        internationalRecipes[country].some(r => r.id === recipe.id)
      );
      const cuisine = cuisineKey ? cuisineKey.charAt(0).toUpperCase() + cuisineKey.slice(1) : '';
      return {
        ...recipe,
        cuisine,
        rating: 4.2 + Math.random() * 0.7,
      };
    });
  }, []);

  const trendingRecipes = useMemo(() => {
    return [...recipes].sort((a, b) => (b.rating ?? 0) - (a.rating ?? 0)).slice(0, 4);
  }, [recipes]);

  const filteredRecipes = useMemo(() => {
    if (selectedCuisine === 'All') {
      return recipes;
    }
    return recipes.filter(recipe => recipe.cuisine?.toLowerCase() === selectedCuisine.toLowerCase());
  }, [recipes, selectedCuisine]);

  const handleCuisineChange = (cuisine: string) => {
    setSelectedCuisine(cuisine);
  };

  return (
    <Box>
      <Typography variant="h4" component="h1" gutterBottom>
        Discover Recipes
      </Typography>

      <Typography variant="h5" component="h2" sx={{ my: 3 }}>
        Trending Recipes
      </Typography>
      <Grid container spacing={3} sx={{ mb: 5 }}>
        {trendingRecipes.map((recipe) => (
          <Grid item xs={12} sm={6} md={3} key={`trending-${recipe.id}`}>
            <RecipeCard recipe={recipe} />
          </Grid>
        ))}
      </Grid>

      <Typography variant="h5" component="h2" sx={{ mb: 2 }}>
        Explore by Cuisine
      </Typography>
      <CuisineFilter 
        selectedCuisine={selectedCuisine} 
        onCuisineChange={handleCuisineChange} 
      />

      <Grid container spacing={3} sx={{ mt: 3 }}>
        {filteredRecipes.map((recipe) => (
          <Grid item xs={12} sm={6} md={4} key={recipe.id}>
            <RecipeCard recipe={recipe} />
          </Grid>
        ))}
      </Grid>
    </Box>
  );
};

export default Discover;