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
                print("Login error: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            let endTime = Date().timeIntervalSince1970
            var duration = endTime - startTime
            duration = duration + 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                print("User ID : " + (Auth.auth().currentUser?.uid ?? AppConstants.emptyString))
                completion(nil)
            }
        }
    }
}
