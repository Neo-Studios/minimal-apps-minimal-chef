// Development recipe import function for browser console
window.devAddRecipes = async function(gistUrl) {
  const password = prompt('Enter development password:');
  if (!password) return;

  try {
    console.log('🔄 Fetching recipes from gist...');
    
    // Convert to raw gist URL
    const rawUrl = gistUrl.replace('gist.github.com', 'gist.githubusercontent.com') + '/raw/';
    
    const response = await fetch(rawUrl);
    if (!response.ok) throw new Error(`Failed to fetch: ${response.status}`);
    
    const recipes = await response.json();
    console.log(`📦 Found ${recipes.length} recipes`);
    
    // Verify password and import
    const result = await window.importRecipesToFirestore(recipes, password);
    console.log('✅ Import completed:', result);
    
  } catch (error) {
    console.error('❌ Import failed:', error);
  }
};

window.importRecipesToFirestore = async function(recipes, password) {
  // This will be called by Flutter web
  if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
    return await window.flutter_inappwebview.callHandler('importRecipes', {
      recipes: recipes,
      password: password
    });
  }
  
  // Fallback for direct web access
  throw new Error('Flutter handler not available');
};