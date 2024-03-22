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

    var screenSize: CGSize
    @Binding var isPresentedAllCategories: Bool
    @EnvironmentObject var mealsCategoriesViewModel: MealsCategoriesViewModel
  
    var completion: (Int, MealsCategoriesModel) -> Void
    
    var body: some View {
        VStack {
            
            // MARK: - HEADER
            
            VStack {
                HStack {
                    let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.022, weight: .regular, design: .rounded), color: AppConstants.green)]
                    
                    Text(AppConstants.close)
                        .configure(withModifier: firstTextModifier)
                        .onTapGesture {
                            isPresentedAllCategories.toggle()
                        }
                    
                    Spacer()
                    
                    let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.022, weight: .semibold, design: .rounded), color: AppConstants.black)]
                    
                    Text(AppConstants.allCategories)
                        .configure(withModifier: secondTextModifier)
                    
                    Spacer()
                    
                    let thirdTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.02, weight: .light, design: .rounded), color: AppConstants.white)]
                    
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
                    let mealsCategories = mealsCategoriesViewModel.getMealsCategories()
                    
                    ForEach(Array(mealsCategories.enumerated()), id: \.1.id) { index, categoryModel in
                        VStack(spacing: 5.0) {
                            let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.emptyString)
                            
                            Image(categoryModel.name.lowercased())
                                .configure(withModifier: imageModifier)
                                .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.1)
                            
                            let firstTextModifier = [TextModifier(font: .system(size: 15, weight: .semibold, design: .rounded), color: AppConstants.black)]
                            
                            VStack(spacing: 5.0) {
                                Text(categoryModel.name)
                                    .configure(withModifier: firstTextModifier)
                                
                                let secondTextModifier = [TextModifier(font: .system(size: 13, weight: .regular, design: .rounded), color: AppConstants.lightGrayThree)]
                                
                                let mealsData = MealsViewModel.getMealsData()
                                let itemCount = "\(mealsData[categoryModel.name]?.count ?? 0)"
                                let additionalLabel = mealsData[categoryModel.name]!.count > 1 ? AppConstants.items : AppConstants.item
                                
                                Text(itemCount + AppConstants.whiteSpaceString + additionalLabel)
                                    .configure(withModifier: secondTextModifier)
                            }
                        }
                        .frame(width: screenSize.width * 0.4, height: screenSize.height * 0.3)
                        .background(Color(AppConstants.white))
                        .cornerRadius(11.0)
                        .onTapGesture {
                            completion(index, categoryModel)
                        }
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

@available(iOS 17, *)
#Preview {
    Group {
        let shouldShowAllCategories = Binding<Bool>(
            get: { false },
            set: { _ in }
        )
        
        CustomPreview { AllCategories(screenSize: CGSize(),
                                      isPresentedAllCategories: shouldShowAllCategories,
                                      completion: { _,_  in }) }
    }
}
