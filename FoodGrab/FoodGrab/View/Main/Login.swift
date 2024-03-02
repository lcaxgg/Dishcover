//
//  Login.swift
//  FoodGrab
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI
import SwiftfulLoadingIndicators
import Firebase

struct Login: View {
    
    // MARK: - PROPERTIES
    
    @State private var text: String = AppConstants.emptyString
    @State private var isPasswordVisible = false
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    private let textModifier = [TextModifier(font: .system(size: 15.0, weight: .semibold, design: .rounded), color: AppConstants.black)]
    private let loginValidationService = LoginValidationService()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: 0) {
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    HStack {
                        Text(AppConstants.email)
                            .configure(withModifier: textModifier)
                            .frame(width: geometry.size.width * 0.23, alignment: .leading)
                        
                        TextField(AppConstants.emailPlaceHolder, text: loginViewModel.emailBinding)
                            .keyboardType(.emailAddress)
                            .padding()
                            .onChange(of: loginViewModel.getEmail()) { newValue in
                                let email = loginValidationService.validateEmailInput(newValue)
                                
                                loginViewModel.setEmail(with: email)
                                loginValidationService.validateLoginInputs(with: AppConstants.emailKey, andWith: loginViewModel)
                            }
                    }
                    .frame(height: geometry.size.height * 0.06)
                    .padding(.leading, geometry.size.width * 0.05)
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                        .padding(.leading, geometry.size.width * 0.06)
                    
                    HStack {
                        Text(AppConstants.password)
                            .configure(withModifier: textModifier)
                            .frame(width: geometry.size.width * 0.23, alignment: .leading)
                        
                        if isPasswordVisible {
                            TextField(AppConstants.passwordPlaceHolder, text: loginViewModel.passwordBinding)
                                .onChange(of: loginViewModel.getPassword()) { newValue in
                                    let password = newValue.filter { !$0.isWhitespace }
                                    
                                    loginViewModel.setPassword(with: password)
                                    loginValidationService.validateLoginInputs(with: AppConstants.passwordKey, andWith: loginViewModel)
                                }
                                .padding()
                            
                        } else {
                            SecureField(AppConstants.passwordPlaceHolder, text: loginViewModel.passwordBinding)
                                .onChange(of: loginViewModel.getPassword()) { newValue in
                                    let password = newValue.filter { !$0.isWhitespace }
                                    
                                    loginViewModel.setPassword(with: password)
                                    loginValidationService.validateLoginInputs(with: AppConstants.passwordKey, andWith: loginViewModel)
                                }
                                .padding()
                        }
                        
                        if loginViewModel.getPassword().count > 0 {
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? AppConstants.eyeSlash : AppConstants.eye)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, UIScreen.main.bounds.width * 0.025)
                            }
                        }
                    }
                    .frame(height: geometry.size.height * 0.06)
                    .padding(.leading, geometry.size.width * 0.05)
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    Spacer()
                    
                    let attribute = ButtonOneAttributes(text: AppConstants.login,
                                                        bgColor: loginViewModel.shouldDisableButton ? AppConstants.lightGrayTwo : loginViewModel.invalidFields.count > 0 ? AppConstants.lightGrayTwo : AppConstants.green,
                                                        fontWeight: .semibold,
                                                        fontSize: geometry.size.height * 0.02,
                                                        cornerRadius: 10.0, isEnabled: false)
                    
                    ButtonOne(attribute: attribute)
                        .frame(height: geometry.size.height * 0.055)
                        .padding(.horizontal, geometry.size.width * 0.04)
                        .onTapGesture {
                            if loginViewModel.isValidCredentials {
                                AuthManager.processLogin(with: loginViewModel)
                            }
                        }
                }//: VStack
                .opacity(loginViewModel.isProccessingLogin ? 0.4 : 1)
                
                if loginViewModel.isProccessingLogin {
                    LoadingIndicator(animation: .circleBars, color: Color(AppConstants.green), size: .medium, speed: .normal)
                }
            }//: ZStack
            .edgesIgnoringSafeArea(.bottom)
            .padding(.bottom, geometry.size.height * 0.02)
            .navigationBarTitle(AppConstants.login, displayMode: .inline)
            .onAppear {
                loginViewModel.initDictionary()
            }
            .navigationBarBackButtonHidden(loginViewModel.isProccessingLogin)
            .disabled(loginViewModel.isProccessingLogin)
            .background(
                NavigationLink(AppConstants.emptyString, destination: Meals(), isActive: $loginViewModel.isPresentedMainScreen)
            )
        }//: GeometryReader
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - PREVIEW

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        CustomPreview { Login() }
            .previewInterfaceOrientation(.portrait)
    }
}
