//
//  AuthManager.swift
//  FoodGrab
//
//  Created by j8bok on 9/13/23.
//

import Foundation
import SwiftUI

struct AuthManager {
    static func processLogin(with loginViewModel: LoginViewModel, andWith alertViewModel: AlertViewModel) {
        loginViewModel.isProccessingLogin = true
        loginViewModel.shouldDisableButton = true
        alertViewModel.setIsPresented(with: false)
        
        LoginService.login(with: loginViewModel) { error in
            loginViewModel.isProccessingLogin = false
            loginViewModel.isValidCredentials = false
            
            if error != nil {
                alertViewModel.setIsPresented(with: true)
                alertViewModel.setTitle(with: AppConstants.error)
                alertViewModel.setMessage(with: error!.localizedDescription)
                
                loginViewModel.isPresentedMainScreen = false
            } else {
                loginViewModel.isPresentedMainScreen = true
            }
        }
    }
    
    static func processRegistration(with registrationViewModel: RegistrationViewModel, andWith alertViewModel: AlertViewModel) {
        alertViewModel.setIsPresented(with: false)
        registrationViewModel.isProccessingRegistration = true
        registrationViewModel.shouldDisableButton = true
        
        RegistrationService.register(with: registrationViewModel) { error in
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
