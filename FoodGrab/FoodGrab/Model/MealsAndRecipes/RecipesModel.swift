//
//  RecipesModel.swift
//  FoodGrab
//
//  Created by j8bok on 3/3/24.
//

import Foundation
import SwiftUI

struct RecipesModel: Codable {
    let meals: [[String: String?]]
}

struct RecipesDetailsModel {
    var idMeal: Int64 = 0
    var strMeal: String = AppConstants.emptyString
    var strCategory: String = AppConstants.emptyString
    var strIngredients: String = AppConstants.emptyString
    var strIngredientsDictionary: [String: String] = Dictionary()
    var strIngredientsWithMeasures: [String: String] = Dictionary()
    var strMeasures: String = AppConstants.emptyString
    var strMeasuresDictionary: [String: String] = Dictionary()
    var strInstructions: String = AppConstants.emptyString
    var strMealThumb: String = AppConstants.emptyString
    var strYoutube: String = AppConstants.emptyString
}
