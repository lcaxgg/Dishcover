//
//  BaseService.swift
//  Dishcover
//
//  Created by j8bok on 12/28/23.
//

import Foundation

struct EmailValidationService {
    static func isEmailValid(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailRegex = AppConstants.emailRegexTwo
        let emailValue = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailValue.evaluate(with: trimmedEmail)
    }
    
    /* This will ignore special characters that are not included in the accepted values  */
    
    static func validateEmailInput(_ email: String) -> String {
        var newEmail = email.lowercased()
        let validCharactersRegex = AppConstants.emailRegexOne
        
        newEmail = newEmail.filter { String($0).range(of: validCharactersRegex, options: .regularExpression) != nil }
        
        return newEmail
    }
}
