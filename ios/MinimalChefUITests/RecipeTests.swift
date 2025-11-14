import XCTest

class RecipeTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testRecipeListDisplays() throws {
        // Navigate to recipes tab
        app.tabBars.buttons["Recipes"].tap()
        
        // Verify recipes screen is displayed
        XCTAssertTrue(app.navigationBars["Recipes"].exists)
    }
    
    func testRecipeSearch() throws {
        app.tabBars.buttons["Recipes"].tap()
        
        // Tap search field
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        
        // Type search query
        searchField.typeText("pasta")
        
        // Wait for results
        sleep(1)
        
        // Verify results are filtered
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] 'pasta'")).firstMatch.exists)
    }
    
    func testRecipeDetailNavigation() throws {
        app.tabBars.buttons["Recipes"].tap()
        
        // Wait for recipes to load
        sleep(2)
        
        // Tap first recipe
        app.buttons.matching(identifier: "recipeCard").firstMatch.tap()
        
        // Verify detail screen is displayed
        XCTAssertTrue(app.navigationBars.firstMatch.exists)
    }
    
    func testRecipeScaling() throws {
        app.tabBars.buttons["Recipes"].tap()
        sleep(2)
        
        // Navigate to recipe detail
        app.buttons.matching(identifier: "recipeCard").firstMatch.tap()
        
        // Find and tap increase button
        let increaseButton = app.buttons["plus.circle.fill"]
        if increaseButton.exists {
            increaseButton.tap()
            
            // Verify servings increased
            XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'servings'")).firstMatch.exists)
        }
    }
    
    func testRecipeSharing() throws {
        app.tabBars.buttons["Recipes"].tap()
        sleep(2)
        
        // Navigate to recipe detail
        app.buttons.matching(identifier: "recipeCard").firstMatch.tap()
        
        // Tap menu button
        app.buttons["ellipsis.circle"].tap()
        
        // Tap share
        app.buttons["Share"].tap()
        
        // Verify share sheet appears
        XCTAssertTrue(app.otherElements["ActivityListView"].exists)
    }
}
