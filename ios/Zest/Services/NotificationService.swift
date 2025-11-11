import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            completion(granted)
        }
    }
    
    func scheduleExpirationAlert(itemName: String, expirationDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Ingredient Expiring Soon"
        content.body = "\(itemName) expires soon"
        content.sound = .default
        
        let calendar = Calendar.current
        let twoDaysBefore = calendar.date(byAdding: .day, value: -2, to: expirationDate)!
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: twoDaysBefore)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "expiration-\(itemName)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendTimerComplete(timerName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Complete"
        content.body = "\(timerName) is done!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timer-\(timerName)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendMealPrepReminder(mealName: String, time: String) {
        let content = UNMutableNotificationContent()
        content.title = "Meal Prep Reminder"
        content.body = "Time to prepare \(mealName) for \(time)"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "meal-prep-\(mealName)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
