"use client";

import { useState, useEffect } from 'react';
import { collection, addDoc } from 'firebase/firestore';
import { db } from '../../../lib/firebase/config';

export default function SeedPage() {
  const [password, setPassword] = useState('');
  const [gistUrl, setGistUrl] = useState('');
  const [loading, setLoading] = useState(false);
  const [feedback, setFeedback] = useState('');
  const [recipes, setRecipes] = useState<any[]>([]);

  useEffect(() => {
    // No longer fetching from local example-recipes.json by default
    // Recipes will be fetched from Gist URL
  }, []);

  const handleSeed = async () => {
    if (password !== process.env.NEXT_PUBLIC_RECIPE_IMPORT_PASSWORD) {
      setFeedback('Incorrect password.');
      return;
    }

    if (!gistUrl) {
      setFeedback('Please enter a GitHub Gist URL.');
      return;
    }

    setLoading(true);
    setFeedback('Fetching recipes from Gist...');

    let fetchedRecipes = [];
    try {
      const response = await fetch(gistUrl);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      fetchedRecipes = await response.json();
      if (!Array.isArray(fetchedRecipes)) {
        throw new Error('Gist content is not a valid JSON array of recipes.');
      }
      setRecipes(fetchedRecipes); // Update state with fetched recipes
    } catch (error: unknown) {
      console.error('Error fetching or parsing Gist:', error);
      setFeedback(`Error fetching or parsing Gist: ${error instanceof Error ? error.message : String(error)}`);
      setLoading(false);
      return;
    }

    if (fetchedRecipes.length === 0) {
      setFeedback('No recipes found in the Gist.');
      setLoading(false);
      return;
    }

    setFeedback(`Seeding ${fetchedRecipes.length} recipes...`);

    const recipesCollection = collection(db, 'recipes');
    let successCount = 0;
    let errorCount = 0;

    for (const recipe of fetchedRecipes) {
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
      <h1 style={{ borderBottom: '2px solid #eee', paddingBottom: '10px' }}>Seed Recipes from GitHub Gist</h1>
      <p>Enter the password and a GitHub Gist URL containing a JSON array of recipes to seed the database.</p>
      <div style={{ margin: '20px 0' }}>
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Enter password"
          style={{ padding: '10px', marginRight: '10px', borderRadius: '5px', border: '1px solid #ccc', marginBottom: '10px', display: 'block', width: '100%' }}
        />
        <input
          type="text"
          value={gistUrl}
          onChange={(e) => setGistUrl(e.target.value)}
          placeholder="Enter GitHub Gist URL (e.g., https://gist.githubusercontent.com/.../raw/recipes.json)"
          style={{ padding: '10px', marginRight: '10px', borderRadius: '5px', border: '1px solid #ccc', marginBottom: '10px', display: 'block', width: '100%' }}
        />
        <button 
          onClick={handleSeed} 
          disabled={loading || !gistUrl}
          style={{ padding: '10px 20px', borderRadius: '5px', border: 'none', background: '#0070f3', color: 'white', cursor: 'pointer' }}
        >
          {loading ? 'Seeding...' : 'Seed Database'}
        </button>
      </div>
      {feedback && <p style={{ background: '#f0f0f0', padding: '10px', borderRadius: '5px' }}>{feedback}</p>}
    </div>
  );
}
