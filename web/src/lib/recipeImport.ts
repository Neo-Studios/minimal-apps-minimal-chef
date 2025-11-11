export async function importRecipeFromUrl(url: string) {
  const response = await fetch('/api/import-recipe', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ url })
  })
  return response.json()
}
