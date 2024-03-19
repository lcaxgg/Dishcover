//
//  CategoriesList.swift
//  FoodGrab
//
//  Created by j8bok on 3/19/24.
//

import SwiftUI

struct CategoriesList: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    @EnvironmentObject var searchViewModel: SearchViewModel
    @EnvironmentObject var mealsCategoriesViewModel: MealsCategoriesViewModel
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: screenSize.width * 0.04) {
                    
                    let mealsCategories = mealsCategoriesViewModel.getMealsCategories()
                    
                    ForEach(Array(mealsCategories.enumerated()), id: \.1.id) { index, categoryModel in
                        let selectedIndex = mealsCategoriesViewModel.getSelectedIndex()
                        
                        let bgColor = selectedIndex == index ? AppConstants.green : AppConstants.white
                        let fontColor = selectedIndex == index ? AppConstants.white : AppConstants.black
                        let fontWeight = selectedIndex == index ? Font.Weight.semibold : Font.Weight.regular
                        let attribute =  ButtonOneAttributes(text: categoryModel.name, bgColor: bgColor, 
                                                             fontColor: fontColor, fontWeight: fontWeight,
                                                             fontSize: screenSize.height * 0.02, cornerRadius: 6.0)
                        
                        ButtonOne(attribute: attribute)
                            .frame(width: index == 4 ? screenSize.width * 0.3 : screenSize.width * 0.26, height: screenSize.height * 0.05)
                            .onTapGesture {
                                mealsCategoriesViewModel.setSelectedIndex(with: index)
                                
                                MealsViewModel.setMealCategory(with: categoryModel.name)
                                RecipesViewModel.setMealCategory(with: categoryModel.name)
                                
                                searchViewModel.setIsSearchFieldFocused(with: false)
                                searchViewModel.setSearchText(with: AppConstants.emptyString)
                                
                                withAnimation {
                                    scrollViewProxy.scrollTo(index, anchor: .center)
                                }
                            }
                            .id(index)
                    }
                }
                .padding(.horizontal, screenSize.width * 0.05)
            }
            .frame(width: screenSize.width)
            .padding(.top, screenSize.width * 0.02)
            .onChange(of: mealsCategoriesViewModel.getSelectedIndex()) { newIndex in
                withAnimation {
                    scrollViewProxy.scrollTo(newIndex, anchor: .center)
                }
            }
        }
    }
}


