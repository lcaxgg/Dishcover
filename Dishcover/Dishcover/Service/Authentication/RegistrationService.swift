//
//  RegistrationService.swift
//  Dishcover
//
//  Created by j8bok on 3/13/24.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

struct RegistrationService {
    static func performRegistration(with registrationViewModel: RegistrationViewModel, andWith alertViewModel: AlertViewModel) {
        alertViewModel.setIsPresented(with: false)
        registrationViewModel.isProccessingRegistration = true
        registrationViewModel.shouldDisableButton = true
        
        register(with: registrationViewModel) { error in
            alertViewModel.setIsPresented(with: true)
            registrationViewModel.isProccessingRegistration = false
            
            if error != nil {
                alertViewModel.setTitle(with: AppConstants.information)
                alertViewModel.setMessage(with: error!.localizedDescription)
            } else {
                alertViewModel.setTitle(with: AppConstants.emptyString)
                alertViewModel.setMessage(with: AppConstants.successfullyRegistered)
            }
        }
    }
}

extension RegistrationService {
    private static func register(with registrationViewModel: RegistrationViewModel, completion: @escaping (Error?) -> Void) {
        let startTime = Date().timeIntervalSince1970
        
        Auth.auth().createUser(withEmail: registrationViewModel.getEmail(), password: registrationViewModel.getPassword()) { authResult, error in
            if let error = error {
                print("Couldn't proceed in registration. \(error.localizedDescription) ⛔")
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
        guard let uid = Auth.auth().currentUser?.uid,
              let uEmail = Auth.auth().currentUser?.email else {
           
            completion(nil)
            return
        }
        
        let userData = [
            AppConstants.email: uEmail,
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
