//
//  ValidationProtocol.swift
//  FoodGrab
//
//  Created by j8bok on 4/21/24.
//

import Foundation

protocol ValidationProtocol {
    func isEmailValid(_ email: String) -> Bool
    func validateEmailInput(_ email: String) -> String
}
