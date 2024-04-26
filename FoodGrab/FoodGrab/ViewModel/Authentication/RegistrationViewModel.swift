//
//  RegistrationViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 9/27/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var registrationModel: RegistrationModel = RegistrationModel()
    
    @Published var invalidFields: [String : String] = Dictionary()
    @Published var isValidForSaving: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isProccessingRegistration: Bool = false
    @Published var isRegistrationSuccessful: Bool = false
    @Published var shouldDisableButton: Bool = false
    
    // MARK: - METHODS
    
    func initDictionary() {
        invalidFields[AppConstants.firstNameKey] = AppConstants.fillInFirstName
        invalidFields[AppConstants.lastNameKey] = AppConstants.fillInLastName
        invalidFields[AppConstants.emailKey] = AppConstants.fillInEmail
        invalidFields[AppConstants.passwordKey] = AppConstants.fillInPassword
        invalidFields[AppConstants.confirmPasswordKey] = AppConstants.fillInConfirmPassword
    }
    
    // MARK: - GETTER
    
    func getFirstName() -> String {
        registrationModel.firstName
    }
    
    func getLastName() -> String {
        registrationModel.lastName
    }
    
    func getEmail() -> String {
        registrationModel.email
    }
    
    func getStreetNumber() -> String {
        registrationModel.streetNumber
    }
    
    func getStreetName() -> String {
        registrationModel.streetName
    }
    
    func getBarangay() -> String {
        registrationModel.barangay
    }
    
    func getZipCode() -> String {
        registrationModel.zipCode
    }
    
    func getCity() -> String {
        registrationModel.city
    }
    
    func getCountry() -> String {
        registrationModel.country
    }
    
    func getPassword() -> String {
        registrationModel.password
    }
    
    func getConfirmPassword() -> String {
        registrationModel.confirmPassword
    }
    
    // MARK: - SETTER
    
    func setFirstName(with firstName: String) {
        registrationModel.firstName = firstName
    }
    
    func setLastName(with lastName: String) {
        registrationModel.lastName = lastName
    }
    
    func setEmail(with email: String) {
        registrationModel.email = email
    }
    
    func setStreetNumber(with streetNumber: String) {
        registrationModel.streetNumber = streetNumber
    }
    
    func setStreetName(with streetName: String) {
        registrationModel.streetName = streetName
    }
    
    func setBarangay(with barangay: String) {
        registrationModel.barangay = barangay
    }
    
    func setZipCode(with zipCode: String) {
        registrationModel.zipCode = zipCode
    }
    
    func setCity(with city: String) {
        registrationModel.city = city
    }
    
    func setCountry(with country: String) {
        registrationModel.country = country
    }
    
    func setPassword(with password: String) {
        registrationModel.password = password
    }
    
    func setConfirmPaswword(with confirmPassword: String) {
        registrationModel.confirmPassword = confirmPassword
    }
}

extension RegistrationViewModel {
    func validateRegistrationData(with key: String) {
        if key == AppConstants.firstNameKey {
            validateFirstName(with: key)
        }
        
        if key == AppConstants.lastNameKey {
            validateLastName(with: key)
        }
        
        if key == AppConstants.emailKey {
            validateEmail(with: key)
        }
        
        if key == AppConstants.passwordKey || key == AppConstants.confirmPasswordKey {
            validatePassword(with: key)
        }
        
        if invalidFields.count == 0 {
            isValidForSaving = true
        } else {
            isValidForSaving = false
        }
    }
    
    private func validateFirstName(with key: String) {
        if getFirstName().count == 0 {
            invalidFields[key] = AppConstants.fillInFirstName
            
        } else if getFirstName().count < 3 {
            invalidFields[key] = AppConstants.invalidFirstName
            
        } else {
            invalidFields.removeValue(forKey: key)
        }
    }
    
    private func validateLastName(with key: String) {
        if getLastName().count == 0 {
            invalidFields[key] = AppConstants.fillInLastName
            
        } else if getLastName().count < 3 {
            invalidFields[key] = AppConstants.invalidLastName
            
        } else {
            invalidFields.removeValue(forKey: key)
        }
    }
    
    private func validateEmail(with key: String) {
        if getEmail().count > 0 {
            if EmailValidationService.isEmailValid(getEmail()) {
                invalidFields.removeValue(forKey: key)
            } else {
                invalidFields[key] = AppConstants.invalidEmail
            }
        } else {
            invalidFields[key] = AppConstants.fillInEmail
        }
    }
    
    private func validatePassword(with key: String) {
        if key == AppConstants.passwordKey {
            isPasswordValid = false;
            setConfirmPaswword(with: AppConstants.emptyString)
            
            if getPassword().count == 0 {
                invalidFields[key] = AppConstants.fillInPassword
                
            } else {
                if !isPasswordValid(getPassword()) {
                    invalidFields[key] = AppConstants.invalidPassword
                    
                } else {
                    isPasswordValid = true;
                    
                    if getPassword() != getConfirmPassword() {
                        invalidFields[key] = AppConstants.notMatchingPasswords
                        
                    } else {
                        invalidFields.removeValue(forKey: AppConstants.passwordKey)
                        invalidFields.removeValue(forKey: AppConstants.confirmPasswordKey)
                    }
                }
            }
        }
        
        if key == AppConstants.confirmPasswordKey {
            if getConfirmPassword().count == 0 {
                invalidFields[key] = AppConstants.fillInConfirmPassword
                
            } else {
                if getConfirmPassword() != getPassword() {
                    invalidFields[key] = AppConstants.notMatchingPasswords
                    
                } else {
                    invalidFields.removeValue(forKey: AppConstants.confirmPasswordKey)
                    invalidFields.removeValue(forKey: AppConstants.passwordKey)
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
        
        if password.contains(AppConstants.whiteSpaceString) {
            return false
        }
        
        return true
    }
}
