//
//  ChatDownloadManager.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ChatDownloadManager {
    
    // MARK: - PROPERTIES
    
    static var shared = ChatDownloadManager()
    
    // MARK: - METHODS
    
    private init() {}
    
    func getFirstInstance() -> ChatDownloadManager {
        return ChatDownloadManager.shared
    }
    
    // MARK: - FETCH
    
    func fetchMessagesFromServer() {
        guard let uEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        let collection = Firestore.firestore().collection("Conversation")
        collection.document(uEmail).getDocument { document, error in
            guard error == nil else {
                print("* Couldn't fetch Document. \(String(describing: error?.localizedDescription)) *")
                return
            }
            
            guard let document = document else {
                print(uEmail + "Document is empty.")
                return
            }
            
            let collection = document.reference.collection("received_messages")
            collection.getDocuments { (querySnapshot, error) in
                guard querySnapshot?.documents.count != 0 else {
                    print("Received Messages Collection is empty.")
                    return
                }
                
                var outerArr = [[String: Array<Any>]]()
                
                if let documents = querySnapshot?.documents {
                    
                    var someArr = [[String: ChatDetailsModel]]()
                    
                    for document in documents {
                        do {
                            let data = document.data()
                            
                            for (key, value) in data {
                              
                                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                                let details = try JSONDecoder().decode(ChatDetailsModel.self, from: jsonData)
                                
                                someArr.append([key: details])
                            
                            }
                        } catch let error {
                            print("* Couldn't decode Document. \(error.localizedDescription) *")
                        }
                        
                        outerArr.append([document.documentID: someArr])
                    }
                    
                    print("test")
                }
            }
        }
    }
}

struct ChatModel {
    let timeStamp: [ChatDetailsModel]
}

struct ChatDetailsModel: Codable {
    let isRead: Bool
    let message: String
    let senderEmail: String
    let senderName: String
    
    enum CodingKeys: String, CodingKey {
        case isRead = "is_read"
        case message
        case senderEmail = "sender_email"
        case senderName = "sender_name"
    }
}
