import Foundation

struct ShoppingListCategorizer {
    
    private static let categories: [String: [String]] = [
        "Produce": ["apple", "banana", "carrot", "lettuce", "tomato", "potato", "onion", "garlic", "broccoli", "spinach", "grape", "orange", "berry", "cucumber", "pepper", "mushroom", "avocado", "lemon", "lime"],
        "Meat": ["chicken", "beef", "pork", "fish", "sausage", "bacon", "ham", "turkey", "lamb", "shrimp", "salmon"],
        "Dairy": ["milk", "cheese", "yogurt", "butter", "cream", "egg", "sour cream", "cottage cheese"],
        "Bakery": ["bread", "bagel", "muffin", "pastry", "cake", "cookie", "donut", "croissant", "bun"],
        "Pantry": ["rice", "pasta", "flour", "sugar", "salt", "pepper", "oil", "cereal", "soup", "canned", "beans", "sauce", "jam", "honey", "nuts", "oats", "coffee", "tea"],
        "Frozen": ["ice cream", "pizza", "vegetable mix", "fries", "waffles", "frozen meal", "berries frozen"],
        "Beverages": ["water", "juice", "soda", "coffee", "tea", "milk alternative", "beer", "wine"],
        "Household": ["soap", "detergent", "toilet paper", "paper towel", "cleaner", "sponge", "trash bag"],
        "Snacks": ["chips", "crackers", "chocolate", "candy", "granola bar", "popcorn"],
        "Spices": ["cumin", "paprika", "oregano", "basil", "thyme", "cinnamon", "nutmeg"]
    ]
    
    static func categorize(itemName: String) -> String {
        let lowercasedItemName = itemName.lowercased()
        for (category, keywords) in categories {
            if keywords.contains(where: { lowercasedItemName.contains($0) }) {
                return category
            }
        }
        return "Other"
    }
}
