import Foundation
import UIKit

class InstacartService {
    static let shared = InstacartService()
    
    private let instacartAppScheme = "instacart://"
    private let instacartWebURL = "https://www.instacart.com"
    
    private init() {}
    
    func sendToInstacart(ingredients: [String]) {
        let searchQuery = ingredients.joined(separator: ", ")
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Try to open Instacart app first
        if let appURL = URL(string: instacartAppScheme),
           UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            // Fall back to web browser
            if let webURL = URL(string: "\(instacartWebURL)/store/search?query=\(encodedQuery)") {
                UIApplication.shared.open(webURL)
            }
        }
    }
    
    func isInstacartInstalled() -> Bool {
        if let url = URL(string: instacartAppScheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}
