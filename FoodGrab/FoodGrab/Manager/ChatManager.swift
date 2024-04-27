//
//  ChatManager.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class ChatManager {
    
    // MARK: - PROPERTIES
    
    static var shared = ChatManager()
    
    // MARK: - METHODS
    
    private init() {}
    
    static func getSharedInstance() -> ChatManager {
        ChatManager.shared
    }
    
    static func fetchMessages() {
        fetchMessagesFromServer { document in
            guard let document = document else {
                return
            }
            
            do {
                guard let data = document.data() else {
                    return
                }
                
                if let messages = data["received_messages"] as? Dictionary<String, Any> {
                    for (senderName, value) in messages {
                        let valueDictionary = value as! Dictionary<String, Any>
                        var chatDetails = [String: ChatDetailsModel]()
                        
                        for (date, value) in valueDictionary {
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let details = try JSONDecoder().decode(ChatDetailsModel.self, from: jsonData)
                            
                            chatDetails[date] = details
                        }
                        
                        let chatModel = ChatModel(senderName: senderName, chatDetails: chatDetails)
                        ChatViewModel.setMessages(with: chatModel)
                    }
                }
            } catch let error {
                print("Couldn't decode document. \(error.localizedDescription) ⛔")
            }
        }
    }
    
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
        
        let documentReceiver = Firestore.firestore().collection(AppConstants.conversations)
            .document("kushina.uzumaki@gmail.com")
        
        documentReceiver.setData(["received_messages": [name : [date: jsonDictionary]]], merge: true) { error in
            guard error == nil else {
                print("Couldn't send message. \(String(describing: error?.localizedDescription)) ⛔")
                return
            }
            
            print("Message Sent 📨")
        }
        
        let documentSender = Firestore.firestore().collection(AppConstants.conversations)
            .document(uEmail)
        
        documentSender.setData(["sent_messages": ["Kushina Uzumaki": [date: jsonDictionary]]], merge: true) { error in
            guard error == nil else {
                print("Couldn't save message. \(String(describing: error?.localizedDescription)) ⛔")
                return
            }

            print("Message saved ✅")
        }
    }
}

extension ChatManager {
    private static func fetchMessagesFromServer(completion: @escaping (DocumentSnapshot?) -> Void) {
        guard let uEmail = Auth.auth().currentUser?.email else {
            completion(nil)
            return
        }
        
        Firestore.firestore().collection("Conversations").document(uEmail).addSnapshotListener { document, error in
            guard error == nil else {
                print("Couldn't fetch Document. \(String(describing: error?.localizedDescription)) ⛔")
                
                completion(nil)
                return
            }
            
            guard document?.data()?.count != 0 else {
                print(uEmail + "Document is empty.")
                
                completion(nil)
                return
            }
            
            completion(document)
        }
    }
}
