//
//  UserDetailsModel.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation

struct UserDetailsModel: Codable {
    var userId: String = AppConstants.emptyString
    var firstName: String = AppConstants.emptyString
    var lastName: String = AppConstants.emptyString
    
    enum CodingKeys: String, CodingKey {
        case userId = "User ID" // will change to User Id
        case firstName = "First Name"
        case lastName = "Last Name"
    }
}
