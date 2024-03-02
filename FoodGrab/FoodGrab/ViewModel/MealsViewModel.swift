//
//  MealsViewModel.swift
//  FoodGrab
//
//  Created by jayvee on 12/30/23.
//

import Foundation
import CoreData

class MealsViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var mealsData: Dictionary<String, [MealsDetails]> = Dictionary()
    @Published var mealKey: String = AppConstants.beef
    @Published var mealsDetails: MealsDetails = MealsDetails(idMeal: AppConstants.emptyString,
                                                             strMeal: AppConstants.emptyString,
                                                             strMealThumb: AppConstants.emptyString)
    
    func initMealsDetails(with entity: NSManagedObject) -> MealsDetails {
   
        
        if entity.responds(to: NSSelectorFromString(AppConstants.idMealKey)) {
            if let idMeal = entity.value(forKey: AppConstants.idMealKey) as? Int64 {
                mealsDetails.idMeal = String(idMeal)
            }
        }
  
        if entity.responds(to: NSSelectorFromString(AppConstants.strMealKey)) {
            mealsDetails.strMeal = entity.value(forKey: AppConstants.strMealKey) as! String
        }

        if entity.responds(to: NSSelectorFromString(AppConstants.strMealThumbKey)) {
            mealsDetails.strMealThumb = entity.value(forKey: AppConstants.strMealThumbKey) as? String
        }

        
        return mealsDetails
    }
}
