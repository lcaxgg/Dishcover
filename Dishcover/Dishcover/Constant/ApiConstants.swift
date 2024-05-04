//
//  ApiConstants.swift
//  Dishcover
//
//  Created by j8bok on 12/29/23.
//

import Foundation

struct ApiConstants {
    static let baseUrl = "https://www.themealdb.com"
    private static let mealPath = "/api/json/v1/1/filter.php?"
    static let recipePath = "/api/json/v1/1/lookup.php?"
    
    private static let beefParam = "c=Beef"
    private static let chickenParam = "c=Chicken"
    private static let dessertParam = "c=Dessert"
    private static let lambParam = "c=Lamb"
    private static let miscellaneousParam = "c=Miscellaneous"
    private static let pastaParam = "c=Pasta"
    private static let porkParam = "c=Pork"
    private static let seafoodParam = "c=Seafood"
    private static let sideParam = "c=Side"
    private static let starterParam = "c=Starter"
    private static let veganParam = "c=Vegan"
    private static let vegetarianParam = "c=Vegetarian"
    private static let breakfastParam = "c=Breakfast"
    private static let goatParam = "c=Goat"
    
    static let recipeParam = "i="
    
    struct Url {
        static let mealsList = [baseUrl + mealPath + beefParam,
                                baseUrl + mealPath + chickenParam,
                                baseUrl + mealPath + dessertParam,
                                baseUrl + mealPath + lambParam,
                                baseUrl + mealPath + miscellaneousParam,
                                baseUrl + mealPath + pastaParam,
                                baseUrl + mealPath + porkParam,
                                baseUrl + mealPath + seafoodParam,
                                baseUrl + mealPath + sideParam,
                                baseUrl + mealPath + starterParam,
                                baseUrl + mealPath + veganParam,
                                baseUrl + mealPath + vegetarianParam,
                                baseUrl + mealPath + breakfastParam,
                                baseUrl + mealPath + goatParam]
    }
}
