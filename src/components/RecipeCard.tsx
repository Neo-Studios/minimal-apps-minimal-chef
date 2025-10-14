import React from 'react';
import { useNavigate } from 'react-router-dom';
import { Recipe } from '../types/recipe';
import {
  Card,
  CardMedia,
  CardContent,
  Typography,
  Box,
  Chip,
} from '@mui/material';

interface RecipeCardProps {
  recipe: Recipe;
}

const RecipeCard: React.FC<RecipeCardProps> = ({ recipe }) => {
  const navigate = useNavigate();

  return (
    <Card 
      sx={{ height: '100%', cursor: 'pointer' }}
      onClick={() => navigate(`/recipe/${recipe.id}`)}
    >
      <CardMedia
        component="img"
        height="200"
        image={recipe.image}
        alt={recipe.name}
      />
      <CardContent>
        <Typography variant="h6" component="h2" gutterBottom noWrap>
          {recipe.name}
        </Typography>
        <Box sx={{ display: 'flex', gap: 1, mb: 1 }}>
          {recipe.cuisine && <Chip label={recipe.cuisine} size="small" />}
          <Chip label={recipe.difficulty} size="small" variant="outlined" />
        </Box>
        <Typography variant="body2" color="text.secondary">
          {recipe.rating && `⭐ ${recipe.rating.toFixed(1)} • `}{recipe.cookTime}
        </Typography>
      </CardContent>
    </Card>
  );
};

export default RecipeCard;