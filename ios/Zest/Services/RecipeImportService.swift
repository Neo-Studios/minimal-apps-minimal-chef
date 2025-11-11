import Foundation

class RecipeImportService {
    func importFromUrl(_ urlString: String) async throws -> [String: Any] {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let html = String(data: data, encoding: .utf8) ?? ""
        
        let titlePattern = "<title>(.*?)</title>"
        let regex = try NSRegularExpression(pattern: titlePattern)
        let range = NSRange(html.startIndex..., in: html)
        
        var name = "Imported Recipe"
        if let match = regex.firstMatch(in: html, range: range) {
            if let titleRange = Range(match.range(at: 1), in: html) {
                name = String(html[titleRange])
            }
        }
        
        return [
            "name": name,
            "ingredients": [],
            "instructions": [],
            "prepTime": 0,
            "cookTime": 0,
            "servings": 1
        ]
    }
}
