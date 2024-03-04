//
//  MealsModel.swift
//  FoodGrab
//
//  Created by j8bok on 12/29/23.
//

import Foundation

struct MealsModel: Codable {
    let meals: [MealsDetails]?
}

struct MealsDetails: Codable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String?

    init(idMeal: String, strMeal: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}

struct MealsDetailsModel {
    var idMeal: Int64 = 0
    var strMeal: String = AppConstants.emptyString
    var strMealThumb: String = AppConstants.emptyString
}
