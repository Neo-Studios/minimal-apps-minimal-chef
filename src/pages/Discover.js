import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getAllRecipes, internationalRecipes } from '../utils/recipeDatabase';
import {
  Box,
  Typography,
  Card,
  CardMedia,
  CardContent,
  Grid,
  Tabs,
  Tab,
  Chip,
} from '@mui/material';

const cuisineTypes = ['All', 'Italian', 'Indian', 'Japanese', 'Mexican', 'French', 'Thai', 'Chinese', 'Korean', 'Greek', 'Moroccan', 'Spanish', 'Turkish', 'Brazilian', 'Vietnamese', 'Peruvian', 'Lebanese', 'British', 'American', 'German', 'Russian', 'Ethiopian', 'Nigerian', 'Jamaican', 'Argentinian', 'Australian', 'Canadian'];

const discoverRecipes = getAllRecipes().map(recipe => ({
  id: recipe.id,
  title: recipe.name,
  image: recipe.image,
  cuisine: Object.keys(internationalRecipes).find(country => 
    internationalRecipes[country].some(r => r.id === recipe.id)
  )?.charAt(0).toUpperCase() + Object.keys(internationalRecipes).find(country => 
    internationalRecipes[country].some(r => r.id === recipe.id)
  )?.slice(1),
  difficulty: recipe.difficulty,
  rating: (4.2 + Math.random() * 0.7).toFixed(1),
  cookTime: recipe.cookTime,
  region: recipe.region
}));

const Discover = () => {
  const navigate = useNavigate();
  const [selectedCuisine, setSelectedCuisine] = useState(0);

  return (
    <Box>
      <Typography variant="h4" component="h1" gutterBottom>
        Discover Recipes
      </Typography>
      
      <Tabs
        value={selectedCuisine}
        onChange={(e, newValue) => setSelectedCuisine(newValue)}
        sx={{ mb: 3 }}
        variant="scrollable"
        scrollButtons="auto"
      >
        {cuisineTypes.map((cuisine, index) => (
          <Tab key={cuisine} label={cuisine} />
        ))}
      </Tabs>

      <Grid container spacing={3}>
        {discoverRecipes
          .filter(recipe => selectedCuisine === 0 || recipe.cuisine?.toLowerCase() === cuisineTypes[selectedCuisine].toLowerCase())
          .map((recipe) => (
          <Grid item xs={12} sm={6} md={4} key={recipe.id}>
            <Card 
              sx={{ height: '100%', cursor: 'pointer' }}
              onClick={() => navigate(`/recipe/${recipe.id}`)}
            >
              <CardMedia
                component="img"
                height="200"
                image={recipe.image}
                alt={recipe.title}
              />
              <CardContent>
                <Typography variant="h6" component="h2" gutterBottom>
                  {recipe.title}
                </Typography>
                <Box sx={{ display: 'flex', gap: 1, mb: 1 }}>
                  <Chip label={recipe.cuisine} size="small" />
                  <Chip label={recipe.difficulty} size="small" variant="outlined" />
                </Box>
                <Typography variant="body2" color="text.secondary">
                  ⭐ {recipe.rating} • {recipe.cookTime}
                </Typography>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
    </Box>
  );
};

export default Discover;