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
    var geometry: GeometryProxy
    
    @State private var isTappedShowDetailsForIngredients: Bool = false
    @State private var isTappedShowDetailsForInstructions: Bool = false
    @State private var isShowDetailsForIngredients: Bool = false
    @State private var isShowDetailsForInstructions: Bool = false
    
    var body: some View {
        
        VStack {
            // MARK: - HEADER
            
            HStack {
                HStack() {
                    let textModifier = [TextModifier(font: .system(size: geometry.size.height * 0.022, weight: .regular, design: .rounded), color: AppConstants.green)]
                    
                    Text(AppConstants.close)
                        .configure(withModifier: textModifier)
                }
                .onTapGesture {
                    isPresentedRecipe = false
                }
                
                Spacer()
                
                Color(AppConstants.green)
                    .frame(width: geometry.size.width * 0.23)
                    .cornerRadius(11.0)
                    .overlay(
                        HStack(spacing: 6.0) {
                            let textModifier = [TextModifier(font: .system(size: geometry.size.height * 0.018, weight: .semibold, design: .rounded), color: AppConstants.white)]
                            
                            Text(AppConstants.share)
                                .configure(withModifier: textModifier)
                            
                            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.white)
                            
                            Image(systemName: AppConstants.arrowUpForwardSquare)
                                .configure(withModifier: imageModifier)
                                .frame(width: geometry.size.width * 0.015, height: geometry.size.height * 0.015)
                        }
                    )
            }
            .frame(height: geometry.size.height * 0.04)
            .padding(.horizontal, 15.0)
            .padding(.bottom, 5.0)
            
            // MARK: - BODY
            
            Image("breakfast")
                .resizable()
                .aspectRatio(1.5, contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                .padding(.bottom, 15.0)
            
            VStack {
                let firstTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.033, weight: .semibold, design: .rounded), color: AppConstants.black)]
                
                Text("Some Meal Name")
                    .configure(withModifier: firstTextModifier)
                
                let secondTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.025, weight: .regular, design: .rounded), color: AppConstants.darkGrayOne)]
                
                Text(AppConstants.mealName)
                    .configure(withModifier: secondTextModifier)
            }
            .padding(.bottom, 20.0)
            
            HStack {
                let firstTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.027, weight: .semibold, design: .rounded), color: AppConstants.black)]
                
                Text(AppConstants.ingredients)
                    .configure(withModifier: firstTextModifier)
                
                Spacer()
                
                let secondTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.022, weight: .regular, design: .rounded), color: AppConstants.green)]
                
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
            .padding(.bottom, 10.0)
            
            HorizontalSeparator()
            
            HStack {
                let firstTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.027, weight: .semibold, design: .rounded), color: AppConstants.black)]
                
                Text(AppConstants.instructions)
                    .configure(withModifier: firstTextModifier)
                
                Spacer()
                
                let secondTextModifier = [TextModifier(font: .system(size: geometry.size.height * 0.022, weight: .regular, design: .rounded), color: AppConstants.green)]
                
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
            
            Spacer()
        }//: VStack
        
        // MARK: - FOOTER
    }
}

#Preview {
    GeometryReader { geometry in
        CustomPreview {
            let isPresented = Binding<Bool>(
                get: { false },
                set: { _ in }
            )
            
            Recipes(isPresentedRecipe: isPresented, geometry: geometry)
        }
    }
}
