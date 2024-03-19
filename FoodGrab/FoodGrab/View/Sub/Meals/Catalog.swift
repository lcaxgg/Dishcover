//
//  Catalog.swift
//  FoodGrab
//
//  Created by j8bok on 10/13/23.
//

import SwiftUI

struct Catalog: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    var completion: (String) -> Void
    
    @State private var searchedMealsData: [MealsDetailsModel]?
    @EnvironmentObject var searchViewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            Color(AppConstants.lightGrayOne)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 10.0),
                    GridItem(.flexible(), spacing: 10.0)
                ], spacing: 17.0) {
                    
                    let mealsData = MealsService.fetchMealsData()
                    
                    ForEach((!searchViewModel.getSearchText().wrappedValue.isEmpty ? searchedMealsData : mealsData) ?? [] , id: \.idMeal) { item in
                        VStack {
                            VStack(spacing: 0) {
                                if let image = MealsService.fetchImageFromLocal(urlString: item.strMealThumb ?? AppConstants.emptyString) {
                                    let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.emptyString)
                                    
                                    Image(uiImage: image)
                                        .configure(withModifier: imageModifier)
                                    
                                    HStack {
                                        let textModifier = [TextModifier(font: .system(size: 15.0, weight: .regular, design: .rounded), color: AppConstants.black)]
                                        
                                        Text(item.strMeal)
                                            .configure(withModifier: textModifier)
                                            .lineLimit(2)
                                            .frame(height: screenSize.height * 0.06)
                                        
                                        Spacer()
                                        
                                        let isEmptyRecipesData = MealsService.checkEmptyRecipesData()
                                        
                                        Color(isEmptyRecipesData ? AppConstants.lightGrayTwo : AppConstants.green)
                                            .frame(width: screenSize.width * 0.09, height: screenSize.height * 0.04)
                                            .cornerRadius(11.0)
                                            .overlay(
                                                Group {
                                                    let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.white)
                                                    
                                                    Image(systemName: AppConstants.arrowUpForwardSquare)
                                                        .configure(withModifier: imageModifier)
                                                        .frame(width: screenSize.width * 0.023, height: screenSize.height * 0.023)
                                                }
                                            )
                                    }
                                    .padding(.horizontal, 10.0)
                                    .padding(.vertical, 5.0)
                                    .frame(width: screenSize.width * 0.4, height: screenSize.height * 0.07)
                                    .background(Color(AppConstants.white))
                                    .onTapGesture {
                                        completion(item.idMeal)
                                    }
                                } else {
                                    Color(AppConstants.lightGrayOne)
                                        .overlay(
                                            Group {
                                                let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.lightGrayThree)
                                                
                                                Image(systemName: AppConstants.photoFill)
                                                    .configure(withModifier: imageModifier)
                                                    .frame(width: screenSize.width * 0.1, height: screenSize.height * 0.3)
                                            }
                                        )
                                }
                            }
                            .frame(width: screenSize.width * 0.4, height: screenSize.height * 0.3)
                        }
                        .background(Color(AppConstants.lightGrayTwo))
                        .cornerRadius(11.0)
                    }
                    .onChange(of: searchViewModel.getSearchText().wrappedValue) { searchText in
                        if !searchText.isEmpty {
                            searchedMealsData = MealsService.searchMeal(in: mealsData, with: searchText)
                        }
                    }
                }
                .padding()
            }
        }//: ZStack
    }
}

// MARK: - PREVIEW

#Preview {
    Group {
        CustomPreview { Catalog(screenSize: CGSize(), completion: { idMeal in }) }
    }
}
