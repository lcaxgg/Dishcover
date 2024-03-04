//
//  LoginViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 12/21/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
 
    // MARK: - PROPERTIES

    @Published var loginModel = LoginModel()
    
    @Published var invalidFields: [String : String] = Dictionary()
    
    @Published var isValidCredentials: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isProccessingLogin: Bool = false
    @Published var isPresentedMainScreen: Bool = false
    @Published var shouldDisableButton: Bool = false
    
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
    
    // MARK: - BINDING
    
    var emailBinding: Binding<String> {
        Binding(
            get: { self.loginModel.email },
            set: { self.loginModel.email = $0 }
        )
    }
    
    var passwordBinding: Binding<String> {
        Binding(
            get: { self.loginModel.password },
            set: { self.loginModel.password = $0 }
        )
    }
}

