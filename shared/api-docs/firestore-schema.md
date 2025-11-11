# Firestore Document Structure

## Collections

### users/{userId}
```json
{
  "email": "string",
  "displayName": "string",
  "photoURL": "string",
  "createdAt": "timestamp"
}
```

### recipes/{recipeId}
```json
{
  "name": "string",
  "userId": "string",
  "ingredients": [
    {
      "name": "string",
      "amount": "string",
      "unit": "string"
    }
  ],
  "instructions": ["string"],
  "prepTime": "number",
  "cookTime": "number",
  "servings": "number",
  "cuisineType": "string",
  "mealType": "string",
  "imageUrl": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### mealPlans/{userId}/plans/{date}
```json
{
  "date": "string (YYYY-MM-DD)",
  "meals": [
    {
      "recipeId": "string",
      "recipeName": "string",
      "mealType": "string"
    }
  ]
}
```

### shoppingLists/{userId}/items/{itemId}
```json
{
  "name": "string",
  "amount": "string",
  "unit": "string",
  "checked": "boolean",
  "createdAt": "timestamp"
}
```
