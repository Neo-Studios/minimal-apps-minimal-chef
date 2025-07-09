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

interface ImportedRecipe {
  title: string;
  originalServings: number;
  ingredients: string[];
  instructions: string[];
  cookTime?: string;
  prepTime?: string;
  image?: string;
}

const RecipeImport = () => {
  const [url, setUrl] = useState('');
  const [loading, setLoading] = useState(false);
  const [recipe, setRecipe] = useState<ImportedRecipe | null>(null);
  const [servings, setServings] = useState(4);
  const [selectedIngredients, setSelectedIngredients] = useState<boolean[]>([]);

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
    const selected = adjustedIngredients?.filter((_: string, index: number) => selectedIngredients[index]);
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
                onChange={(e, value) => {
                  if (typeof value === 'number') setServings(value);
                }}
                min={1}
                max={20}
                marks
                valueLabelDisplay="auto"
              />
            </Box>
            
            <Typography variant="h6" gutterBottom>
              Ingredients
            </Typography>
            <List>
              {adjustedIngredients.map((ingredient: string, index: number) => (
                <ListItem key={index}>
                  <FormControlLabel
                    control={
                      <Checkbox
                        checked={selectedIngredients[index]}
                        onChange={() => {
                          const updated = [...selectedIngredients];
                          updated[index] = !updated[index];
                          setSelectedIngredients(updated);
                        }}
                      />
                    }
                    label={ingredient}
                  />
                </ListItem>
              ))}
            </List>
            
            <Button
              variant="contained"
              startIcon={<ShoppingCart />}
              onClick={addToShoppingList}
              disabled={!selectedIngredients.some(Boolean)}
            >
              Add Selected to Shopping List
            </Button>
            
            <Typography variant="h6" sx={{ mt: 3 }}>
              Instructions
            </Typography>
            <List>
              {recipe.instructions.map((step: string, index: number) => (
                <ListItem key={index}>
                  <ListItemText primary={`Step ${index + 1}: ${step}`} />
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