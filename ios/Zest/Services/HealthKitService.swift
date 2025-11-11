import Foundation
import HealthKit

class HealthKitService {
    static let shared = HealthKitService()
    private let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }
        
        let typesToWrite: Set<HKSampleType> = [
            HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToWrite, read: nil) { success, error in
            completion(success)
        }
    }
    
    func syncNutrition(_ nutrition: NutritionInfo, date: Date) {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        let proteinType = HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!
        let carbsType = HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!
        let fatType = HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!
        
        let calorieSample = HKQuantitySample(type: calorieType, quantity: HKQuantity(unit: .kilocalorie(), doubleValue: Double(nutrition.calories)), start: date, end: date)
        let proteinSample = HKQuantitySample(type: proteinType, quantity: HKQuantity(unit: .gram(), doubleValue: nutrition.protein), start: date, end: date)
        let carbsSample = HKQuantitySample(type: carbsType, quantity: HKQuantity(unit: .gram(), doubleValue: nutrition.carbs), start: date, end: date)
        let fatSample = HKQuantitySample(type: fatType, quantity: HKQuantity(unit: .gram(), doubleValue: nutrition.fat), start: date, end: date)
        
        healthStore.save([calorieSample, proteinSample, carbsSample, fatSample]) { success, error in
            if let error = error {
                print("Error syncing to HealthKit: \(error)")
            }
        }
    }
}
