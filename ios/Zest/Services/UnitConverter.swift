import Foundation

class UnitConverter {
    static let shared = UnitConverter()
    
    private let conversions: [String: [String: Double]] = [
        "g": ["g": 1, "kg": 0.001, "oz": 0.035274, "lb": 0.00220462],
        "kg": ["g": 1000, "kg": 1, "oz": 35.274, "lb": 2.20462],
        "oz": ["g": 28.3495, "kg": 0.0283495, "oz": 1, "lb": 0.0625],
        "lb": ["g": 453.592, "kg": 0.453592, "oz": 16, "lb": 1],
        "ml": ["ml": 1, "l": 0.001, "cup": 0.00422675, "tbsp": 0.067628, "tsp": 0.202884],
        "l": ["ml": 1000, "l": 1, "cup": 4.22675, "tbsp": 67.628, "tsp": 202.884],
        "cup": ["ml": 236.588, "l": 0.236588, "cup": 1, "tbsp": 16, "tsp": 48],
        "tbsp": ["ml": 14.7868, "l": 0.0147868, "cup": 0.0625, "tbsp": 1, "tsp": 3],
        "tsp": ["ml": 4.92892, "l": 0.00492892, "cup": 0.0208333, "tbsp": 0.333333, "tsp": 1]
    ]
    
    func convert(amount: Double, from fromUnit: String, to toUnit: String) -> Double {
        if fromUnit == toUnit { return amount }
        guard let conversion = conversions[fromUnit]?[toUnit] else { return amount }
        return round(amount * conversion * 100) / 100
    }
    
    func scaleRecipe(amount: Double, originalServings: Int, newServings: Int) -> Double {
        let scale = Double(newServings) / Double(originalServings)
        return round(amount * scale * 100) / 100
    }
}
