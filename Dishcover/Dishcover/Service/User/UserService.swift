//
//  UserService.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserService {
    static func fetchUserDetails() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let collection = Firestore.firestore().collection(AppConstants.users)
        collection.document(uid).getDocument { document, error in
            guard error == nil else {
                print("Couldn't fetch Document. \(String(describing: error?.localizedDescription)) ⛔")
                return
            }
            
            guard let document = document else {
                print(uid + "Document is empty.")
                return
            }
            
            do {
                let details = try document.data(as: UserDetailsModel.self)
                UserViewModel.setUserDetails(with: details)
            } catch let error {
                print("Couldn't decode document. \(error.localizedDescription) ⛔")
            }
        }
    }
}
