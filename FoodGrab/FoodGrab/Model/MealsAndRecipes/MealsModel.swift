//
//  MealsModel.swift
//  FoodGrab
//
//  Created by j8bok on 12/29/23.
//

import Foundation

struct MealsModel: Codable {
    let meals: [MealsDetailsModel]?
}

struct MealsDetailsModel: Codable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String?

    init(idMeal: String, strMeal: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}

