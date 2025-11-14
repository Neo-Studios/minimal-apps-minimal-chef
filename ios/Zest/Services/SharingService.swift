import Foundation
import UIKit
import SwiftUI

class SharingService {
    static let shared = SharingService()
    
    private init() {}
    
    func shareRecipe(recipe: Recipe, from viewController: UIViewController) {
        var itemsToShare: [Any] = []
        
        // Add recipe name and basic info
        let recipeText = """
        \(recipe.name)
        
        Prep Time: \(recipe.prepTime) min
        Cook Time: \(recipe.cookTime) min
        Servings: \(recipe.servings)
        
        Ingredients:
        \(recipe.ingredients.map { "• \($0.amount) \($0.unit) \($0.name)" }.joined(separator: "\n"))
        
        Instructions:
        \(recipe.instructions.enumerated().map { "\($0.offset + 1). \($0.element)" }.joined(separator: "\n"))
        """
        
        itemsToShare.append(recipeText)
        
        // Add image URL if available
        if let imageUrl = recipe.imageUrl, let url = URL(string: imageUrl) {
            itemsToShare.append(url)
        }
        
        let activityViewController = UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities: nil
        )
        
        // For iPad - set popover presentation
        if let popover = activityViewController.popoverPresentationController {
            popover.sourceView = viewController.view
            popover.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                       y: viewController.view.bounds.midY,
                                       width: 0,
                                       height: 0)
            popover.permittedArrowDirections = []
        }
        
        viewController.present(activityViewController, animated: true)
    }
    
    func shareText(_ text: String, from viewController: UIViewController) {
        let activityViewController = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        
        if let popover = activityViewController.popoverPresentationController {
            popover.sourceView = viewController.view
            popover.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                       y: viewController.view.bounds.midY,
                                       width: 0,
                                       height: 0)
            popover.permittedArrowDirections = []
        }
        
        viewController.present(activityViewController, animated: true)
    }
}

// SwiftUI wrapper
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
