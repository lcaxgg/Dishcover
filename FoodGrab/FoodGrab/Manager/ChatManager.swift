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
        
        let details = ChatDetailsModel(isRead: false, message: "This is kakashi", senderEmail: uEmail)
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(details) else {
            print("Couldn't encode chat details. ⛔")
            return
        }
        
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            print("Couldn't convert jsonData into jsonDictionary. ⛔")
            return
        }
        
        let date = DateTimeService.getFormattedDateTime()
        
        let documentReceiver = Firestore.firestore()
            .collection(AppConstants.conversations)
            .document("itachi.uchiha@gmail.com")
        
        createDummyField(for: documentReceiver) { success in
            guard success == true else {
                return
            }
            
            let name = UserViewModel.getName()
            
            documentReceiver
                .collection("received_messages")
                .document(name)
                .setData([date: jsonDictionary], merge: true) { error in
                    guard error == nil else {
                        print("Couldn't send message. \(String(describing: error?.localizedDescription)) ⛔")
                        return
                    }
                    
                    print("Message Sent 📨")
                }
            
            saveSentMessage()
        }
        
        // save data for the sender (current user)
        
        func saveSentMessage() {
            let documentSender = Firestore.firestore()
                .collection(AppConstants.conversations)
                .document(uEmail)
            
            createDummyField(for: documentSender) { success in
                guard success == true else {
                    return
                }
                
                documentSender
                    .collection("sent_messages")
                    .document("itachi.uchiha@gmail.com")
                    .setData([date: jsonDictionary], merge: true) { error in
                    guard error == nil else {
                        print("Couldn't save message. \(String(describing: error?.localizedDescription)) ⛔")
                        return
                    }
                    
                        print("Message saved ✅")
                }
            }
        }
   
        // create a dummy field for document so that it would become existent in firebase
        
        func createDummyField(for docRef: DocumentReference, completion: @escaping (Bool) -> Void) {
            docRef.getDocument { document, error in
                guard error == nil else {
                    print("Couldn't fetch document of \(docRef.documentID). \(String(describing: error?.localizedDescription)) ⛔")
                    completion(false)
                    return
                }
                
                guard document?.data()?["dumm_key"] == nil else {
                    print("Dummy field already exists for \(docRef.documentID) ℹ️")
                    completion(true)
                    return
                }
                
                docRef.setData(["dumm_key": "dummy_value"]) { error in
                    guard error == nil else {
                        print("Couldn't create dummy field for \(docRef.documentID). \(String(describing: error?.localizedDescription)) ⛔")
                        completion(false)
                        return
                    }
                    
                    print("Dummy field created for \(docRef.documentID) ✅")
                    completion(true)
                }
            }
        }
    }
}

extension ChatManager {
    private static func fetchMessagesFromServer(completion: @escaping (DocumentSnapshot?) -> Void) {
        guard let uEmail = Auth.auth().currentUser?.email else {
            completion(nil)
            return
        }
        
        Firestore.firestore().collection(AppConstants.conversations).document(uEmail).addSnapshotListener { querySnapShot, error in
            guard error == nil else {
                print("Couldn't fetch Document. \(String(describing: error?.localizedDescription)) ⛔")
                
                completion(nil)
                return
            }
            
            guard querySnapShot?.data()?.count != 0 else {
                print(uEmail + "Document is empty.")
                
                completion(nil)
                return
            }
            
            completion(querySnapShot)
        }
    }
}
