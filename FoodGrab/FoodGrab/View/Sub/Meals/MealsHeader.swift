//
//  MealsHeader.swift
//  FoodGrab
//
//  Created by j8bok on 3/19/24.
//

import SwiftUI

struct MealsHeader: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    
    @State private var searchText: String = AppConstants.emptyString
    @FocusState private var isSearchFieldFocused: Bool
    
    @EnvironmentObject var searchViewModel: SearchViewModel
    @EnvironmentObject var mealsCategoriesViewModel: MealsCategoriesViewModel
    
    var body: some View {
        VStack {
            SearchField(screenSize: screenSize, searchText: $searchText)
                .environmentObject(searchViewModel)
                .padding(.top, screenSize.height * 0.014)
                .focused($isSearchFieldFocused)
                .onTapGesture {
                    searchViewModel.setIsSearchFieldFocused(with: true)
                    searchViewModel.setIsSearching(with: true)
                }
                .bindFocusState($searchViewModel.searchModel.isSearchFieldFocused, with: _isSearchFieldFocused)
            
            MealsHeaderLabel(screenSize: screenSize)
                .padding(.top, screenSize.width * 0.04)
        }//: VStack
        .padding(.horizontal, screenSize.width * 0.05)
    }
}

// MARK: - PREVIEW
//
//@available(iOS 17, *)
//#Preview(traits: .fixedLayout(width: UIScreen.main.bounds.width, height: 100.0)) {
//    CustomPreview {
//        MealsHeader(screenSize: CGSize())
//            .padding(.horizontal, 15.0)
//    }
//}
