//
//  Welcome.swift
//  Dishcover
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI

struct Welcome: View {
    
    // MARK: - PROPERTIES
    
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ScreenSizeReader { screenSize in
            ZStack {
                // MARK: - BACKGROUND
                
                let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.emptyString)
                
                Image(AppConstants.welcomeBackGround)
                    .configure(withModifier: imageModifier)
                    .frame(width: screenSize.width, height: screenSize.height)
                
                // MARK: - HEADER
                
                VStack(spacing: 30.0) {
                    Logo(color: AppConstants.customGreen)
                        .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.08)
                    
                    let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.02, weight: .light, design: .rounded), color: AppConstants.customWhite)]
                    
                    Text(AppConstants.welcomeTitle)
                        .configure(withModifier: textModifier)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, screenSize.height * 0.08)
                
                // MARK: - FOOTER
                
                VStack {
                    Spacer()
                    
                    let registerAttribute = ButtonOneAttributes(text: AppConstants.register, bgColor: AppConstants.customGreen, fontSize: screenSize.height * 0.018, cornerRadius: 10.0, isEnabled: true)
                    
                    ButtonOne(attribute: registerAttribute, fontWeight: .semibold)
                        .frame(height: screenSize.height * 0.045)
                        .onTapGesture {
                            navigationPath.append(NavigationRoute.register)
                            NavigationViewModel.setNavigationViewItemTag(with: NavigationViewItemEnum.register.rawValue)
                        }
                    
                    let loginAttribute =  ButtonOneAttributes(text: AppConstants.login, bgColor: AppConstants.darkGrayTwo, fontSize: screenSize.height * 0.018, cornerRadius: 10.0, isEnabled: false)
                    
                    ButtonOne(attribute: loginAttribute, fontWeight: .semibold)
                        .frame(height: screenSize.height * 0.045)
                        .onTapGesture {
                            navigationPath.append(NavigationRoute.login)
                            NavigationViewModel.setNavigationViewItemTag(with: NavigationViewItemEnum.login.rawValue)
                        }
                    
                }
                .padding(.horizontal, screenSize.width * 0.04)
                .padding(.bottom, screenSize.height * 0.09)
            }//: ZStack
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Welcome() }
//}
