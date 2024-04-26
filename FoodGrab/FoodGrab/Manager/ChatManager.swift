//
//  ChatManager.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ChatManager {
    static func fetchMessages() {
        fetchMessagesFromServer { documents in
            guard documents?.count != 0 else {
                return
            }
            
            guard let documents = documents else {
                return
            }
            
            var outerArr = [[String: Array<Any>]]()
            var innerArr = [[String: ChatDetailsModel]]()
            
            for document in documents {
                do {
                    guard let data = document.data() else {
                        return
                    }
                    
                    for (key, value) in data {
                        
                        let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                        let details = try JSONDecoder().decode(ChatDetailsModel.self, from: jsonData)
                        
                        innerArr.append([key: details])
                    }
                    
                    outerArr.append([document.documentID: innerArr])
                } catch let error {
                    print("Couldn't decode document. \(error.localizedDescription) ⛔")
                }
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

extension ChatManager {
    private static func fetchMessagesFromServer(completion: @escaping ([DocumentSnapshot]?) -> Void) {
        guard let uEmail = Auth.auth().currentUser?.email else {
            completion(nil)
            return
        }
        
        let collection = Firestore.firestore().collection("Conversations")
        
        collection.document(uEmail).getDocument { document, error in
            guard error == nil else {
                print("Couldn't fetch Document. \(String(describing: error?.localizedDescription)) ⛔")
                
                completion(nil)
                return
            }
            
            guard let document = document else {
                print(uEmail + "Document is empty.")
                
                completion(nil)
                return
            }
            
            let collection = document.reference.collection("received_messages")
            
            collection.getDocuments { (querySnapshot, error) in
                guard querySnapshot?.documents.count != 0 else {
                    print("Received Messages Collection is empty.")
                    
                    completion(nil)
                    return
                }
                
                let documents = querySnapshot?.documents
                completion(documents)
            }
        }
    }
}
