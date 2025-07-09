import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { ThemeProvider, CssBaseline } from '@mui/material';
import { lightTheme, darkTheme } from './theme';
import { useTheme } from './hooks/useTheme';
import Layout from './components/Layout';
import Recipes from './pages/Recipes';
import Discover from './pages/Discover';
import ShoppingList from './pages/ShoppingList';
import Settings from './pages/Settings';
import AIRecipe from './pages/AIRecipe';
import MealLogging from './pages/MealLogging';
import RecipeImport from './pages/RecipeImport';
import VoiceChef from './pages/VoiceChef';
import NewRecipe from './pages/NewRecipe';
import RecipeDetail from './pages/RecipeDetail';
import AddShoppingItem from './pages/AddShoppingItem';
import InstacartIntegration from './pages/InstacartIntegration';

const App: React.FC = () => {
  const { isDarkMode } = useTheme();

  return (
    <ThemeProvider theme={isDarkMode ? darkTheme : lightTheme}>
      <CssBaseline />
      <Router>
        <Layout>
          <Routes>
            <Route path="/" element={<Recipes />} />
            <Route path="/discover" element={<Discover />} />
            <Route path="/shopping" element={<ShoppingList />} />
            <Route path="/settings" element={<Settings />} />
            <Route path="/ai-recipe" element={<AIRecipe />} />
            <Route path="/meals" element={<MealLogging />} />
            <Route path="/import" element={<RecipeImport />} />
            <Route path="/voice-chef" element={<VoiceChef />} />
            <Route path="/recipe/new" element={<NewRecipe />} />
            <Route path="/recipe/:id" element={<RecipeDetail />} />
            <Route path="/shopping/add" element={<AddShoppingItem />} />
            <Route path="/instacart" element={<InstacartIntegration />} />
          </Routes>
        </Layout>
      </Router>
    </ThemeProvider>
  );
};

export default App;