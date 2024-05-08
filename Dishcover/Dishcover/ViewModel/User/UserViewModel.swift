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
    
    // MARK: - SETTER
    
    func setUserDetails(with details: UserDetailsModel) {
        userDetailsModel = details
    }
}
