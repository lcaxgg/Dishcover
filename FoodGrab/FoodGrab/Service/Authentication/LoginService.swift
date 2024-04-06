//
//  LoginService.swift
//  FoodGrab
//
//  Created by j8bok on 3/13/24.
//

import Foundation

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

struct LoginService {
    static func login(with loginViewModel: LoginViewModel, completion: @escaping (Error?) -> Void) {
        let startTime = Date().timeIntervalSince1970
        
        Auth.auth().signIn(withEmail: loginViewModel.getEmail(), password: loginViewModel.getPassword()) { (user, error) in
            if let error = error {
                print("* Couldn't proceed in login. \(error.localizedDescription) *")
                completion(error)
                return
            }
        
            UserService.fetchUserInfo()
    
            let endTime = Date().timeIntervalSince1970
            var duration = endTime - startTime
            duration = duration + 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                print("User ID : " + (user?.user.uid ?? AppConstants.emptyString))
                completion(nil)
            }
        }
    }
}
