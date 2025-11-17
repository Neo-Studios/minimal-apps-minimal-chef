package com.neostudios.zest.util

object ShoppingListCategorizer {

    private val categories = mapOf(
        "Produce" to listOf("apple", "banana", "carrot", "lettuce", "tomato", "potato", "onion", "garlic", "broccoli", "spinach", "grape", "orange", "berry", "cucumber", "pepper", "mushroom", "avocado", "lemon", "lime"),
        "Meat" to listOf("chicken", "beef", "pork", "fish", "sausage", "bacon", "ham", "turkey", "lamb", "shrimp", "salmon"),
        "Dairy" to listOf("milk", "cheese", "yogurt", "butter", "cream", "egg", "sour cream", "cottage cheese"),
        "Bakery" to listOf("bread", "bagel", "muffin", "pastry", "cake", "cookie", "donut", "croissant", "bun"),
        "Pantry" to listOf("rice", "pasta", "flour", "sugar", "salt", "pepper", "oil", "cereal", "soup", "canned", "beans", "sauce", "jam", "honey", "nuts", "oats", "coffee", "tea"),
        "Frozen" to listOf("ice cream", "pizza", "vegetable mix", "fries", "waffles", "frozen meal", "berries frozen"),
        "Beverages" to listOf("water", "juice", "soda", "coffee", "tea", "milk alternative", "beer", "wine"),
        "Household" to listOf("soap", "detergent", "toilet paper", "paper towel", "cleaner", "sponge", "trash bag"),
        "Snacks" to listOf("chips", "crackers", "chocolate", "candy", "granola bar", "popcorn"),
        "Spices" to listOf("cumin", "paprika", "oregano", "basil", "thyme", "cinnamon", "nutmeg")
    )

    fun categorizeItem(itemName: String): String {
        val lowerCaseItemName = itemName.lowercase()
        for ((category, keywords) in categories) {
            if (keywords.any { lowerCaseItemName.contains(it) }) {
                return category
            }
        }
        return "Other"
    }
}
