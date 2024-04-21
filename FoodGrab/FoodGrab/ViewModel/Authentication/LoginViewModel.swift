//
//  LoginViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 12/21/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var loginModel: LoginModel = LoginModel()
    
    @Published var invalidFields: [String : String] = Dictionary()
    @Published var isValidCredentials: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isProccessingLogin: Bool = false
    @Published var isPresentedBaseView: Bool = false
    @Published var shouldDisableButton: Bool = false
    
    let emailValidationService: EmailValidationService = EmailValidationService()
    
    // MARK: - METHODS
    
    func initDictionary() {
        invalidFields[AppConstants.emailKey] = AppConstants.fillInEmail
        invalidFields[AppConstants.passwordKey] = AppConstants.fillInPassword
    }
    
    // MARK: - GETTER
    
    func getEmail() -> String {
        loginModel.email
    }
    
    func getPassword() -> String {
        loginModel.password
    }
    
    // MARK: - SETTER
    
    func setEmail(with email: String) {
        loginModel.email = email
    }
    
    func setPassword(with password: String) {
        loginModel.password = password
    }
}

extension LoginViewModel {
    func validateLoginInputs(with key: String) {
        if key == AppConstants.emailKey {
            validateEmail(with: key)
        }
        
        if key == AppConstants.passwordKey {
            validatePassword(with: key)
        }
        
        if invalidFields.count == 0 {
            isValidCredentials = true
        } else {
            isValidCredentials = false
        }
    }
    
    private func validateEmail(with key: String) {
        if getEmail().count > 0 {
            if emailValidationService.isEmailValid(getEmail()) {
                invalidFields.removeValue(forKey: key)
            } else {
                invalidFields[key] = AppConstants.invalidEmail
            }
            
            shouldDisableButton = false
        } else {
            invalidFields[key] = AppConstants.fillInEmail
            shouldDisableButton = true
        }
    }
    
    private func validatePassword(with key: String) {
        if getPassword().count >= 8 {
            invalidFields.removeValue(forKey: key)
            shouldDisableButton = false
        } else {
            invalidFields[key] = AppConstants.invalidLength
            shouldDisableButton = true
        }
    }
}
