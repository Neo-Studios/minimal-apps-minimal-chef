export type Unit = 'g' | 'kg' | 'oz' | 'lb' | 'ml' | 'l' | 'cup' | 'tbsp' | 'tsp' | 'fl oz'

const conversions: Record<string, Record<string, number>> = {
  g: { g: 1, kg: 0.001, oz: 0.035274, lb: 0.00220462 },
  kg: { g: 1000, kg: 1, oz: 35.274, lb: 2.20462 },
  oz: { g: 28.3495, kg: 0.0283495, oz: 1, lb: 0.0625 },
  lb: { g: 453.592, kg: 0.453592, oz: 16, lb: 1 },
  ml: { ml: 1, l: 0.001, cup: 0.00422675, tbsp: 0.067628, tsp: 0.202884, 'fl oz': 0.033814 },
  l: { ml: 1000, l: 1, cup: 4.22675, tbsp: 67.628, tsp: 202.884, 'fl oz': 33.814 },
  cup: { ml: 236.588, l: 0.236588, cup: 1, tbsp: 16, tsp: 48, 'fl oz': 8 },
  tbsp: { ml: 14.7868, l: 0.0147868, cup: 0.0625, tbsp: 1, tsp: 3, 'fl oz': 0.5 },
  tsp: { ml: 4.92892, l: 0.00492892, cup: 0.0208333, tbsp: 0.333333, tsp: 1, 'fl oz': 0.166667 },
  'fl oz': { ml: 29.5735, l: 0.0295735, cup: 0.125, tbsp: 2, tsp: 6, 'fl oz': 1 }
}

export function convertUnit(amount: number, fromUnit: Unit, toUnit: Unit): number {
  if (fromUnit === toUnit) return amount
  const conversion = conversions[fromUnit]?.[toUnit]
  if (!conversion) return amount
  return Math.round(amount * conversion * 100) / 100
}

export function scaleRecipe(ingredients: Array<{amount: number, unit: string}>, originalServings: number, newServings: number) {
  const scale = newServings / originalServings
  return ingredients.map(ing => ({
    ...ing,
    amount: Math.round(ing.amount * scale * 100) / 100
  }))
}
