//
//  MealsViewModel.swift
//  Dishcover
//
//  Created by j8bok on 12/30/23.
//

import Foundation
import CoreData

class MealsViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    static let sharedInstance: MealsViewModel = MealsViewModel()
    
    private var mealCategory: String = AppConstants.beef
    private var mealsData: Dictionary<String, [MealsDetailsModel]> = Dictionary()
    private var mealsDetailsModel: MealsDetailsModel = MealsDetailsModel(idMeal: AppConstants.emptyString,
                                                                         strMeal: AppConstants.emptyString,
                                                                         strMealThumb: AppConstants.emptyString)
    
    // MARK: - METHOD
    
    private init() {}
    
    func initMealsDetails(with entity: NSManagedObject) -> MealsDetailsModel {
        if entity.responds(to: NSSelectorFromString(AppConstants.idMeal)) {
            if let idMeal = entity.value(forKey: AppConstants.idMeal) as? Int64 {
                setIdMeal(with: idMeal)
            }
        }
        
        if entity.responds(to: NSSelectorFromString(AppConstants.strMeal)) {
            if let strMeal = entity.value(forKey: AppConstants.strMeal) as? String {
                setStrMeal(with: strMeal)
            }
        }
        
        if entity.responds(to: NSSelectorFromString(AppConstants.strMealThumb)) {
            if let strMealThumb = entity.value(forKey: AppConstants.strMealThumb) as? String {
                setStrMealThumb(with: strMealThumb)
            }
        }
        
        return mealsDetailsModel
    }
    
    func setMealsDetails(with mealsDetailsModel: MealsDetailsModel) {
        self.setIdMeal(with: (Int64(mealsDetailsModel.idMeal) ?? Int64(AppConstants.emptyString)) ?? 0)
        self.setStrMeal(with: mealsDetailsModel.strMeal)
        self.setStrMealThumb(with: mealsDetailsModel.strMealThumb ?? AppConstants.emptyString)
    }
    
    func searchMeal(with searchText: String) -> [MealsDetailsModel]? {
        let mealsDataByCategory = MealsViewModel.getMealsDataByCategory()
        let searchedMeal = mealsDataByCategory?.filter { $0.strMeal.localizedStandardContains(searchText) }
        
        return searchedMeal
    }
}

extension MealsViewModel {
    
    // MARK: - GETTER FOR MODEL PROPERTIES
    
    func getIdMeal() -> Int64 {
        Int64(mealsDetailsModel.idMeal) ?? 0
    }
    
    func getStrMeal() -> String {
        mealsDetailsModel.strMeal
    }
    
    func getStrMealThumb() -> String {
        mealsDetailsModel.strMealThumb ?? AppConstants.emptyString
    }
    
    // MARK: - SETTER FOR MODEL PROPERTIES
    
    func setIdMeal(with idMeal: Int64) {
        mealsDetailsModel.idMeal = String(idMeal)
    }
    
    func setStrMeal(with StrMeal: String) {
        mealsDetailsModel.strMeal = StrMeal
    }
    
    func setStrMealThumb(with strMealThumb: String) {
        mealsDetailsModel.strMealThumb = strMealThumb
    }
    
    // MARK: - GETTER FOR VIEWMODEL PROPERTIES
    
    static func getMealCategory() -> String {
        sharedInstance.mealCategory
    }
    
    static func getMealsData() -> Dictionary<String, [MealsDetailsModel]> {
        sharedInstance.mealsData
    }
    
    static func getMealsDataByCategory() -> [MealsDetailsModel]? {
        let category = MealsViewModel.getMealCategory()
        let mealsData = MealsViewModel.getMealsData()
        
        return mealsData[category]
    }
    
    // MARK: - SETTER FOR VIEWMODEL PROPERTIES
    
    static func setMealCategory(with category: String) {
        sharedInstance.mealCategory = category
    }
    
    static func setMealsData(with key: String, andWith value: Array<MealsDetailsModel>) {
        sharedInstance.mealsData[key] = value
    }
}
