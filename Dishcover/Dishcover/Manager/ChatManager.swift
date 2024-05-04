//
//  ChatManager.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class ChatManager {
    
    // MARK: - PROPERTIES
    
    static var shared = ChatManager()
    
    // MARK: TYPES
    
    typealias DictionaryOfStringAny = Dictionary<String, Any>
    typealias ArrayOfTuple = [(String, Any)]
    
    // MARK: - METHODS
    
    private init() {}
    
    static func getSharedInstance() -> ChatManager {
        ChatManager.shared
    }
    
    static func fetchMessages() {
        fetchMessagesFromServer { senderName, messages  in
            do {
                if let messages = messages {
                    var chatDetails = [String: ChatDetailsModel]()
                    
                    for (date, value) in messages {
                        let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                        let details = try JSONDecoder().decode(ChatDetailsModel.self, from: jsonData)
                        
                        chatDetails[date] = details
                    }
                    
                    let isForMerging = chatDetails.count == 1
                    let chatModel = ChatModel(senderName: senderName, chatDetails: chatDetails)
                   
                    ChatViewModel.setMessages(with: chatModel, andWith: isForMerging)
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
        
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? DictionaryOfStringAny else {
            print("Couldn't convert jsonData into jsonDictionary. ⛔")
            return
        }
        
        let date = DateTimeService.getFormattedDateTime()
        
        let documentReceiver = Firestore.firestore()
            .collection(AppConstants.conversations)
            .document("itachi@gmail.com")
        
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
                    .document("itachi@gmail.com")
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
    private static func fetchMessagesFromServer(completion: @escaping (String, ArrayOfTuple?) -> Void) {
        guard let uEmail = Auth.auth().currentUser?.email else {
            return
        }
    
        let outerCollection = Firestore.firestore().collection(AppConstants.conversations)
        
        outerCollection.document(uEmail).getDocument { document, error in
            guard error == nil else {
                print("Couldn't fetch Document. \(String(describing: error?.localizedDescription)) ⛔")
                return
            }
            
            guard let document = document else {
                print(uEmail + "Document is empty.")
                return
            }
            
            let innerCollection = document.reference.collection("received_messages")
        
            innerCollection.addSnapshotListener(includeMetadataChanges: true) { querySnapShot, error in
                guard let querySnapShot = querySnapShot else {
                    print("Couldn't fetch snapshot. \(String(describing: error?.localizedDescription)) ⛔")
                    return
                }
                
                guard querySnapShot.documents.count != 0 else {
                    print("received_messages Collection is empty.")
                    return
                }
                
                querySnapShot.documentChanges.forEach { diff in
                    let senderName = diff.document.documentID
                    let data = diff.document.data()
                    let sortedData = data.sorted(by: { $0.key > $1.key })

                    if diff.type == .added {
                        completion(senderName, sortedData)
                    }
                    
                    if diff.type == .modified {
                        if let firstTuple = sortedData.first {
                            completion(senderName, [firstTuple])
                        }
                    }
                }
            }
        }
    }
}
