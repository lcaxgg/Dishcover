//
//  Welcome.swift
//  Dishcover
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI

struct Welcome: View {
    
    // MARK: - PROPERTIES
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(named: AppConstants.customBlack)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    
                    // MARK: - BACKGROUND
                    
                    let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.emptyString)
                    
                    Image(AppConstants.welcomeBackGround)
                        .configure(withModifier: imageModifier)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    // MARK: - HEADER
                    
                    VStack(spacing: 30.0) {
                        Logo(color: AppConstants.customGreen)
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.08)
                        
                        let textModifier = [TextModifier(font: .system(size: geometry.size.height * 0.02, weight: .light, design: .rounded), color: AppConstants.customWhite)]
                        
                        Text(AppConstants.welcomeTitle)
                            .configure(withModifier: textModifier)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, geometry.size.height * 0.08)
                    
                    // MARK: - FOOTER
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink(destination: Register()) {
                            let attribute = ButtonOneAttributes(text: AppConstants.register, bgColor: AppConstants.customGreen, fontWeight: .semibold, fontSize: geometry.size.height * 0.018, cornerRadius: 10.0, isEnabled: true)
                            
                            ButtonOne(attribute: attribute)
                                .frame(height: geometry.size.height * 0.045)
                        }
                        
                        NavigationLink(destination: Login()) {
                            let attribute =  ButtonOneAttributes(text: AppConstants.login, bgColor: AppConstants.darkGrayTwo, fontWeight: .semibold, fontSize: geometry.size.height * 0.018, cornerRadius: 10.0, isEnabled: false)
                            
                            ButtonOne(attribute: attribute)
                                .frame(height: geometry.size.height * 0.045)
                        }
                    }
                    .padding(.horizontal, geometry.size.width * 0.04)
                    .padding(.bottom, geometry.size.height * 0.09)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color(AppConstants.customGreen))
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Welcome() }
//}