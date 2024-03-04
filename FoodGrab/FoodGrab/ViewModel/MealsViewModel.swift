//
//  MealsViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 12/30/23.
//

import Foundation
import CoreData

class MealsViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var mealsData: Dictionary<String, [MealsDetails]> = Dictionary()
    @Published var mealCategory: String = AppConstants.beef
    @Published var mealsDetails: MealsDetails = MealsDetails(idMeal: AppConstants.emptyString,
                                                             strMeal: AppConstants.emptyString,
                                                             strMealThumb: AppConstants.emptyString)
    
    private var mealsDetailsModel = MealsDetailsModel()
    
    // MARK: - METHOD
    
    func initMealsDetails(with entity: NSManagedObject) -> MealsDetails {
        if entity.responds(to: NSSelectorFromString(AppConstants.idMeal)) {
            if let idMeal = entity.value(forKey: AppConstants.idMeal) as? Int64 {
                mealsDetails.idMeal = String(idMeal)
            }
        }
        
        if entity.responds(to: NSSelectorFromString(AppConstants.strMeal)) {
            mealsDetails.strMeal = entity.value(forKey: AppConstants.strMeal) as! String
        }
        
        if entity.responds(to: NSSelectorFromString(AppConstants.strMealThumb)) {
            mealsDetails.strMealThumb = entity.value(forKey: AppConstants.strMealThumb) as? String
        }
        
        return mealsDetails
    }
    
    func setMealsDetails(with mealsDetails: MealsDetails) {
        self.setIdMeal(with: (Int64(mealsDetails.idMeal) ?? Int64(AppConstants.emptyString)) ?? 0)
        self.setStrMeal(with: mealsDetails.strMeal)
        self.setStrMealThumb(with: mealsDetails.strMealThumb ?? AppConstants.emptyString)
    }
    
    // MARK: - GETTER
    
    func getIdMeal() -> Int64 {
        mealsDetailsModel.idMeal
    }
    
    func getStrMeal() -> String {
        mealsDetailsModel.strMeal
    }
    
    func getStrMealThumb() -> String {
        mealsDetailsModel.strMealThumb
    }
    
    // MARK: - SETTER
    
    func setIdMeal(with idMeal: Int64) {
        mealsDetailsModel.idMeal = idMeal
    }
    
    func setStrMeal(with StrMeal: String) {
        mealsDetailsModel.strMeal = StrMeal
    }
    
    func setStrMealThumb(with strMealThumb: String) {
        mealsDetailsModel.strMealThumb = strMealThumb
    }
}
