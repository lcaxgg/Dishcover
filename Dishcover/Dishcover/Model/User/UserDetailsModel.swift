//
//  UserDetailsModel.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation

struct UserDetailsModel: Codable {
    var email: String = AppConstants.emptyString
    var firstName: String = AppConstants.emptyString
    var lastName: String = AppConstants.emptyString
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case firstName = "First Name"
        case lastName = "Last Name"
    }
}
