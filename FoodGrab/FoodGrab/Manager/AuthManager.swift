//
//  AuthManager.swift
//  FoodGrab
//
//  Created by j8bok on 9/13/23.
//

import Foundation
import SwiftUI

struct AuthManager {
    static func processLogin(with loginViewModel: LoginViewModel) {
        loginViewModel.isProccessingLogin = true
        loginViewModel.shouldDisableButton = true
        
        AuthService.login(with: loginViewModel) { error in
            if error != nil {
                loginViewModel.isProccessingLogin = false
                loginViewModel.isPresentedMainScreen = false
            } else {
                 loginViewModel.isProccessingLogin = false
                 loginViewModel.isPresentedMainScreen = true
            }
        }
    }
    
    static func processRegistration(with registrationViewModel: RegistrationViewModel, andWith alertViewModel: AlertViewModel) {
        alertViewModel.setIsPresented(with: false)
        registrationViewModel.isProccessingRegistration = true
        registrationViewModel.shouldDisableButton = true
        
        AuthService.register(with: registrationViewModel) { error in
            alertViewModel.setIsPresented(with: true)
            registrationViewModel.isProccessingRegistration = false
            
            if error != nil {
                alertViewModel.setTitle(with: AppConstants.information)
                alertViewModel.setMessage(with: error!.localizedDescription)
            } else {
                alertViewModel.setTitle(with: AppConstants.emptyString)
                alertViewModel.setMessage(with: AppConstants.successfullyRegistered)
            }
        }
    }
}
