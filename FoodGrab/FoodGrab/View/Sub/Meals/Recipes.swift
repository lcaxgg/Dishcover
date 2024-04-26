//
//  Recipes.swift
//  FoodGrab
//
//  Created by j8bok on 3/7/24.
//

import SwiftUI

struct Recipes: View {
    
    // MARK: - PROPERTIES
    
    @Binding var isPresentedRecipe: Bool
    var screenSize: CGSize
    
    @State private var isTappedShowDetailsForIngredients: Bool = false
    @State private var isTappedShowDetailsForInstructions: Bool = false
    @State private var isShowDetailsForIngredients: Bool = false
    @State private var isShowDetailsForInstructions: Bool = false
    
    var body: some View {
        VStack {
            // MARK: - HEADER
            
            HStack {
                HStack() {
                    let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.022, weight: .regular, design: .rounded), color: AppConstants.green)]
                    
                    Text(AppConstants.close)
                        .configure(withModifier: textModifier)
                }
                .onTapGesture {
                    isPresentedRecipe = false
                }
                
                Spacer()
                
                Color(AppConstants.green)
                    .frame(width: screenSize.width * 0.23)
                    .cornerRadius(11.0)
                    .overlay(
                        HStack(spacing: 6.0) {
                            let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.018, weight: .semibold, design: .rounded), color: AppConstants.white)]
                            
                            Text(AppConstants.share)
                                .configure(withModifier: textModifier)
                            
                            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.white)
                            
                            Image(systemName: AppConstants.arrowUpForwardSquare)
                                .configure(withModifier: imageModifier)
                                .frame(width: screenSize.width * 0.015, height: screenSize.height * 0.015)
                        }
                    )
            }
            .frame(height: screenSize.height * 0.04)
            .padding(.horizontal, 15.0)
            .padding(.bottom, 5.0)
            
            // MARK: - BODY
            
            let recipesData = RecipesViewModel.getRecipesDataById()
            let detail = recipesData?.first
            
            if let image = ImageService.getImageFromLocal(urlString: detail?.strMealThumb ?? AppConstants.emptyString) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1.5, contentMode: .fill)
                    .frame(width: screenSize.width, height: screenSize.height * 0.4)
                    .padding(.bottom, 15.0)
                    .animation(nil, value: UUID())
            }
            
            VStack {
                let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.030, weight: .semibold, design: .rounded), color: AppConstants.black)]
                
                Text(detail?.strMeal ?? AppConstants.emptyString)
                    .configure(withModifier: firstTextModifier)
                
                let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.023, weight: .regular, design: .rounded), color: AppConstants.darkGrayOne)]
                
                Text(AppConstants.mealName)
                    .configure(withModifier: secondTextModifier)
            }
            .padding(.bottom, 20.0)
            
            ScrollView(.vertical, showsIndicators: false) {
                // MARK: - INGREDIENTS SECTION
                
                HStack {
                    let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.025, weight: .semibold, design: .rounded), color: AppConstants.black)]
                    
                    Text(AppConstants.ingredients)
                        .configure(withModifier: firstTextModifier)
                    
                    Spacer()
                    
                    let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .regular, design: .rounded), color: AppConstants.green)]
                    
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
                .padding(.horizontal, 15.0)
                .padding(.bottom, isShowDetailsForIngredients ? 25.0 : 10.0)
                
                Group {
                    if isShowDetailsForIngredients {
                        if let ingredientsWithMeasures = detail?.strIngredientsWithMeasures {
                            ForEach(Array(ingredientsWithMeasures.enumerated()), id: \.1.key) { index, keyValue in
                                
                                let isLastIndex = index == ingredientsWithMeasures.count - 1
                                let (key, value) = keyValue
                                
                                HStack {
                                    let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .light, design: .rounded), color: AppConstants.black)]
                                    
                                    Text(key)
                                        .configure(withModifier: firstTextModifier)
                                    
                                    Spacer ()
                                    
                                    let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .regular, design: .rounded), color: AppConstants.black)]
                                    
                                    Text(value == AppConstants.whiteSpaceString ? AppConstants.dashString : value)
                                        .configure(withModifier: secondTextModifier)
                                }
                                .padding(.horizontal, 15.0)
                                .padding(.bottom, isLastIndex ? 15.0 : 0)
                                
                                if !isLastIndex {
                                    HorizontalSeparator()
                                        .padding(.vertical, 10.0)
                                        .padding(.leading, 15.0)
                                }
                            }
                        }
                        
                    } else {
                        HorizontalSeparator()
                    }
                }
                
                // MARK: - INSTRUCTIONS SECTION
                
                HStack {
                    let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.025, weight: .semibold, design: .rounded), color: AppConstants.black)]
                    
                    Text(AppConstants.instructions)
                        .configure(withModifier: firstTextModifier)
                    
                    Spacer()
                    
                    let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .regular, design: .rounded), color: AppConstants.green)]
                    
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
                .padding(.horizontal, 15.0)
                .padding(.top, 10.0)
                .padding(.bottom, 35.0)
                
                if isShowDetailsForInstructions {
                    VStack(spacing: 40.0) {
                        Button(action: {
                            
                        }) {
                            HStack {
                                let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.green)
                                
                                Image(systemName: AppConstants.playFill)
                                    .configure(withModifier: imageModifier)
                                    .frame(width: screenSize.width * 0.03, height: screenSize.height * 0.03)
                                
                                let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .semibold, design: .rounded), color: AppConstants.green)]
                                
                                Text(AppConstants.playVideo)
                                    .configure(withModifier: textModifier)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color(AppConstants.green), lineWidth: 1)
                                    .frame(width: screenSize.width - 30.0, height: screenSize.height * 0.065)
                            }
                        }
                        
                        if let instructions = detail?.strInstructions {
                            let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.020, weight: .light, design: .rounded), color: AppConstants.black)]
                            
                            Text(instructions)
                                .configure(withModifier: firstTextModifier)
                                .padding(.horizontal, 15.0)
                        }
                    }
                }
                
                // MARK: - FOOTER
            }
        }//: VStack
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    Group {
//        CustomPreview {
//            let isPresented = Binding<Bool>(
//                get: { false },
//                set: { _ in }
//            )
//            
//            Recipes(isPresentedRecipe: isPresented, screenSize: CGSize())
//        }
//    }
//}
