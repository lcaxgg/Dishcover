//
//  BaseService.swift
//  FoodGrab
//
//  Created by jayvee on 12/28/23.
//

import Foundation

class BaseService {
    
    // MARK: - AUTHENTICATION
    
    func isEmailValid(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailRegex = AppConstants.emailRegexTwo
        let emailValue = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailValue.evaluate(with: trimmedEmail)
    }
    
    // MARK: - VALIDATION WHEN HANDLING EVENT FOR EMAIL
    
    /** This will ignore special characters that are not included in the accepted values  */
    
    func validateEmailInput(_ email: String) -> String {
        var newEmail = email.lowercased()
        let validCharactersRegex = AppConstants.emailRegexOne
        
        newEmail = newEmail.filter { String($0).range(of: validCharactersRegex, options: .regularExpression) != nil }
        
        return newEmail
    }
}
