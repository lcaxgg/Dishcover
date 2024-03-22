//
//  MealsHeaderLabel.swift
//  FoodGrab
//
//  Created by j8bok on 3/19/24.
//

import SwiftUI

struct MealsHeaderLabel: View {
    
    // MARK: - PROPERTIES
   
    var screenSize: CGSize
    
    @State private var isPresentedAllCategories: Bool = false
    @EnvironmentObject var searchViewModel: SearchViewModel
    @EnvironmentObject var mealsCategoriesViewModel: MealsCategoriesViewModel
    
    var body: some View {
        HStack {
            let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.0237, weight: .semibold, design: .rounded), color: AppConstants.black)]
            
            Text(AppConstants.categories)
                .configure(withModifier: textModifier)
            
            Spacer()
            
            HStack {
                let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.021, weight: .regular, design: .rounded), color: AppConstants.green)]
                
                Text(AppConstants.seeAll)
                    .configure(withModifier: textModifier)
                
                let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.green)
                
                Image(systemName: AppConstants.chevronRight)
                    .configure(withModifier: imageModifier)
                    .frame(width: screenSize.width * 0.016, height: screenSize.height * 0.016)
            }
            .onTapGesture {
                searchViewModel.setIsSearchFieldFocused(with: false)
                searchViewModel.setSearchText(with: AppConstants.emptyString)
                
                isPresentedAllCategories.toggle()
            }
            .sheet(isPresented: $isPresentedAllCategories) {
                AllCategories(screenSize: screenSize,
                              isPresentedAllCategories: $isPresentedAllCategories,
                              completion: { index, categoryModel in
                    
                    MealsViewModel.setMealCategory(with: categoryModel.name)
                    RecipesViewModel.setMealCategory(with: categoryModel.name)
                    
                    isPresentedAllCategories.toggle()
                    mealsCategoriesViewModel.setSelectedIndex(with: index)
                })
                .environmentObject(mealsCategoriesViewModel)
            }
        }
        .padding(.horizontal, screenSize.width * 0.05)
    }
}

// MARK: - PREVIEW

@available(iOS 17, *)
#Preview(traits: .fixedLayout(width: UIScreen.main.bounds.width, height: 50.0)) {
    CustomPreview {
        MealsHeaderLabel(screenSize: CGSize())
            .padding(.horizontal, 15.0)
    }
}
