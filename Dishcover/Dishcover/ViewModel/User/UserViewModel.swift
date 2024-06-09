//
//  UserViewModel.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation

class UserViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
   
    static let sharedInstance: UserViewModel = UserViewModel()
    private var userDetailsModel: UserDetailsModel = UserDetailsModel()
    
    // MARK: - METHOD
    
    private init() {}
    
    static func getSharedInstance() -> UserViewModel {
        UserViewModel.sharedInstance
    }
}

extension UserViewModel {
    
    // MARK: - GETTER
    
    static func getName() -> String {
        sharedInstance.userDetailsModel.firstName + AppConstants.whiteSpaceString + sharedInstance.userDetailsModel.lastName
    }
    
    static func getEmail() -> String {
        sharedInstance.userDetailsModel.email
    }
    
    // MARK: - SETTER
    
    static func setUserDetails(with details: UserDetailsModel) {
        sharedInstance.userDetailsModel = details
    }
}
