//
//  RegistrationModel.swift
//  FoodGrab
//
//  Created by j8bok on 9/7/23.
//

import Foundation

struct RegistrationModel {
    var firstName: String = AppConstants.emptyString
    var lastName: String = AppConstants.emptyString
    var email: String = AppConstants.emptyString
    
    var streetNumber: String = AppConstants.emptyString
    var streetName: String = AppConstants.emptyString
    var barangay: String = AppConstants.emptyString
    var zipCode: String = AppConstants.emptyString
    var city: String = AppConstants.emptyString
    var country: String = AppConstants.emptyString
    var address: String = AppConstants.emptyString
    
    var password: String = AppConstants.emptyString
    var confirmPassword: String = AppConstants.emptyString
}
