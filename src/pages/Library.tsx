import React, { useState, useMemo, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { getAllRecipes, internationalRecipes } from '../utils/recipeDatabase';
import { Recipe } from '../types/recipe';
import RecipeCard from '../components/RecipeCard';
import {
  Box,
  Typography,
  Grid,
  TextField,
  InputAdornment,
  Tabs,
  Tab,
  Button,
  Menu,
  MenuItem,
  IconButton,
} from '@mui/material';
import { Search, Sort, Clear } from '@mui/icons-material';

const Library: React.FC = () => {
  const navigate = useNavigate();
  const [searchTerm, setSearchTerm] = useState('');
  const [allRecipes, setAllRecipes] = useState<Recipe[]>([]);
  const [activeTab, setActiveTab] = useState(0);
  const [sortAnchor, setSortAnchor] = useState<null | HTMLElement>(null);
  const [sortBy, setSortBy] = useState<'date' | 'name' | 'rating'>('date');

  useEffect(() => {
    const dbRecipes = getAllRecipes().map(recipe => {
      const cuisineKey = Object.keys(internationalRecipes).find(country => 
        internationalRecipes[country].some(r => r.id === recipe.id)
      );
      const cuisine = cuisineKey ? cuisineKey.charAt(0).toUpperCase() + cuisineKey.slice(1) : '';
      return {
        ...recipe,
        cuisine,
        rating: 4.2 + Math.random() * 0.7,
        source: 'database',
        createdAt: new Date().toISOString(), // Mock createdAt for sorting
      };
    });

    const importedRecipes = JSON.parse(localStorage.getItem('minimalChefRecipes') || '[]').map((r: any) => ({ ...r, source: 'imported' }));
    const customRecipes = JSON.parse(localStorage.getItem('minimalChefCustomRecipes') || '[]').map((r: any) => ({ ...r, source: 'custom' }));
    
    setAllRecipes([...dbRecipes, ...importedRecipes, ...customRecipes]);
  }, []);

  const filteredRecipes = useMemo(() => {
    let filtered = allRecipes;

    // Filter by tab
    if (activeTab === 1) {
      filtered = filtered.filter(r => r.source === 'database');
    } else if (activeTab === 2) {
      filtered = filtered.filter(r => r.source === 'imported');
    } else if (activeTab === 3) {
      filtered = filtered.filter(r => r.source === 'custom');
    }

    // Search filter
    if (searchTerm) {
      const query = searchTerm.toLowerCase();
      filtered = filtered.filter(recipe =>
        recipe.name.toLowerCase().includes(query) ||
        (recipe.tags && recipe.tags.some(tag => tag.toLowerCase().includes(query))) ||
        (recipe.cuisine && recipe.cuisine.toLowerCase().includes(query))
      );
    }

    // Sort
    filtered.sort((a, b) => {
      switch (sortBy) {
        case 'name':
          return a.name.localeCompare(b.name);
        case 'rating':
          return (b.rating ?? 0) - (a.rating ?? 0);
        case 'date':
        default:
          return new Date(b.createdAt ?? 0).getTime() - new Date(a.createdAt ?? 0).getTime();
      }
    });

    return filtered;
  }, [allRecipes, searchTerm, activeTab, sortBy]);

  return (
    <Box>
      <Typography variant="h4" component="h1" gutterBottom>
        My Recipe Library
      </Typography>
      
      <TextField
        fullWidth
        placeholder="Search recipes by name, tag, or cuisine..."
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        sx={{ mb: 2 }}
        InputProps={{
          startAdornment: (
            <InputAdornment position="start">
              <Search />
            </InputAdornment>
          ),
          endAdornment: searchTerm && (
            <InputAdornment position="end">
              <IconButton onClick={() => setSearchTerm('')} size="small">
                <Clear />
              </IconButton>
            </InputAdornment>
          )
        }}
      />

      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
        <Tabs value={activeTab} onChange={(_, v) => setActiveTab(v)} variant="scrollable" scrollButtons="auto">
          <Tab label={`All (${allRecipes.length})`} />
          <Tab label={`Database (${allRecipes.filter(r => r.source === 'database').length})`} />
          <Tab label={`Imported (${allRecipes.filter(r => r.source === 'imported').length})`} />
          <Tab label={`Custom (${allRecipes.filter(r => r.source === 'custom').length})`} />
        </Tabs>

        <Box>
          <Button
            startIcon={<Sort />}
            onClick={(e) => setSortAnchor(e.currentTarget)}
            size="small"
          >
            Sort
          </Button>
          <Menu
            anchorEl={sortAnchor}
            open={Boolean(sortAnchor)}
            onClose={() => setSortAnchor(null)}
          >
            <MenuItem onClick={() => { setSortBy('date'); setSortAnchor(null); }}>
              Date Added
            </MenuItem>
            <MenuItem onClick={() => { setSortBy('name'); setSortAnchor(null); }}>
              Name A-Z
            </MenuItem>
            <MenuItem onClick={() => { setSortBy('rating'); setSortAnchor(null); }}>
              Rating
            </MenuItem>
          </Menu>
        </Box>
      </Box>

      <Grid container spacing={3}>
        {filteredRecipes.map((recipe) => (
          <Grid item xs={12} sm={6} md={4} key={`${recipe.id}-${recipe.source}`}>
            <RecipeCard recipe={recipe} />
          </Grid>
        ))}
      </Grid>

      {filteredRecipes.length === 0 && (
        <Box sx={{ textAlign: 'center', py: 4 }}>
          <Typography variant="h6" color="text.secondary">
            No recipes found
          </Typography>
          <Typography variant="body2" color="text.secondary">
            {searchTerm ? 'Try adjusting your search terms' : 'Your library is empty. Discover or create new recipes!'}
          </Typography>
        </Box>
      )}
    </Box>
  );
};

export default Library;