//
//  Meals.swift
//  FoodGrab
//
//  Created by jayvee on 9/28/23.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct Meals: View {
    
    // MARK: - PROPERTIES
    
    @State private var searchText: String = AppConstants.emptyString
    @State private var selectedIndex: Int = 0
    @State private var selectedTab: Int = 0
    
    @State private var isDownloadComplete: Bool = false
    @State private var isLoadingVisible: Bool = true
    @State private var isAnimating: Bool = false
    @State private var shouldShowMainScreen: Bool = false
    @State private var shouldShowAllCategories: Bool = false
    @FocusState private var isSearchFieldFocused: Bool
    
    @ObservedObject private var mealsViewModel = MealsViewModel()
    @ObservedObject private var searchViewModel = SearchViewModel()
    private var mealsCategoriesViewModel = MealsCategoriesViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(AppConstants.lightGrayOne)
                    .edgesIgnoringSafeArea(.all)
                
                if !isDownloadComplete {
                    VStack(spacing: -55.0) {
                        Logo(color: AppConstants.green)
                            .frame(width: isAnimating ?  nil : geometry.size.width * 0.3, height: isAnimating ? nil : geometry.size.height * 0.3)
                            .scaleEffect(isAnimating ? 3.0 : 1.0)
                            .opacity(shouldShowMainScreen ? 0.0 : 1.0)
                        
                        LoadingIndicator(animation: .threeBalls, color: Color(AppConstants.green), size: .medium, speed: .normal)
                            .opacity(isLoadingVisible ? 1 : 0)
                    }
                } else {
                    VStack {
                        
                        // MARK: - HEADER
                        
                        SearchField(geometry: geometry,
                                    searchText: $searchText,
                                    searchViewModel: searchViewModel)
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .padding(.top, geometry.size.height * 0.014)
                        .focused($isSearchFieldFocused)
                        .onTapGesture {
                            isSearchFieldFocused = true
                        }
                        .bindFocusState($searchViewModel.searchModel.isSearchFieldFocused, with: _isSearchFieldFocused)
                        
                        HStack {
                            let textModifier = [TextModifier(font: .system(size: geometry.size.height * 0.0237, weight: .semibold, design: .rounded), color: AppConstants.black)]
                            
                            Text(AppConstants.categories)
                                .configure(withModifier: textModifier)
                            
                            Spacer()
                            
                            HStack {
                                let textModifier = [TextModifier(font: .system(size: geometry.size.height * 0.021, weight: .regular, design: .rounded), color: AppConstants.green)]
                                
                                Text(AppConstants.seeAll)
                                    .configure(withModifier: textModifier)
                                
                                let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.green)
                                
                                Image(systemName: AppConstants.chevronRight)
                                    .configure(withModifier: imageModifier)
                                    .frame(width: geometry.size.width * 0.016, height: geometry.size.height * 0.016)
                            }
                            .onTapGesture {
                                shouldShowAllCategories.toggle()
                                isSearchFieldFocused = false
                            }
                            .sheet(isPresented: $shouldShowAllCategories) {
                                AllCategories(geometry: geometry,
                                              mealsViewModel: mealsViewModel,
                                              shouldShowAllCategories: $shouldShowAllCategories, completion: { index, categoryModel in
                                    selectedIndex = index
                                    mealsViewModel.mealKey = categoryModel.name
                                    shouldShowAllCategories.toggle()
                                })
                            }
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .padding(.top, geometry.size.width * 0.04)
                        
                        Spacer()
                        
                        // MARK: - BODY
                        
                        ScrollViewReader { scrollViewProxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: geometry.size.width * 0.04) {
                                    ForEach(Array(mealsCategoriesViewModel.mealsCategories.enumerated()), id: \.1.id) { index, categoryModel in
                                        
                                        let bgColor = selectedIndex == index ? AppConstants.green : AppConstants.white
                                        let fontColor = selectedIndex == index ? AppConstants.white : AppConstants.black
                                        let fontWeight = selectedIndex == index ? Font.Weight.semibold : Font.Weight.regular
                                        let attribute =  ButtonOneAttributes(text: categoryModel.name, bgColor: bgColor, fontColor: fontColor, fontWeight: fontWeight, fontSize: geometry.size.height * 0.02, cornerRadius: 6.0)
                                        
                                        ButtonOne(attribute: attribute)
                                            .frame(width: index == 4 ? geometry.size.width * 0.3 : geometry.size.width * 0.26, height: geometry.size.height * 0.05)
                                            .onTapGesture {
                                                selectedIndex = index
                                                mealsViewModel.mealKey = categoryModel.name
                                                isSearchFieldFocused = false
                                                
                                                withAnimation {
                                                    scrollViewProxy.scrollTo(index, anchor: .center)
                                                }
                                            }
                                            .id(index)
                                    }
                                }
                                .padding(.horizontal, geometry.size.width * 0.05)
                            }
                            .frame(width: geometry.size.width)
                            .padding(.top, geometry.size.width * 0.02)
                            .onChange(of: selectedIndex) { newIndex in
                                withAnimation {
                                    scrollViewProxy.scrollTo(newIndex, anchor: .center)
                                }
                            }
                        }
                        
                        // MARK: - FOOTER
                        
                        TabView(selection: $selectedTab) {
                            Catalog(geometry: geometry,
                                    mealsViewModel: mealsViewModel,
                                    searchViewModel: searchViewModel, completion: {
                                isSearchFieldFocused = false
                            })
                            .tag(0)
                            .frame(width: geometry.size.width)
                            .background(Color(AppConstants.lightGrayOne))
                            .tabItem {
                                Image(systemName: AppConstants.squareGrid)
                                Text(AppConstants.meals)
                            }
                            
                        }
                        .accentColor(Color(AppConstants.green))
                        .onTapGesture {
                            isSearchFieldFocused = false
                        }
                    }
                }
            }
        }//: ZStack
        .navigationBarTitle(isDownloadComplete ? AppConstants.mainTitle : AppConstants.emptyString, displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.white
            
            processMealsDisplay()
        }
    }
    
    private func processMealsDisplay() {
        MealsService.processMealsDataForDisplay(with: mealsViewModel) { success in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.65) {
                    isLoadingVisible.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                    withAnimation(Animation.easeOut(duration: 0.40)) {
                        isAnimating.toggle()
                    }
                    
                    withAnimation(Animation.easeIn(duration: 0.30)) {
                        isDownloadComplete = success
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        CustomPreview { Meals() }
            .previewInterfaceOrientation(.portrait)
    }
}


