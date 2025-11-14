import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private let center = UNUserNotificationCenter.current()
    
    private init() {
        setupNotificationCategories()
    }
    
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            return granted
        } catch {
            print("Error requesting notification authorization: \(error)")
            return false
        }
    }
    
    private func setupNotificationCategories() {
        // Timer actions
        let timerDismissAction = UNNotificationAction(
            identifier: "TIMER_DISMISS",
            title: "Dismiss",
            options: []
        )
        let timerRestartAction = UNNotificationAction(
            identifier: "TIMER_RESTART",
            title: "Restart",
            options: []
        )
        let timerCategory = UNNotificationCategory(
            identifier: "TIMER_COMPLETE",
            actions: [timerDismissAction, timerRestartAction],
            intentIdentifiers: [],
            options: []
        )
        
        // Meal reminder actions
        let mealViewAction = UNNotificationAction(
            identifier: "MEAL_VIEW",
            title: "View Recipe",
            options: [.foreground]
        )
        let mealSnoozeAction = UNNotificationAction(
            identifier: "MEAL_SNOOZE",
            title: "Remind Later",
            options: []
        )
        let mealCategory = UNNotificationCategory(
            identifier: "MEAL_REMINDER",
            actions: [mealViewAction, mealSnoozeAction],
            intentIdentifiers: [],
            options: []
        )
        
        center.setNotificationCategories([timerCategory, mealCategory])
    }
    
    func scheduleTimerNotification(timerName: String, timerId: String, seconds: Int) {
        let content = UNMutableNotificationContent()
        content.title = "⏰ Timer Complete!"
        content.body = "\(timerName) is done"
        content.sound = .defaultCritical
        content.categoryIdentifier = "TIMER_COMPLETE"
        content.userInfo = ["timerId": timerId]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: "timer_\(timerId)", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling timer notification: \(error)")
            }
        }
    }
    
    func scheduleMealReminder(mealName: String, mealTime: Date, recipeId: String) {
        let content = UNMutableNotificationContent()
        content.title = "🍽️ Meal Reminder"
        content.body = "Time for \(mealName)"
        content.sound = .default
        content.categoryIdentifier = "MEAL_REMINDER"
        content.userInfo = ["recipeId": recipeId]
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: mealTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "meal_\(recipeId)_\(mealTime.timeIntervalSince1970)",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling meal reminder: \(error)")
            }
        }
    }
    
    func scheduleRecipeSuggestion(recipeName: String, recipeId: String) {
        let content = UNMutableNotificationContent()
        content.title = "🍳 Recipe Suggestion"
        content.body = "Try making \(recipeName) today!"
        content.sound = .default
        content.userInfo = ["recipeId": recipeId]
        
        // Schedule for 10 AM
        var components = DateComponents()
        components.hour = 10
        components.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: "recipe_suggestion_\(recipeId)",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling recipe suggestion: \(error)")
            }
        }
    }
    
    func scheduleShoppingReminder(itemCount: Int) {
        let content = UNMutableNotificationContent()
        content.title = "🛒 Shopping Reminder"
        content.body = "You have \(itemCount) items on your shopping list"
        content.sound = .default
        
        // Schedule for tomorrow at 9 AM
        var components = DateComponents()
        components.hour = 9
        components.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(
            identifier: "shopping_reminder",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling shopping reminder: \(error)")
            }
        }
    }
    
    func cancelNotification(identifier: String) {
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func cancelAllNotifications() {
        center.removeAllPendingNotificationRequests()
    }
    
    func getPendingNotifications() async -> [UNNotificationRequest] {
        return await center.pendingNotificationRequests()
    }
}
