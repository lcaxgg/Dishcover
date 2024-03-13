//
//  Catalog.swift
//  FoodGrab
//
//  Created by j8bok on 10/13/23.
//

import SwiftUI

struct Catalog: View {
    
    // MARK: - PROPERTIES
    
    var geometry: GeometryProxy
    @ObservedObject var mealsViewModel: MealsViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    var completion: () -> Void
    
    @State private var searchedMealsData: [MealsDetails]?
    
    var body: some View {
        ZStack {
            Color(AppConstants.lightGrayOne)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 10.0),
                    GridItem(.flexible(), spacing: 10.0)
                ], spacing: 17.0) {
                    
                    let mealsData =  MealsService.fetchMealsData(per: mealsViewModel.mealCategory, in: mealsViewModel.mealsData)
                    
                    ForEach((!searchViewModel.getSearchText().isEmpty ? searchedMealsData : mealsData) ?? [] , id: \.idMeal) { item in
                        VStack {
                            VStack(spacing: 0) {
                                if let strMealThumb = item.strMealThumb,
                                   let image = MealsService.fetchImageFromLocal(urlString: strMealThumb) {
                                    
                                    let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.emptyString)
                                    
                                    Image(uiImage: image)
                                        .configure(withModifier: imageModifier)
                                    
                                    HStack {
                                        let textModifier = [TextModifier(font: .system(size: 15.0, weight: .regular, design: .rounded), color: AppConstants.black)]
                                        
                                        Text(item.strMeal)
                                            .configure(withModifier: textModifier)
                                            .lineLimit(2)
                                            .frame(height: geometry.size.height * 0.06)
                                        
                                        Spacer()
                                        
                                        Color(AppConstants.green)
                                            .frame(width: geometry.size.width * 0.09, height: geometry.size.height * 0.04)
                                            .cornerRadius(11.0)
                                            .overlay(
                                                Group {
                                                    let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.white)
                                                    
                                                    Image(systemName: AppConstants.arrowUpForwardSquare)
                                                        .configure(withModifier: imageModifier)
                                                        .frame(width: geometry.size.width * 0.023, height: geometry.size.height * 0.023)
                                                }
                                            )
                                    }
                                    .padding()
                                    .padding(.bottom, 2.0)
                                    .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.06)
                                    .background(Color(AppConstants.white))
                                    .onTapGesture {
                                        completion()
                                    }
                                } else {
                                    Color(AppConstants.lightGrayOne)
                                        .overlay(
                                            Group {
                                                let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.lightGrayThree)
                                                
                                                Image(systemName: AppConstants.photoFill)
                                                    .configure(withModifier: imageModifier)
                                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.3)
                                            }
                                        )
                                }
                            }
                            .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.3)
                        }
                        .background(Color(AppConstants.lightGrayTwo))
                        .cornerRadius(11.0)
                    }
                    .onChange(of: searchViewModel.getSearchText()) { searchText in
                        if !searchText.isEmpty {
                            searchedMealsData = MealsService.searchMeal(in: mealsData, with: searchViewModel.getSearchText())
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
    GeometryReader { geometry in
        CustomPreview { Catalog(geometry: geometry,
                                mealsViewModel: MealsViewModel(),
                                searchViewModel: SearchViewModel(), completion: {}) }
    }
}
