"use client";

import { useState, useEffect } from 'react';
import { collection, addDoc } from 'firebase/firestore';
import { db } from '../../../lib/firebase/config';

export default function SeedPage() {
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [feedback, setFeedback] = useState('');
  const [recipes, setRecipes] = useState([]);

  useEffect(() => {
    fetch('/example-recipes.json')
      .then(response => response.json())
      .then(data => setRecipes(data))
      .catch(error => {
        console.error('Error fetching recipes:', error);
        setFeedback('Error fetching recipes. See console for details.');
      });
  }, []);

  const handleSeed = async () => {
    if (password !== process.env.NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD) {
      setFeedback('Incorrect password.');
      return;
    }

    if (recipes.length === 0) {
      setFeedback('No recipes to seed. Make sure example-recipes.json is available.');
      return;
    }

    setLoading(true);
    setFeedback('Seeding recipes...');

    const recipesCollection = collection(db, 'recipes');
    let successCount = 0;
    let errorCount = 0;

    for (const recipe of recipes) {
      try {
        await addDoc(recipesCollection, recipe);
        successCount++;
      } catch (e) {
        console.error('Error adding document: ', e);
        errorCount++;
      }
    }

    setLoading(false);
    setFeedback(`Seeding complete! ${successCount} recipes added, ${errorCount} errors.`);
  };

  return (
    <div style={{ padding: '20px', fontFamily: 'sans-serif', color: '#333' }}>
      <h1 style={{ borderBottom: '2px solid #eee', paddingBottom: '10px' }}>Seed Recipes</h1>
      <p>Enter the password to seed the database with recipes from <code>public/example-recipes.json</code>.</p>
      <div style={{ margin: '20px 0' }}>
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Enter password"
          style={{ padding: '10px', marginRight: '10px', borderRadius: '5px', border: '1px solid #ccc' }}
        />
        <button 
          onClick={handleSeed} 
          disabled={loading || recipes.length === 0}
          style={{ padding: '10px 20px', borderRadius: '5px', border: 'none', background: '#0070f3', color: 'white', cursor: 'pointer' }}
        >
          {loading ? 'Seeding...' : 'Seed Database'}
        </button>
      </div>
      {feedback && <p style={{ background: '#f0f0f0', padding: '10px', borderRadius: '5px' }}>{feedback}</p>}
    </div>
  );
}
