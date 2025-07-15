---
layout: page
title: API Reference
permalink: /api/
---

# API Reference

## Authentication Endpoints

### POST /api/auth/register
Register a new user account.

**Request Body:**
```json
{
  "username": "string",
  "email": "string"
}
```

**Response:**
```json
{
  "message": "Registration successful"
}
```

### POST /api/auth/login
Send login verification code to email.

**Request Body:**
```json
{
  "email": "string"
}
```

**Response:**
```json
{
  "message": "Login code sent"
}
```

### POST /api/auth/verify
Verify email code and authenticate user.

**Request Body:**
```json
{
  "code": "string"
}
```

**Response:**
```json
{
  "message": "Verification successful",
  "user": {
    "username": "string",
    "email": "string",
    "verified": true
  }
}
```

## Recipe Endpoints

### POST /api/import-recipe
Import recipe from URL using web scraping.

**Request Body:**
```json
{
  "url": "string"
}
```

**Response:**
```json
{
  "recipe": {
    "name": "string",
    "description": "string",
    "image": "string",
    "prepTime": "string",
    "cookTime": "string",
    "servings": "number",
    "ingredients": ["string"],
    "instructions": ["string"]
  }
}
```

## Data Storage

### LocalStorage Keys

| Key | Description | Format |
|-----|-------------|--------|
| `minimalChefRecipes` | Imported recipes | Array of Recipe objects |
| `minimalChefCustomRecipes` | User-created recipes | Array of Recipe objects |
| `minimalChefFavorites` | Favorite recipe IDs | Array of numbers |
| `minimalChefShoppingList` | Shopping list items | Array of ShoppingItem objects |
| `minimalChefUser` | Current user data | User object |
| `minimalChefSession` | Session expiry timestamp | Number |

### Recipe Object Structure

```typescript
interface Recipe {
  id: number;
  name: string;
  description?: string;
  image?: string;
  ingredients: string[];
  instructions: string[];
  servings: number;
  prepTime?: string;
  cookTime?: string;
  tags?: string[];
  source: 'imported' | 'custom' | 'database';
  favorite?: boolean;
  createdAt: string;
}
```

### Shopping Item Structure

```typescript
interface ShoppingItem {
  id: number;
  text: string;
  completed: boolean;
  category?: string;
}
```

## Error Handling

All API endpoints return standard HTTP status codes:

- `200` - Success
- `400` - Bad Request (invalid input)
- `405` - Method Not Allowed
- `500` - Internal Server Error

Error responses include a message:
```json
{
  "error": "Error description"
}
```