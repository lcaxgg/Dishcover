//
//  RecipesViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 3/4/24.
//

import Foundation

class RecipesViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    private var recipesDetailsModel = RecipesDetailsModel()
    
    // MARK: - METHODS
    
    func setRecipesDetails(with recipeDetails: Dictionary<String, String?>?) {
        self.setIdMeal(with: Int64((recipeDetails?[AppConstants.idMeal] ?? AppConstants.emptyString) ?? AppConstants.emptyString) ?? 0)
        self.setStrMeal(with: recipeDetails?[AppConstants.strMeal]! ?? AppConstants.emptyString)
        self.setStrCategory(with: recipeDetails?[AppConstants.strCategory]! ?? AppConstants.emptyString)
        
        self.setStrIngredients(with: [AppConstants.strIngredient1: recipeDetails?[AppConstants.strIngredient1]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient2: recipeDetails?[AppConstants.strIngredient2]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient3: recipeDetails?[AppConstants.strIngredient3]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient4: recipeDetails?[AppConstants.strIngredient4]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient5: recipeDetails?[AppConstants.strIngredient5]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient6: recipeDetails?[AppConstants.strIngredient6]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient7: recipeDetails?[AppConstants.strIngredient7]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient8: recipeDetails?[AppConstants.strIngredient8]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient9: recipeDetails?[AppConstants.strIngredient9]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient10: recipeDetails?[AppConstants.strIngredient10]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient11: recipeDetails?[AppConstants.strIngredient11]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient12: recipeDetails?[AppConstants.strIngredient12]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient13: recipeDetails?[AppConstants.strIngredient13]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient14: recipeDetails?[AppConstants.strIngredient14]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient15: recipeDetails?[AppConstants.strIngredient15]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient16: recipeDetails?[AppConstants.strIngredient16]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient17: recipeDetails?[AppConstants.strIngredient17]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient18: recipeDetails?[AppConstants.strIngredient18]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient19: recipeDetails?[AppConstants.strIngredient19]! ?? AppConstants.emptyString,
                                      AppConstants.strIngredient20: recipeDetails?[AppConstants.strIngredient20]! ?? AppConstants.emptyString])
        
        self.setStrMeasures(with: [AppConstants.strMeasure1: recipeDetails?[AppConstants.strMeasure1]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure2: recipeDetails?[AppConstants.strMeasure2]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure3: recipeDetails?[AppConstants.strMeasure3]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure4: recipeDetails?[AppConstants.strMeasure4]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure5: recipeDetails?[AppConstants.strMeasure5]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure6: recipeDetails?[AppConstants.strMeasure6]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure7: recipeDetails?[AppConstants.strMeasure7]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure8: recipeDetails?[AppConstants.strMeasure8]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure9: recipeDetails?[AppConstants.strMeasure9]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure10: recipeDetails?[AppConstants.strMeasure10]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure11: recipeDetails?[AppConstants.strMeasure11]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure12: recipeDetails?[AppConstants.strMeasure12]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure13: recipeDetails?[AppConstants.strMeasure13]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure14: recipeDetails?[AppConstants.strMeasure14]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure15: recipeDetails?[AppConstants.strMeasure15]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure16: recipeDetails?[AppConstants.strMeasure16]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure17: recipeDetails?[AppConstants.strMeasure17]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure18: recipeDetails?[AppConstants.strMeasure18]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure19: recipeDetails?[AppConstants.strMeasure19]! ?? AppConstants.emptyString,
                                   AppConstants.strMeasure20: recipeDetails?[AppConstants.strMeasure20]! ?? AppConstants.emptyString])
        
        self.setStrInstructions(with: recipeDetails?[AppConstants.strInstructions]! ?? AppConstants.emptyString)
        self.setStrMealThumb(with: recipeDetails?[AppConstants.strMealThumb]! ?? AppConstants.emptyString)
        self.setStrYoutube(with: recipeDetails?[AppConstants.strYoutube]! ?? AppConstants.emptyString)
    }
    
    // MARK: - GETTER
    
    func getIdMeal() -> Int64 {
        recipesDetailsModel.idMeal
    }
    
    func getStrMeal() -> String {
        recipesDetailsModel.strMeal
    }
    
    func getStrCategory() -> String {
        recipesDetailsModel.strCategory
    }
    
    func getStrIngredients() -> String {
        recipesDetailsModel.strIngredients
    }
    
    func getStrMeasures() -> String {
        recipesDetailsModel.strMeasures
    }
    
    func getStrInstructions() -> String {
        recipesDetailsModel.strInstructions
    }
    
    func getStrMealThumb() -> String {
        recipesDetailsModel.strMealThumb
    }
    
    func getStrYoutube() -> String {
        recipesDetailsModel.strYoutube
    }
    
    // MARK: - SETTER
    
    func setIdMeal(with idMeal: Int64) {
        recipesDetailsModel.idMeal = idMeal
    }
    
    func setStrMeal(with StrMeal: String) {
        recipesDetailsModel.strMeal = StrMeal
    }
    
    func setStrCategory(with strCategory: String) {
        recipesDetailsModel.strCategory = strCategory
    }
    
    func setStrIngredients(with strIngredients: Dictionary<String, String>) {
        recipesDetailsModel.strIngredients = strIngredients.description
    }
    
    func setStrMeasures(with strMeasures: Dictionary<String, String>) {
        recipesDetailsModel.strMeasures = strMeasures.description
    }
    
    func setStrInstructions(with strInstructions: String) {
        recipesDetailsModel.strInstructions = strInstructions
    }
    
    func setStrMealThumb(with strMealThumb: String) {
        recipesDetailsModel.strMealThumb = strMealThumb
    }
    
    func setStrYoutube(with strYoutube: String) {
        recipesDetailsModel.strYoutube = strYoutube
    }
}