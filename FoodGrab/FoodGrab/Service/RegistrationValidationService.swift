//
//  RegistrationValidationService.swift
//  FoodGrab
//
//  Created by jayvee on 9/7/23.
//

import Foundation

class RegistrationValidationService : BaseService {
    func validateRegistrationData(with key: String, andWith viewModel: RegistrationViewModel) {
        if key == AppConstants.firstNameKey {
            validateFirstName(with: key, andWith: viewModel)
        }
        
        if key == AppConstants.lastNameKey {
            validateLastName(with: key, andWith: viewModel)
        }
        
        if key == AppConstants.emailKey {
            validateEmail(with: key, andWith: viewModel)
        }
        
        if key == AppConstants.passwordKey || key == AppConstants.confirmPasswordKey {
            validatePassword(with: key, andWith: viewModel)
        }
        
        if viewModel.invalidFields.count == 0 {
            viewModel.isValidForSaving = true
        } else {
            viewModel.isValidForSaving = false
        }
    }
    
    private func validateFirstName(with key: String, andWith viewModel: RegistrationViewModel) {
        if viewModel.getFirstName().count == 0 {
            viewModel.invalidFields[key] = AppConstants.fillInFirstName
            
        } else if viewModel.getFirstName().count < 3 {
            viewModel.invalidFields[key] = AppConstants.invalidFirstName
            
        } else {
            viewModel.invalidFields.removeValue(forKey: key)
        }
    }
    
    private func validateLastName(with key: String, andWith viewModel: RegistrationViewModel) {
        if viewModel.getLastName().count == 0 {
            viewModel.invalidFields[key] = AppConstants.fillInLastName
            
        } else if viewModel.getLastName().count < 3 {
            viewModel.invalidFields[key] = AppConstants.invalidLastName
            
        } else {
            viewModel.invalidFields.removeValue(forKey: key)
        }
    }
    
    private func validateEmail(with key: String, andWith viewModel: RegistrationViewModel) {
        if viewModel.getEmail().count > 0 {
            if isEmailValid(viewModel.getEmail()) {
                viewModel.invalidFields.removeValue(forKey: key)
            } else {
                viewModel.invalidFields[key] = AppConstants.invalidEmail
            }
        } else {
            viewModel.invalidFields[key] = AppConstants.fillInEmail
        }
    }
    
    private func validatePassword(with key: String, andWith viewModel: RegistrationViewModel) {
        if key == AppConstants.passwordKey {
            viewModel.isPasswordValid = false;
            viewModel.setConfirmPaswword(with: AppConstants.emptyString)
            
            if viewModel.getPassword().count == 0 {
                viewModel.invalidFields[key] = AppConstants.fillInPassword
                
            } else {
                if !isPasswordValid(viewModel.getPassword()) {
                    viewModel.invalidFields[key] = AppConstants.invalidPassword
                    
                } else {
                    viewModel.isPasswordValid = true;
                    
                    if viewModel.getPassword() != viewModel.getConfirmPassword() {
                        viewModel.invalidFields[key] = AppConstants.notMatchingPasswords
                        
                    } else {
                        viewModel.invalidFields.removeValue(forKey: AppConstants.passwordKey)
                        viewModel.invalidFields.removeValue(forKey: AppConstants.confirmPasswordKey)
                    }
                }
            }
        }
        
        if key == AppConstants.confirmPasswordKey {
            if viewModel.getConfirmPassword().count == 0 {
                viewModel.invalidFields[key] = AppConstants.fillInConfirmPassword
                
            } else {
                if viewModel.getConfirmPassword() != viewModel.getPassword() {
                    viewModel.invalidFields[key] = AppConstants.notMatchingPasswords
                    
                } else {
                    viewModel.invalidFields.removeValue(forKey: AppConstants.confirmPasswordKey)
                    viewModel.invalidFields.removeValue(forKey: AppConstants.passwordKey)
                }
            }
        }
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        if password.count < 8 {
            return false
        }
        
        if password.rangeOfCharacter(from: .uppercaseLetters) == nil {
            return false
        }
        
        if password.rangeOfCharacter(from: .lowercaseLetters) == nil {
            return false
        }
        
        if password.rangeOfCharacter(from: .decimalDigits) == nil {
            return false
        }
        
        let specialCharacterSet = CharacterSet(charactersIn: AppConstants.passwordCharacterSet)
        if password.rangeOfCharacter(from: specialCharacterSet) == nil {
            return false
        }
        
        if password.contains(AppConstants.whiteSpace) {
            return false
        }
        
        return true
    }
}
