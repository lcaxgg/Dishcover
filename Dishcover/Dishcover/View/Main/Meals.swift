//
//  Meals.swift
//  Dishcover
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
    
    @Binding var navigationPath: NavigationPath
    
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
                
                Catalog(screenSize: screenSize, navigationPath: $navigationPath, completion: { idMeal in
                    processMealTap(with: idMeal)
                })
                .environmentObject(searchViewModel)
                .environmentObject(mealsCategoriesViewModel)
//                .fullScreenCover(isPresented: $isPresentedRecipe) {
//                    Recipes(isPresentedRecipe: $isPresentedRecipe,
//                            screenSize: screenSize)
//                }
                
                // MARK: - FOOTER
            }
        }//: ZStack
        .padding(.bottom, 10.0)
        .onDisappear(perform: {
            searchViewModel.setIsSearchFieldFocused(with: false)
            searchViewModel.setSearchText(with: AppConstants.emptyString)
        })
    }
}

extension Meals {
    private func processMealTap(with idMeal: String) {
        RecipesViewModel.setRecipeId(with: idMeal)
        
        let recipesData = RecipesViewModel.getRecipesDataById()
        let detail = recipesData?.first
        
        if detail != nil {
            searchViewModel.setIsSearchFieldFocused(with: false)
            isPresentedRecipe = true
        }
        
        navigationPath.append(NavigationRoute.recipes)
        NavigationViewModel.setNavigationViewItemTag(with: NavigationViewItemEnum.recipe.rawValue)
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Meals(screenSize: CGSize()) }
//}
