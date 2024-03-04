//
//  MealsCategoriesViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 10/11/23.
//

import Foundation


class MealsCategoriesViewModel: ObservableObject {
    @Published var mealsCategories: [MealsCategoriesModel] = Array()

    init() {
        mealsCategories = [
            MealsCategoriesModel(name: AppConstants.beef),
            MealsCategoriesModel(name: AppConstants.chicken),
            MealsCategoriesModel(name: AppConstants.dessert),
            MealsCategoriesModel(name: AppConstants.lamb),
            MealsCategoriesModel(name: AppConstants.miscellaneous),
            MealsCategoriesModel(name: AppConstants.pasta),
            MealsCategoriesModel(name: AppConstants.pork),
            MealsCategoriesModel(name: AppConstants.seaFood),
            MealsCategoriesModel(name: AppConstants.side),
            MealsCategoriesModel(name: AppConstants.starter),
            MealsCategoriesModel(name: AppConstants.vegan),
            MealsCategoriesModel(name: AppConstants.vegetarian),
            MealsCategoriesModel(name: AppConstants.breakFast),
            MealsCategoriesModel(name: AppConstants.goat)
        ]
    }
}
