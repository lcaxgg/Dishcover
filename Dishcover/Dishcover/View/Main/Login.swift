//
//  Login.swift
//  Dishcover
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI
import SwiftfulLoadingIndicators
import Firebase

struct Login: View {
    
    // MARK: - PROPERTIES
    
    @State private var text: String = AppConstants.emptyString
    @State private var isPasswordVisible: Bool = false
    @State private var isKeyboardShowing: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
    @StateObject private var loginViewModel: LoginViewModel = LoginViewModel()
    @StateObject private var alertViewModel: AlertViewModel = AlertViewModel()
    
    @Binding var navigationPath: NavigationPath
    
    private let textModifier = [TextModifier(font: .system(size: 15.0, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
    
    var body: some View {
        ScreenSizeReader { screenSize in
            ZStack{
                VStack(spacing: 0) {
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    HStack {
                        Text(AppConstants.email)
                            .configure(withModifier: textModifier)
                            .frame(width: screenSize.width * 0.23, alignment: .leading)
                        
                        TextField(AppConstants.emailPlaceHolder, text: $loginViewModel.loginModel.email)
                            .keyboardType(.emailAddress)
                            .padding()
                            .onChange(of: loginViewModel.getEmail()) { newValue in
                                let email = EmailValidationService.validateEmailInput(newValue)
                                
                                loginViewModel.setEmail(with: email)
                                loginViewModel.validateLoginInputs(with: AppConstants.emailKey)
                            }
                    }
                    .frame(height: screenSize.height * 0.06)
                    .padding(.leading, screenSize.width * 0.05)
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                        .padding(.leading, screenSize.width * 0.06)
                    
                    HStack {
                        Text(AppConstants.password)
                            .configure(withModifier: textModifier)
                            .frame(width: screenSize.width * 0.23, alignment: .leading)
                        
                        if isPasswordVisible {
                            TextField(AppConstants.passwordPlaceHolder, text: $loginViewModel.loginModel.password)
                                .onChange(of: loginViewModel.getPassword()) { newValue in
                                    let password = newValue.filter { !$0.isWhitespace }
                                    
                                    loginViewModel.setPassword(with: password)
                                    loginViewModel.validateLoginInputs(with: AppConstants.passwordKey)
                                }
                                .padding()
                            
                        } else {
                            SecureField(AppConstants.passwordPlaceHolder, text: $loginViewModel.loginModel.password)
                                .onChange(of: loginViewModel.getPassword()) { newValue in
                                    let password = newValue.filter { !$0.isWhitespace }
                                    
                                    loginViewModel.setPassword(with: password)
                                    loginViewModel.validateLoginInputs(with: AppConstants.passwordKey)
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
                    .frame(height: screenSize.height * 0.06)
                    .padding(.leading, screenSize.width * 0.05)
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    Spacer()
                    
                    let attribute = ButtonOneAttributes(text: AppConstants.login,
                                                        bgColor: loginViewModel.shouldDisableButton ? AppConstants.lightGrayTwo : loginViewModel.invalidFields.count > 0 ? AppConstants.lightGrayTwo : AppConstants.customGreen,
                                                        fontSize: screenSize.height * 0.02,
                                                        cornerRadius: 10.0, isEnabled: false)
                    
                    ButtonOne(attribute: attribute, fontWeight: .semibold)
                        .frame(height: screenSize.height * 0.055)
                        .padding(.horizontal, screenSize.width * 0.04)
                        .padding(.bottom, isKeyboardShowing ? keyboardHeight : screenSize.height * 0.06)
                        .animation(.easeInOut, value: isKeyboardShowing)
                        .onTapGesture {
                            if loginViewModel.isValidCredentials {
                                LoginService.performLogin(with: loginViewModel, andWith: alertViewModel)
                            }
                        }
                }//: VStack
                .opacity(loginViewModel.isProccessingLogin ? 0.4 : 1)
                
                if loginViewModel.isProccessingLogin {
                    LoadingIndicator(animation: .circleBars, color: Color(AppConstants.customGreen), size: .medium, speed: .normal)
                        .onDisappear {
                            if loginViewModel.isPresentedBaseView {
                                navigationPath.append(NavigationRoute.base)
                            }
                        }
                }
            }//: ZStack
            .edgesIgnoringSafeArea(.bottom)
            .accentColor(Color(AppConstants.customGreen))
            .navigationBarTitle(AppConstants.login, displayMode: .inline)
            .navigationBarBackButtonHidden(loginViewModel.isProccessingLogin)
            .disabled(loginViewModel.isProccessingLogin)
            .onAppear {
                loginViewModel.initDictionary()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                isKeyboardShowing = true
                
                if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardSize.height + 5.0
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                isKeyboardShowing = false
                keyboardHeight = 0.0
            }
            .alert(isPresented: Binding(get: { alertViewModel.getIsPresented() }, set: { _ in })) {
                Alert(
                    title: Text(alertViewModel.getTitle()),
                    message: Text(alertViewModel.getMessage()),
                    dismissButton: .default(Text(AppConstants.ok), action: {})
                )
            }
        }//: ScreenSizeReader
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Login() }
//        .previewInterfaceOrientation(.portrait)
//}
