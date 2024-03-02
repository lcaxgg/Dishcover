//
//  RegistrationViewModel.swift
//  FoodGrab
//
//  Created by jayvee on 9/27/23.
//

import Foundation
import SwiftUI

class RegistrationViewModel: ObservableObject {
 
    // MARK: - PROPERTIES
    
    @Published var registrationModel = RegistrationModel()
    
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
    
    // MARK: - BINDING
    
    var firstNameBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.firstName },
            set: { self.registrationModel.firstName = $0 }
        )
    }
    
    var lastNameBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.lastName },
            set: { self.registrationModel.lastName = $0 }
        )
    }
    
    var emailBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.email },
            set: { self.registrationModel.email = $0 }
        )
    }
    
    var streetNumberBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.streetNumber },
            set: { self.registrationModel.streetNumber = $0 }
        )
    }
    
    var streetNameBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.streetName },
            set: { self.registrationModel.streetName = $0 }
        )
    }
    
    var barangayBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.barangay },
            set: { self.registrationModel.barangay = $0 }
        )
    }
    
    var zipCodeBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.zipCode },
            set: { self.registrationModel.zipCode = $0 }
        )
    }
    
    var cityBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.city },
            set: { self.registrationModel.city = $0 }
        )
    }
    
    var countryBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.country },
            set: { self.registrationModel.country = $0 }
        )
    }
    
    var passwordBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.password },
            set: { self.registrationModel.password = $0 }
        )
    }
    
    var confirmPasswordBinding: Binding<String> {
        Binding(
            get: { self.registrationModel.confirmPassword },
            set: { self.registrationModel.confirmPassword = $0 }
        )
    }
}
