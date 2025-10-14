import React from 'react';
import { Tabs, Tab } from '@mui/material';
import { internationalRecipes } from '../utils/recipeDatabase';

const cuisineTypes = ['All', ...Object.keys(internationalRecipes).map(c => c.charAt(0).toUpperCase() + c.slice(1))];

interface CuisineFilterProps {
  selectedCuisine: string;
  onCuisineChange: (cuisine: string) => void;
}

const CuisineFilter: React.FC<CuisineFilterProps> = ({ selectedCuisine, onCuisineChange }) => {
  return (
    <Tabs
      value={cuisineTypes.indexOf(selectedCuisine)}
      onChange={(e, newValue) => onCuisineChange(cuisineTypes[newValue])}
      sx={{ mb: 3 }}
      variant="scrollable"
      scrollButtons="auto"
    >
      {cuisineTypes.map((cuisine) => (
        <Tab key={cuisine} label={cuisine} />
      ))}
    </Tabs>
  );
};

export default CuisineFilter;