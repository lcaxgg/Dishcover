//
//  RegisterLowerPart.swift
//  Dishcover
//
//  Created by j8bok on 9/7/23.
//

import SwiftUI

struct RegisterLowerPart: View {
    
    // MARK: - PROPERTIES
    
    @ObservedObject var registrationViewModel: RegistrationViewModel
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible: Bool = false
    
    private let textModifier = [TextModifier(font: .system(size: 15.0, weight: .semibold, design: .rounded), color: AppConstants.black)]
    
    var body: some View {
        VStack(spacing: 7.0) {
            HStack {
                Text(AppConstants.password)
                    .configure(withModifier: textModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.19, alignment: .leading)
                
                if isPasswordVisible {
                    TextField(AppConstants.passwordPlaceHolder, text: $registrationViewModel.registrationModel.password)
                        .onChange(of: registrationViewModel.getPassword()) { newValue in
                            let password = newValue.filter { !$0.isWhitespace }
                            
                            registrationViewModel.setPassword(with: password)
                            registrationViewModel.validateRegistrationData(with: AppConstants.passwordKey)
                        }
                    
                } else {
                    SecureField(AppConstants.passwordPlaceHolder, text: $registrationViewModel.registrationModel.password)
                        .onChange(of: registrationViewModel.getPassword()) { newValue in
                            let password = newValue.filter { !$0.isWhitespace }
                            
                            registrationViewModel.setPassword(with: password)
                            registrationViewModel.validateRegistrationData(with: AppConstants.passwordKey)
                        }
                }
                
                if registrationViewModel.getPassword().count > 0 {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? AppConstants.eyeSlash : AppConstants.eye)
                            .foregroundColor(.gray)
                            .padding(.trailing, UIScreen.main.bounds.width * 0.025)
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.06)
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            
            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                .padding(.leading, UIScreen.main.bounds.width * 0.06)
            
            if registrationViewModel.isPasswordValid {
                HStack {
                    Text(AppConstants.confirmPassword)
                        .configure(withModifier: textModifier)
                        .frame(width: UIScreen.main.bounds.width * 0.19, alignment: .leading)
                    
                    if isConfirmPasswordVisible {
                        TextField(AppConstants.confrimPasswordPlaceHolder, text: $registrationViewModel.registrationModel.confirmPassword)
                            .onChange(of: registrationViewModel.getConfirmPassword()) { newValue in
                                let confirmPassword = newValue.filter { !$0.isWhitespace }
                                
                                registrationViewModel.setConfirmPaswword(with: confirmPassword)
                                registrationViewModel.validateRegistrationData(with: AppConstants.confirmPasswordKey)
                            }
                        
                    } else {
                        SecureField(AppConstants.confrimPasswordPlaceHolder, text: $registrationViewModel.registrationModel.confirmPassword)
                            .onChange(of: registrationViewModel.getConfirmPassword()) { newValue in
                                let confirmPassword = newValue.filter { !$0.isWhitespace }
                                
                                registrationViewModel.setConfirmPaswword(with: confirmPassword)
                                registrationViewModel.validateRegistrationData(with: AppConstants.confirmPasswordKey)
                            }
                    }
                    
                    if registrationViewModel.getConfirmPassword().count > 0 {
                        Button(action: {
                            isConfirmPasswordVisible.toggle()
                        }) {
                            Image(systemName: isConfirmPasswordVisible ? AppConstants.eyeSlash : AppConstants.eye)
                                .foregroundColor(.gray)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.025)
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.06)
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
                
                HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
            }
        }
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview(traits: .fixedLayout(width: UIScreen.main.bounds.width, height: 150.0)) {
//    RegisterLowerPart(registrationViewModel: RegistrationViewModel(), registrationValidationService: RegistrationValidationService())
//}
