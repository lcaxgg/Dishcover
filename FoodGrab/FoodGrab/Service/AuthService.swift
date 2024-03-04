//
//  AuthService.swift
//  FoodGrab
//
//  Created by j8bok on 9/7/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

struct AuthService {
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
    
    static func register(with registrationViewModel: RegistrationViewModel, completion: @escaping (Error?) -> Void) {
        let startTime = Date().timeIntervalSince1970
        
        Auth.auth().createUser(withEmail: registrationViewModel.getEmail(), password: registrationViewModel.getPassword()) { authResult, error in
            if let error = error {
                print("Registration error: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            let endTime = Date().timeIntervalSince1970
            var duration = endTime - startTime
            duration = duration + 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                storeInformation(with: registrationViewModel) { error in
                    if let error = error {
                        print(error)
                        completion(error)
                    } else {
                        print("User ID : " + (Auth.auth().currentUser?.uid ?? AppConstants.emptyString))
                        completion(nil)
                    }
                }
            }
        }
    }
    
    private static func storeInformation(with registrationViewModel: RegistrationViewModel, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let userData = [
            AppConstants.userID: uid,
            AppConstants.firstName: registrationViewModel.getFirstName(),
            AppConstants.lastName: registrationViewModel.getLastName()
        ]
        
        Firestore.firestore().collection(AppConstants.users)
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
    }
}
