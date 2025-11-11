import { NextRequest, NextResponse } from 'next/server'

export async function POST(request: NextRequest) {
  const { url } = await request.json()
  
  try {
    const response = await fetch(url)
    const html = await response.text()
    
    // Basic scraping - extract title and content
    const titleMatch = html.match(/<title>(.*?)<\/title>/)
    const name = titleMatch ? titleMatch[1] : 'Imported Recipe'
    
    return NextResponse.json({
      name,
      ingredients: [],
      instructions: [],
      prepTime: 0,
      cookTime: 0,
      servings: 1
    })
  } catch (error) {
    return NextResponse.json({ error: 'Failed to import recipe' }, { status: 500 })
  }
}
