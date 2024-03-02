//
//  LoginService.swift
//  FoodGrab
//
//  Created by j8bok on 12/28/23.
//

import Foundation

class LoginValidationService : BaseService {
    func validateLoginInputs(with key: String, andWith viewModel: LoginViewModel) {
        if key == AppConstants.emailKey {
            validateEmail(with: key, andWith: viewModel)
        }
        
        if key == AppConstants.passwordKey {
            validatePassword(with: key, andWith: viewModel)
        }
  
        if viewModel.invalidFields.count == 0 {
            viewModel.isValidCredentials = true
        } else {
            viewModel.isValidCredentials = false
        }
    }
    
    private func validateEmail(with key: String, andWith viewModel: LoginViewModel) {
        if viewModel.getEmail().count > 0 {
            if isEmailValid(viewModel.getEmail()) {
                viewModel.invalidFields.removeValue(forKey: key)
            } else {
                viewModel.invalidFields[key] = AppConstants.invalidEmail
            }
            
            viewModel.shouldDisableButton = false
        } else {
            viewModel.invalidFields[key] = AppConstants.fillInEmail
            viewModel.shouldDisableButton = true
        }
    }
    
    private func validatePassword(with key: String, andWith viewModel: LoginViewModel) {
        if viewModel.getPassword().count >= 8 {
            viewModel.invalidFields.removeValue(forKey: key)
            viewModel.shouldDisableButton = false
        } else {
            viewModel.invalidFields[key] = AppConstants.invalidLength
            viewModel.shouldDisableButton = true
        }
    }
}

