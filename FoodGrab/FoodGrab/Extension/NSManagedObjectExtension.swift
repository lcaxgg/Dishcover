//
//  NSManagedObjectExtension.swift
//  FoodGrab
//
//  Created by j8bok on 3/3/24.
//

import Foundation
import CoreData

extension NSManagedObject {
    func setMealDetails(with mealsDetails: MealsDetails) {
        let mealsViewModel = MealsViewModel()
        mealsViewModel.setMealsDetails(with: mealsDetails)
        
        self.setValue(mealsViewModel.getIdMeal(), forKey: AppConstants.idMeal)
        self.setValue(mealsViewModel.getStrMeal(), forKey: AppConstants.strMeal)
        self.setValue(mealsViewModel.getStrMealThumb(), forKey: AppConstants.strMealThumb)
        
        CoreDataManager.sharedInstance.save()
    }
    
    func setRecipeDetails(with recipeDetails: Dictionary<String, String?>?) {
        let recipesViewModel = RecipesViewModel()
        recipesViewModel.setRecipesDetails(with: recipeDetails)
        
        self.setValue(recipesViewModel.getIdMeal(), forKey: AppConstants.idMeal)
        self.setValue(recipesViewModel.getStrMeal(), forKey: AppConstants.strMeal)
        self.setValue(recipesViewModel.getStrCategory(), forKey: AppConstants.strCategory)
        self.setValue(recipesViewModel.getStrIngredients(), forKey: AppConstants.strIngredients)
        self.setValue(recipesViewModel.getStrMeasures(), forKey: AppConstants.strMeasures)
        self.setValue(recipesViewModel.getStrInstructions(), forKey: AppConstants.strInstructions)
        self.setValue(recipesViewModel.getStrMealThumb(), forKey: AppConstants.strMealThumb)
        self.setValue(recipesViewModel.getStrYoutube(), forKey: AppConstants.strYoutube)
        
        CoreDataManager.sharedInstance.save()
    }
}
