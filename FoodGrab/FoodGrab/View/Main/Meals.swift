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
    
    @State private var searchText: String = AppConstants.emptyString
    @State private var selectedIndex: Int = 0
    
    @State private var isPresentedAllCategories: Bool = false
    @State private var isPresentedRecipe: Bool = false
    @FocusState private var isSearchFieldFocused: Bool
    
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()
    
    static private var mealsCategoriesViewModel: MealsCategoriesViewModel = MealsCategoriesViewModel()
    
    var body: some View {
        ZStack {
            Color(AppConstants.lightGrayOne)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // MARK: - HEADER
                
                SearchField(screenSize: screenSize,
                            searchText: $searchText,
                            searchViewModel: searchViewModel)
                .padding(.horizontal, screenSize.width * 0.05)
                .padding(.top, screenSize.height * 0.014)
                .focused($isSearchFieldFocused)
                .onTapGesture {
                    isSearchFieldFocused = true
                    searchViewModel.setIsSearching(with: true)
                }
                .bindFocusState($searchViewModel.searchModel.isSearchFieldFocused, with: _isSearchFieldFocused)
                
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
                        isPresentedAllCategories.toggle()
                        isSearchFieldFocused = false
                    }
                    .sheet(isPresented: $isPresentedAllCategories) {
                        AllCategories(screenSize: screenSize,
                                      shouldShowAllCategories: $isPresentedAllCategories, completion: { index, categoryModel in
                            
                            selectedIndex = index
                            MealsViewModel.setMealCategory(with: categoryModel.name)
                            RecipesViewModel.setMealCategory(with: categoryModel.name)
                            
                            isPresentedAllCategories.toggle()
                        })
                    }
                }
                .padding(.horizontal, screenSize.width * 0.05)
                .padding(.top, screenSize.width * 0.04)
                
                Spacer()
                
                // MARK: - BODY
                
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: screenSize.width * 0.04) {
                            ForEach(Array(Meals.mealsCategoriesViewModel.mealsCategories.enumerated()), id: \.1.id) { index, categoryModel in
                                
                                let bgColor = selectedIndex == index ? AppConstants.green : AppConstants.white
                                let fontColor = selectedIndex == index ? AppConstants.white : AppConstants.black
                                let fontWeight = selectedIndex == index ? Font.Weight.semibold : Font.Weight.regular
                                let attribute =  ButtonOneAttributes(text: categoryModel.name, bgColor: bgColor, fontColor: fontColor, fontWeight: fontWeight, fontSize: screenSize.height * 0.02, cornerRadius: 6.0)
                                
                                ButtonOne(attribute: attribute)
                                    .frame(width: index == 4 ? screenSize.width * 0.3 : screenSize.width * 0.26, height: screenSize.height * 0.05)
                                    .onTapGesture {
                                        selectedIndex = index
                                        
                                        MealsViewModel.setMealCategory(with: categoryModel.name)
                                        RecipesViewModel.setMealCategory(with: categoryModel.name)
                                        
                                        isSearchFieldFocused = false
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
                    .onChange(of: selectedIndex) { newIndex in
                        withAnimation {
                            scrollViewProxy.scrollTo(newIndex, anchor: .center)
                        }
                    }
                }
                
                Catalog(screenSize: screenSize,
                        searchViewModel: searchViewModel, completion: { idMeal in
                    
                    processMealTap(with: idMeal)
                })
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
            isSearchFieldFocused = false
            searchViewModel.setSearchText(with: AppConstants.emptyString)
        })
    }
    
    private func processMealTap(with idMeal: String) {
        RecipesViewModel.setRecipeId(with: idMeal)
        
        let recipesData = MealsService.fetchRecipesData()
        let detail = recipesData?.first
        
        if detail != nil {
            isSearchFieldFocused = false
            isPresentedRecipe = true
        }
    }
}

// MARK: - PREVIEW

#Preview {
    CustomPreview { Meals(screenSize: CGSize()) }
}
