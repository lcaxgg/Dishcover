//
//  UserViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation

class UserViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
   
    static let shared: UserViewModel = UserViewModel()
    private var userDetailsModel: UserDetailsModel = UserDetailsModel()
    
    // MARK: - METHOD
    
    private init() {}
    
    static func getSharedInstance() -> UserViewModel {
        return UserViewModel.shared
    }
    
    // MARK: - SETTER
    
    func setUserDetails(with details: UserDetailsModel) {
        userDetailsModel = details
    }
    
    // MARK: - GETTER
    
    static func getName() -> String {
        shared.userDetailsModel.firstName + AppConstants.whiteSpaceString + shared.userDetailsModel.lastName
    }
}