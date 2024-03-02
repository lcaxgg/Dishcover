//
//  ApiConstants.swift
//  FoodGrab
//
//  Created by j8bok on 12/29/23.
//

import Foundation

struct ApiConstants {
    private static let baseUrl = "https://www.themealdb.com"
    private static let path = "/api/json/v1/1/filter.php?"
    
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
    
    struct Url {
        static let lists = [baseUrl + path + beefParam,
                            baseUrl + path + chickenParam,
                            baseUrl + path + dessertParam,
                            baseUrl + path + lambParam,
                            baseUrl + path + miscellaneousParam,
                            baseUrl + path + pastaParam,
                            baseUrl + path + porkParam,
                            baseUrl + path + seafoodParam,
                            baseUrl + path + sideParam,
                            baseUrl + path + starterParam,
                            baseUrl + path + veganParam,
                            baseUrl + path + vegetarianParam,
                            baseUrl + path + breakfastParam,
                            baseUrl + path + goatParam]
    }
}
