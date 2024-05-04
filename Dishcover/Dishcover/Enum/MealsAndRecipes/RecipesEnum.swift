//
//  RecipesEnum.swift
//  Dishcover
//
//  Created by j8bok on 3/4/24.
//

import Foundation

enum RecipesEnum {
    case beef_recipe
    case chicken_recipe
    case dessert_recipe
    case lamb_recipe
    case miscellaneous_recipe
    case pasta_recipe
    case pork_recipe
    case seafood_recipe
    case side_recipe
    case starter_recipe
    case vegan_recipe
    case vegetarian_recipe
    case breakfast_recipe
    case goat_recipe

    static func fromString(_ str: String) -> RecipesEnum? {
        switch str {
        case "Beef_Recipe": return .beef_recipe
        case "Chicken_Recipe": return .chicken_recipe
        case "Dessert_Recipe": return .dessert_recipe
        case "Lamb_Recipe": return .lamb_recipe
        case "Miscellaneous_Recipe": return .miscellaneous_recipe
        case "Pasta_Recipe": return .pasta_recipe
        case "Pork_Recipe": return .pork_recipe
        case "Seafood_Recipe": return .seafood_recipe
        case "Side_Recipe": return .side_recipe
        case "Starter_Recipe": return .starter_recipe
        case "Vegan_Recipe": return .vegan_recipe
        case "Vegetarian_Recipe": return .vegetarian_recipe
        case "Breakfast_Recipe": return .breakfast_recipe
        case "Goat_Recipe": return .goat_recipe
        default: return nil
        }
    }
}
