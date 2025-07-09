import React, { useState } from 'react';
import {
  Box,
  Typography,
  TextField,
  Button,
  Card,
  CardContent,
  CircularProgress,
  List,
  ListItem,
  ListItemText,
  Checkbox,
  FormControlLabel,
  Slider,
} from '@mui/material';
import { Link, ShoppingCart } from '@mui/icons-material';
import { importRecipeFromUrl, adjustServings } from '../utils/recipeImporter';

const RecipeImport = () => {
  const [url, setUrl] = useState('');
  const [loading, setLoading] = useState(false);
  const [recipe, setRecipe] = useState(null);
  const [servings, setServings] = useState(4);
  const [selectedIngredients, setSelectedIngredients] = useState([]);

  const importRecipe = async () => {
    setLoading(true);
    try {
      const importedRecipe = await importRecipeFromUrl(url);
      setRecipe(importedRecipe);
      setSelectedIngredients(new Array(importedRecipe.ingredients.length).fill(false));
    } catch (error) {
      console.error('Import failed:', error);
      // Fallback to mock data
      setRecipe({
        title: 'Classic Chocolate Chip Cookies',
        originalServings: 24,
        ingredients: [
          '2 1/4 cups all-purpose flour',
          '1 tsp baking soda',
          '1 tsp salt',
          '1 cup butter, softened',
          '3/4 cup granulated sugar',
          '3/4 cup brown sugar',
          '2 large eggs',
          '2 tsp vanilla extract',
          '2 cups chocolate chips'
        ],
        instructions: [
          'Preheat oven to 375°F',
          'Mix flour, baking soda, and salt in bowl',
          'Cream butter and sugars until fluffy',
          'Beat in eggs and vanilla',
          'Gradually blend in flour mixture',
          'Stir in chocolate chips',
          'Drop rounded tablespoons onto ungreased cookie sheets',
          'Bake 9-11 minutes until golden brown'
        ]
      });
      setSelectedIngredients(new Array(9).fill(false));
    }
    setLoading(false);
  };

  const adjustedIngredients = recipe ? adjustServings(recipe.ingredients, recipe.originalServings, servings) : [];

  const addToShoppingList = () => {
    const selected = adjustedIngredients?.filter((_, index) => selectedIngredients[index]);
    console.log('Adding to shopping list:', selected);
  };

  return (
    <Box>
      <Typography variant="h4" component="h1" gutterBottom>
        Import Recipe
      </Typography>
      
      <Card sx={{ mb: 3 }}>
        <CardContent>
          <TextField
            fullWidth
            placeholder="Paste recipe URL here..."
            value={url}
            onChange={(e) => setUrl(e.target.value)}
            sx={{ mb: 2 }}
          />
          <Button
            variant="contained"
            onClick={importRecipe}
            disabled={!url.trim() || loading}
            startIcon={loading ? <CircularProgress size={20} /> : <Link />}
          >
            {loading ? 'Importing...' : 'Import Recipe'}
          </Button>
        </CardContent>
      </Card>

      {recipe && (
        <Card>
          <CardContent>
            <Typography variant="h5" gutterBottom>
              {recipe.title}
            </Typography>
            
            <Box sx={{ mb: 3 }}>
              <Typography gutterBottom>
                Adjust Servings: {servings} (Original: {recipe.originalServings})
              </Typography>
              <Slider
                value={servings}
                onChange={(e, value) => setServings(value)}
                min={1}
                max={20}
                marks
                valueLabelDisplay="auto"
              />
            </Box>
            
            <Typography variant="h6" gutterBottom>
              Ingredients
            </Typography>
            <List dense>
              {adjustedIngredients?.map((ingredient, index) => (
                <ListItem key={index}>
                  <FormControlLabel
                    control={
                      <Checkbox
                        checked={selectedIngredients[index]}
                        onChange={(e) => {
                          const newSelected = [...selectedIngredients];
                          newSelected[index] = e.target.checked;
                          setSelectedIngredients(newSelected);
                        }}
                      />
                    }
                    label={ingredient}
                  />
                </ListItem>
              ))}
            </List>
            
            <Button
              variant="outlined"
              startIcon={<ShoppingCart />}
              onClick={addToShoppingList}
              disabled={!selectedIngredients.some(Boolean)}
              sx={{ mt: 2, mr: 2 }}
            >
              Add Selected to Shopping List
            </Button>
            
            <Typography variant="h6" gutterBottom sx={{ mt: 3 }}>
              Instructions
            </Typography>
            <List>
              {recipe.instructions.map((step, index) => (
                <ListItem key={index}>
                  <ListItemText primary={`${index + 1}. ${step}`} />
                </ListItem>
              ))}
            </List>
          </CardContent>
        </Card>
      )}
    </Box>
  );
};

export default RecipeImport;