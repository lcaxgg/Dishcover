//
//  Recipes.swift
//  Dishcover
//
//  Created by j8bok on 3/7/24.
//

import SwiftUI

struct Recipes: View {
    
    // MARK: - PROPERTIES
    
    //    @Binding var isPresentedRecipe: Bool
    //    var screenSize: CGSize
    
    @State private var isTappedShowDetailsForIngredients: Bool = false
    @State private var isTappedShowDetailsForInstructions: Bool = false
    @State private var isShowDetailsForIngredients: Bool = false
    @State private var isShowDetailsForInstructions: Bool = false
    
    var body: some View {
        ScreenSizeReader { screenSize in
            ZStack {
                // MARK: - HEADER
                
                // MARK: - BODY
                
                let recipesData = RecipesViewModel.getRecipesDataById()
                let detail = recipesData?.first
                
                if (detail == nil) {
                    VStack {
                        Group {
                            let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.lightGrayThree)
                            
                            Image(systemName: AppConstants.infoCircle)
                                .configure(withModifier: imageModifier)
                                .frame(width: screenSize.height * 0.05, height: screenSize.height * 0.05)
                        }
                        .padding(.bottom, 5.0)
                        
                        Group {
                            let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.025, weight: .light, design: .rounded), color: AppConstants.lightGrayThree)]
                            
                            Text(detail?.strMeal ?? AppConstants.notAvailable)
                                .configure(withModifier: textModifier)
                        }
                    }
                    .frame(width: screenSize.width, height: screenSize.height, alignment: .center)
                } else {
                    VStack {
                        if let image = ImageService.getImageFromLocal(urlString: detail?.strMealThumb ?? AppConstants.emptyString) {
                            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.emptyString)
                            
                            Image(uiImage: image)
                                .configure(withModifier: imageModifier)
                                .frame(height: screenSize.height * 0.3)
                                .cornerRadius(11)
                                .padding(.top, 10.0)
                                .padding(.bottom, 10.0)
                                .animation(nil, value: UUID())
                        }
                        
                        VStack {
                            Group {
                                let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.030, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
                                
                                Text(detail?.strMeal ?? AppConstants.notAvailable)
                                    .configure(withModifier: firstTextModifier)
                            }
                            
                            Group {
                                let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.023, weight: .regular, design: .rounded), color: AppConstants.darkGrayOne)]
                                
                                Text(AppConstants.mealName)
                                    .configure(withModifier: secondTextModifier)
                            }
                        }
                        .padding(.bottom, 20.0)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            // MARK: - INGREDIENTS SECTION
                            
                            HStack {
                                let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.025, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
                                
                                Text(AppConstants.ingredients)
                                    .configure(withModifier: firstTextModifier)
                                
                                Spacer()
                                
                                let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .regular, design: .rounded), color: AppConstants.customGreen)]
                                
                                Text(isShowDetailsForIngredients ? AppConstants.hideDetails : AppConstants.showDetails)
                                    .configure(withModifier: secondTextModifier)
                                    .opacity(isTappedShowDetailsForIngredients ? 0 : 1)
                                    .onTapGesture {
                                        isTappedShowDetailsForIngredients = true
                                        isShowDetailsForIngredients.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                            withAnimation {
                                                isTappedShowDetailsForIngredients = false
                                            }
                                        }
                                    }
                            }
                            //  .padding(.horizontal, 15.0)
                            .padding(.bottom, isShowDetailsForIngredients ? 25.0 : 10.0)
                            
                            Group {
                                if isShowDetailsForIngredients {
                                    if let ingredientsWithMeasures = detail?.strIngredientsWithMeasures {
                                        ForEach(Array(ingredientsWithMeasures.enumerated()), id: \.1.key) { index, keyValue in
                                            
                                            let isLastIndex = index == ingredientsWithMeasures.count - 1
                                            let (key, value) = keyValue
                                            
                                            HStack {
                                                let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .light, design: .rounded), color: AppConstants.customBlack)]
                                                
                                                Text(key)
                                                    .configure(withModifier: firstTextModifier)
                                                
                                                Spacer ()
                                                
                                                let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .regular, design: .rounded), color: AppConstants.customBlack)]
                                                
                                                Text(value == AppConstants.whiteSpaceString ? AppConstants.dashString : value)
                                                    .configure(withModifier: secondTextModifier)
                                            }
                                            // .padding(.horizontal, 15.0)
                                            .padding(.bottom, isLastIndex ? 15.0 : 0)
                                            
                                            if !isLastIndex {
                                                HorizontalSeparator()
                                                    .padding(.vertical, 10.0)
                                                    .padding(.leading, 10.0)
                                            }
                                        }
                                    }
                                } else {
                                    HorizontalSeparator()
                                }
                            }
                            
                            // MARK: - INSTRUCTIONS SECTION
                            
                            HStack {
                                let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.025, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
                                
                                Text(AppConstants.instructions)
                                    .configure(withModifier: firstTextModifier)
                                
                                Spacer()
                                
                                let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .regular, design: .rounded), color: AppConstants.customGreen)]
                                
                                Text(isShowDetailsForInstructions ? AppConstants.hideDetails : AppConstants.showDetails)
                                    .configure(withModifier: secondTextModifier)
                                    .opacity(isTappedShowDetailsForInstructions ? 0 : 1)
                                    .onTapGesture {
                                        isTappedShowDetailsForInstructions = true
                                        isShowDetailsForInstructions.toggle()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                            withAnimation {
                                                isTappedShowDetailsForInstructions = false
                                            }
                                        }
                                    }
                            }
                            .padding(.top, 10.0)
                            .padding(.bottom, 35.0)
                            
                            Group {
                                if isShowDetailsForInstructions {
                                    VStack(spacing: 40.0) {
                                        Button(action: {
                                            
                                        }) {
                                            HStack {
                                                let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.customGreen)
                                                
                                                Image(systemName: AppConstants.playFill)
                                                    .configure(withModifier: imageModifier)
                                                    .frame(width: screenSize.width * 0.03, height: screenSize.height * 0.03)
                                                
                                                let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .semibold, design: .rounded), color: AppConstants.customGreen)]
                                                
                                                Text(AppConstants.playVideo)
                                                    .configure(withModifier: textModifier)
                                            }
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10.0)
                                                    .stroke(Color(AppConstants.customGreen), lineWidth: 1)
                                                    .frame(width: screenSize.width - 30.0, height: screenSize.height * 0.065)
                                            }
                                        }
                                        
                                        if let instructions = detail?.strInstructions {
                                            let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .light, design: .rounded), color: AppConstants.customBlack)]
                                            
                                            Text(instructions)
                                                .configure(withModifier: firstTextModifier)
                                        }
                                    }
                                }
                            }
                            
                            // MARK: - FOOTER
                        }
                    }
                    .padding(.horizontal, 15.0)
                    .padding(.bottom, 10.0)
                }
            }//: ZStack
            .navigationBarTitle(AppConstants.recipe, displayMode: .inline)
        }
    }
}

// MARK: - PREVIEW

@available(iOS 17, *)
#Preview {
    Group {
        CustomPreview {
            Recipes()
        }
    }
}
