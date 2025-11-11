import Foundation

class NutritionService {
    static let shared = NutritionService()
    private let healthKitService = HealthKitService.shared
    
    private init() {}
    
    func logNutrition(_ nutrition: NutritionInfo, date: Date = Date()) {
        healthKitService.syncNutrition(nutrition, date: date)
    }
    
    func requestHealthPermissions(completion: @escaping (Bool) -> Void) {
        healthKitService.requestAuthorization(completion: completion)
    }
}
