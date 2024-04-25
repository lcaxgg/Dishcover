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
    static func processLogin(with loginViewModel: LoginViewModel, andWith alertViewModel: AlertViewModel) {
        loginViewModel.isProccessingLogin = true
        loginViewModel.shouldDisableButton = true
        alertViewModel.setIsPresented(with: false)
        
        login(with: loginViewModel) { error in
            loginViewModel.isProccessingLogin = false
            loginViewModel.isValidCredentials = false
            
            if error != nil {
                alertViewModel.setIsPresented(with: true)
                alertViewModel.setTitle(with: AppConstants.error)
                alertViewModel.setMessage(with: error!.localizedDescription)
                
                loginViewModel.isPresentedBaseView = false
            } else {
                loginViewModel.isPresentedBaseView  = true
            }
        }
    }
}

extension LoginService {
    private static func login(with loginViewModel: LoginViewModel, completion: @escaping (Error?) -> Void) {
        let startTime = Date().timeIntervalSince1970
        
        Auth.auth().signIn(withEmail: loginViewModel.getEmail(), password: loginViewModel.getPassword()) { (user, error) in
            if let error = error {
                print("Couldn't proceed in login. \(error.localizedDescription) ⛔")
                completion(error)
                return
            }
        
            UserService.fetchUserDetails()
    
            let endTime = Date().timeIntervalSince1970
            var duration = endTime - startTime
            duration = duration + 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                print("Successfully logged in 🚀")
                print("User Id :" + AppConstants.whiteSpaceString + (user?.user.uid ?? AppConstants.emptyString) + AppConstants.whiteSpaceString + "🗝️")
                completion(nil)
            }
        }
    }
}
