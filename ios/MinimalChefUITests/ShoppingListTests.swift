import XCTest

class ShoppingListTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testShoppingListDisplays() throws {
        // Navigate to shopping tab
        app.tabBars.buttons["Shopping"].tap()
        
        // Verify shopping list screen is displayed
        XCTAssertTrue(app.navigationBars["Shopping"].exists)
    }
    
    func testAddItemToShoppingList() throws {
        app.tabBars.buttons["Shopping"].tap()
        
        // Find text field
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.exists)
        
        // Type item name
        textField.tap()
        textField.typeText("Tomatoes")
        
        // Tap add button
        app.buttons["Add"].tap()
        
        // Verify item appears
        XCTAssertTrue(app.staticTexts["Tomatoes"].exists)
    }
    
    func testCheckOffItem() throws {
        app.tabBars.buttons["Shopping"].tap()
        
        // Wait for items to load
        sleep(1)
        
        // Tap first checkbox
        let checkbox = app.buttons.matching(identifier: "circle").firstMatch
        if checkbox.exists {
            checkbox.tap()
            
            // Verify it changed to checked
            XCTAssertTrue(app.buttons.matching(identifier: "checkmark.circle.fill").firstMatch.exists)
        }
    }
}
