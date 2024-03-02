//
//  AllCategories.swift
//  FoodGrab
//
//  Created by j8bok on 2/9/24.
//

/**
 
 Currently working on this module
 
 */

import SwiftUI

struct AllCategories: View {
    
    // MARK: - PROPERTIES
    static private var mealsCategoriesViewModel = MealsCategoriesViewModel()
    
    var geometry: GeometryProxy
    var mealsViewModel: MealsViewModel
    @Binding var shouldShowAllCategories: Bool
    var completion: (Int, MealsCategoriesModel) -> Void
    
    var body: some View {
        VStack {
            
            // MARK: - HEADER
            
            VStack {
                HStack {
                    let firstTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.02, weight: .regular, design: .rounded), color: AppConstants.green)]
                    
                    Text(AppConstants.close)
                        .configure(withModifier: firstTextModifier)
                        .onTapGesture {
                            shouldShowAllCategories.toggle()
                        }
                    
                    Spacer()
                    
                    let secondTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.02, weight: .semibold, design: .rounded), color: AppConstants.black)]
                    
                    Text(AppConstants.allCategories)
                        .configure(withModifier: secondTextModifier)
                    
                    Spacer()
                    
                    let thirdTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.02, weight: .light, design: .rounded), color: AppConstants.white)]
                    
                    Text(AppConstants.close)
                        .configure(withModifier: thirdTextModifier)
                }
                .padding(.horizontal, 15.0)
                .padding(.top, 15.0)
                .padding(.bottom, 9.0)
                
                Color(AppConstants.lightGrayThree)
                    .frame(height: 1.0)
            }//: VStack
            .background(Color(AppConstants.white))
            
            Spacer()
            
            // MARK: - BODY
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 10.0),
                    GridItem(.flexible(), spacing: 10.0)
                ], spacing: 17.0) {
                    
                    ForEach(Array(AllCategories.mealsCategoriesViewModel.mealsCategories.enumerated()), id: \.1.id) { index, categoryModel in
                        VStack {
                            VStack(spacing: 0) {
                                let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.lightGrayThree)
                                
                                Image(categoryModel.name.lowercased())
                                    .configure(withModifier: imageModifier)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                                
                                let firstTextModifier = [TextModifier(font: .system(size: 15, weight: .semibold, design: .rounded), color: AppConstants.black)]
                                
                                Text(categoryModel.name)
                                    .configure(withModifier: firstTextModifier)
                                
                                let secondTextModifier = [TextModifier(font: .system(size: 13, weight: .regular, design: .rounded), color: AppConstants.lightGrayThree)]
                                
                                let itemCount = "\(mealsViewModel.mealsData[categoryModel.name]?.count ?? 0)"
                                let additionalLabel = mealsViewModel.mealsData[categoryModel.name]!.count > 1 ? AppConstants.items : AppConstants.item
                                
                                Text(itemCount + AppConstants.whiteSpace + additionalLabel)
                                    .configure(withModifier: secondTextModifier)
                                    .padding(.top, 5.0)
                            }
                            .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.3)
                            .onTapGesture {
                                completion(index, categoryModel)
                            }
                        }
                        .background(Color(AppConstants.white))
                        .cornerRadius(11.0)
                    }
                }
                .padding()
            }
            // MARK: - FOOTER
            
        }//: VStack
        .background(Color(AppConstants.lightGrayOne))
    }
}

// MARK: - PREVIEW

struct AllCategories_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let shouldShowAllCategories = Binding<Bool>(
                get: { false },
                set: { _ in }
            )
            
            CustomPreview { AllCategories(geometry: geometry,
                                          mealsViewModel: MealsViewModel(),
                                          shouldShowAllCategories: shouldShowAllCategories, completion: { _,_  in }) }
        }
    }
}
