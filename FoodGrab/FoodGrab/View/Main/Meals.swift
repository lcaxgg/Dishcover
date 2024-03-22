//
//  Meals.swift
//  FoodGrab
//
//  Created by j8bok on 9/28/23.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct Meals: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    @State private var isPresentedRecipe: Bool = false
    
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()
    @StateObject private var mealsCategoriesViewModel: MealsCategoriesViewModel = MealsCategoriesViewModel()
    
    var body: some View {
        ZStack {
            Color(AppConstants.lightGrayOne)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // MARK: - HEADER
                
                MealsHeader(screenSize: screenSize)
                    .environmentObject(searchViewModel)
                    .environmentObject(mealsCategoriesViewModel)
                
                Spacer()
                
                // MARK: - BODY
                
                CategoriesList(screenSize: screenSize)
                    .environmentObject(searchViewModel)
                    .environmentObject(mealsCategoriesViewModel)
                   
                Catalog(screenSize: screenSize, completion: { idMeal in
                    processMealTap(with: idMeal)
                })
                .environmentObject(searchViewModel)
                .environmentObject(mealsCategoriesViewModel)
                .fullScreenCover(isPresented: $isPresentedRecipe) {
                    Recipes(isPresentedRecipe: $isPresentedRecipe,
                            screenSize: screenSize)
                }
                
                // MARK: - FOOTER
            }
        }//: ZStack
        .navigationBarTitle(AppConstants.mainTitle, displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
        .onDisappear(perform: {
            searchViewModel.setIsSearchFieldFocused(with: false)
            searchViewModel.setSearchText(with: AppConstants.emptyString)
        })
    }
    
    private func processMealTap(with idMeal: String) {
        RecipesViewModel.setRecipeId(with: idMeal)
        
        let recipesData = MealsService.fetchRecipesData()
        let detail = recipesData?.first
        
        if detail != nil {
            searchViewModel.setIsSearchFieldFocused(with: false)
            isPresentedRecipe = true
        }
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Meals(screenSize: CGSize()) }
//}
