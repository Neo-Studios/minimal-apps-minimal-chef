// Complete recipe details with ingredients and instructions
export const detailedRecipes = {
  1: {
    title: 'Risotto alla Milanese',
    image: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=800',
    description: 'A creamy Italian rice dish from Milan, flavored with saffron and Parmesan cheese.',
    cookTime: '30 min',
    prepTime: '10 min',
    servings: 4,
    difficulty: 'Medium',
    calories: 380,
    tags: ['Italian', 'Rice', 'Saffron', 'Vegetarian'],
    ingredients: [
      '320g Arborio rice',
      '1.2L warm chicken stock',
      '1 medium onion, finely chopped',
      '100ml dry white wine',
      '50g butter',
      '80g Parmesan cheese, grated',
      '1/2 tsp saffron threads',
      '2 tbsp olive oil',
      'Salt and pepper to taste'
    ],
    instructions: [
      'Soak saffron in 2 tbsp warm stock for 10 minutes.',
      'Heat olive oil and half the butter in a heavy-bottomed pan.',
      'Add onion and cook until translucent, about 5 minutes.',
      'Add rice and stir for 2 minutes until grains are coated.',
      'Pour in wine and stir until absorbed.',
      'Add warm stock one ladle at a time, stirring constantly.',
      'Continue for 18-20 minutes until rice is creamy but still al dente.',
      'Stir in saffron mixture, remaining butter, and Parmesan.',
      'Season with salt and pepper. Serve immediately.'
    ],
    nutrition: { calories: 380, protein: '12g', carbs: '65g', fat: '8g', fiber: '2g' }
  },
  
  6: {
    title: 'Butter Chicken',
    image: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800',
    description: 'A rich and creamy Indian curry with tender chicken in a tomato-based sauce.',
    cookTime: '45 min',
    prepTime: '20 min',
    servings: 6,
    difficulty: 'Medium',
    calories: 420,
    tags: ['Indian', 'Chicken', 'Curry', 'Spicy'],
    ingredients: [
      '1kg chicken breast, cut into chunks',
      '200ml heavy cream',
      '400g canned tomatoes',
      '1 large onion, chopped',
      '4 cloves garlic, minced',
      '2 tbsp ginger, grated',
      '2 tbsp butter',
      '1 tbsp garam masala',
      '1 tsp cumin',
      '1 tsp coriander',
      '1/2 tsp turmeric',
      '1/2 tsp cayenne pepper',
      'Salt to taste',
      'Fresh cilantro for garnish'
    ],
    instructions: [
      'Season chicken with salt, turmeric, and half the garam masala.',
      'Heat butter in a large pan and brown chicken pieces. Remove and set aside.',
      'In the same pan, sauté onion until golden, about 8 minutes.',
      'Add garlic and ginger, cook for 1 minute.',
      'Add remaining spices and cook for 30 seconds.',
      'Add tomatoes and simmer for 10 minutes until thickened.',
      'Blend the sauce until smooth, then return to pan.',
      'Add chicken back to the pan and simmer for 15 minutes.',
      'Stir in cream and simmer for 5 more minutes.',
      'Garnish with cilantro and serve with rice or naan.'
    ],
    nutrition: { calories: 420, protein: '35g', carbs: '12g', fat: '26g', fiber: '3g' }
  },

  26: {
    title: 'Pad Thai',
    image: 'https://images.unsplash.com/photo-1559314809-0f31657def5e?w=800',
    description: 'Thailand\'s most famous stir-fried noodle dish with a perfect balance of sweet, sour, and salty flavors.',
    cookTime: '20 min',
    prepTime: '15 min',
    servings: 4,
    difficulty: 'Medium',
    calories: 350,
    tags: ['Thai', 'Noodles', 'Stir-fry', 'Quick'],
    ingredients: [
      '200g rice noodles',
      '200g shrimp or chicken, sliced',
      '2 eggs',
      '100g bean sprouts',
      '3 green onions, chopped',
      '2 tbsp tamarind paste',
      '2 tbsp fish sauce',
      '2 tbsp palm sugar',
      '2 tbsp vegetable oil',
      '2 cloves garlic, minced',
      '1/4 cup peanuts, crushed',
      'Lime wedges for serving',
      'Red chili flakes (optional)'
    ],
    instructions: [
      'Soak rice noodles in warm water until soft, about 10 minutes.',
      'Mix tamarind paste, fish sauce, and palm sugar for the sauce.',
      'Heat oil in a wok over high heat.',
      'Add garlic and protein, stir-fry for 2-3 minutes.',
      'Push to one side, scramble eggs on the other side.',
      'Add drained noodles and sauce, toss everything together.',
      'Add bean sprouts and green onions, stir-fry for 2 minutes.',
      'Remove from heat and garnish with peanuts.',
      'Serve immediately with lime wedges and chili flakes.'
    ],
    nutrition: { calories: 350, protein: '20g', carbs: '45g', fat: '12g', fiber: '3g' }
  }
};

export const getRecipeDetails = (id) => {
  return detailedRecipes[id] || null;
};