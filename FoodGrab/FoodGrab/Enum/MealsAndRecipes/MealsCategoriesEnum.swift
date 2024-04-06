//
//  MealsCategoriesEnum.swift
//  FoodGrab
//
//  Created by j8bok on 1/28/24.
//

import Foundation

enum MealsCategoriesEnum {
    case beef
    case chicken
    case dessert
    case lamb
    case miscellaneous
    case pasta
    case pork
    case seafood
    case side
    case starter
    case vegan
    case vegetarian
    case breakfast
    case goat

    static func fromString(_ str: String) -> MealsCategoriesEnum? {
        switch str {
        case "Beef": return .beef
        case "Chicken": return .chicken
        case "Dessert": return .dessert
        case "Lamb": return .lamb
        case "Miscellaneous": return .miscellaneous
        case "Pasta": return .pasta
        case "Pork": return .pork
        case "Seafood": return .seafood
        case "Side": return .side
        case "Starter": return .starter
        case "Vegan": return .vegan
        case "Vegetarian": return .vegetarian
        case "Breakfast": return .breakfast
        case "Goat": return .goat
        default: return nil
        }
    }
}
