import Foundation

class LocaleManager {
    static let shared = LocaleManager()
    private var translations: [String: [String: String]] = [:]
    
    private init() {}
    
    func loadLocale(_ locale: String) -> [String: String] {
        if let cached = translations[locale] {
            return cached
        }
        
        guard let path = Bundle.main.path(forResource: locale, ofType: "lang", inDirectory: "Resources/Locales"),
              let content = try? String(contentsOfFile: path) else {
            return [:]
        }
        
        var map: [String: String] = [:]
        content.components(separatedBy: .newlines).forEach { line in
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if !trimmed.isEmpty && !trimmed.hasPrefix("#") {
                let parts = trimmed.components(separatedBy: "=")
                if parts.count >= 2 {
                    let key = parts[0].trimmingCharacters(in: .whitespaces)
                    let value = parts[1...].joined(separator: "=").trimmingCharacters(in: .whitespaces)
                    map[key] = value
                }
            }
        }
        
        translations[locale] = map
        return map
    }
    
    func t(_ translations: [String: String], _ key: String) -> String {
        return translations[key] ?? key
    }
}
