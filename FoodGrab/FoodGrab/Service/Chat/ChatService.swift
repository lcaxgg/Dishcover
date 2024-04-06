//
//  ChatService.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ChatService {
    static func sendMessage() {
        guard let uEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        let details = ChatDetailsModel(isRead: false, message: "test message", senderEmail: uEmail)
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(details) else {
            print("Couldn't encode chat details. ⛔")
            return
        }
        
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            print("Couldn't convert jsonData into jsonDictionary. ⛔")
            return
        }
        
        let name = UserViewModel.getName()
        let date = DateTimeService.getFormattedDateTime()
        
        let document = Firestore.firestore().collection(AppConstants.conversations)
            .document("itachi.uchiha@gmail.com")
            .collection("received_messages")
            .document(name)
        
        document.setData([date: jsonDictionary], merge: true) { error in
            guard error == nil else {
                print("Couldn't send message. \(String(describing: error?.localizedDescription)) ⛔")
                return
            }
            
            print("Message Sent 📨")
        }
    }
}
