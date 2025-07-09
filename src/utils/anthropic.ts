import Anthropic from '@anthropic-ai/sdk';

const anthropic = new Anthropic({
  apiKey: process.env.REACT_APP_ANTHROPIC_API_KEY,
  dangerouslyAllowBrowser: true
});

export const generateRecipe = async (prompt) => {
  try {
    const response = await anthropic.messages.create({
      model: 'claude-3-sonnet-20240229',
      max_tokens: 1000,
      messages: [{
        role: 'user',
        content: `Create a detailed recipe based on this request: "${prompt}". 
        Return a JSON object with: title, cookTime, servings, ingredients (array), instructions (array), tags (array).
        Make it practical and delicious.`
      }]
    });
    
    return JSON.parse(response.content[0].text);
  } catch (error) {
    console.error('Claude API Error:', error);
    throw error;
  }
};