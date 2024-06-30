//
//  ChatManager.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class ChatManager {
    
    // MARK: TYPES
    
    typealias DictionaryOfStringAny = Dictionary<String, Any>
    typealias ArrayOfTupleStringAny = [(String, Any)]
    typealias ArrayOfTupleStringModel = [(String, ChatDetailsModel)]
    
    // MARK: - PROPERTIES
    
    // MARK: - METHODS
    
    private init() {}
    
    static func fetchMessages(completion: @escaping (Bool) -> Void) {
        fetchMessagesFromServer { responseObject  in
            do {
                if let conversations = responseObject {
                    for (documentId, chatDetails) in conversations {
                        let tupleMirror = Mirror(reflecting: chatDetails)
                        let tupleElemets = tupleMirror.children.map({ $0.value })
                        
                        var newChatDetails = ArrayOfTupleStringModel()
                        
                        for index in 0..<tupleElemets.count {
                            let tupleData = tupleElemets[index]
                            
                            if let tupleData = tupleData as? (key: String, value: Any) {
                                let sentDate = tupleData.key
                                let chatDetails = tupleData.value
                                
                                let jsonData = try JSONSerialization.data(withJSONObject: chatDetails, options: [])
                                let decodedChatDetails = try JSONDecoder().decode(ChatDetailsModel.self, from: jsonData)
                                
                                newChatDetails.append((sentDate, decodedChatDetails))
                            }
                        }
                        
                        let isForMerging = newChatDetails.count == 1
                        var chatModel = ChatModel(documentId: documentId, chatDetails: newChatDetails)
                        
                        ChatViewModel.setMessages(with: &chatModel, andWith: isForMerging)
                    }
                    
                    completion(true)
                }
            } catch let error {
                print("Couldn't decode document. \(error.localizedDescription) ⛔")
                return
            }
        }
    }
    
    static func sendMessage() {
        guard let uEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        let uName = CurrentUserViewModel.getName()
        let receiverEmail = /*ChatViewModel.getReceiverEmail()*/ ""
        let message = ChatViewModel.getComposedMessage()
        
        let existingDocumentId = ChatViewModel.getDocumentId()
        let newDocumentId = uEmail + AppConstants.underScoreString + receiverEmail
        
        let details = ChatDetailsModel(isRead: false, message: message, senderName: uName)
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(details) else {
            print("Couldn't encode chat details. ⛔")
            return
        }
        
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? DictionaryOfStringAny else {
            print("Couldn't convert jsonData into json  Dictionary. ⛔")
            return
        }
        
        let date = DateTimeService.getCurrentDateTime()
        
        let docRef = Firestore.firestore()
            .collection(AppConstants.conversations)
            .document(existingDocumentId.count > 0 ? existingDocumentId : newDocumentId)
        
        docRef
            .setData([date: jsonDictionary], merge: true) { error in
                guard error == nil else {
                    print("Couldn't send message. \(String(describing: error?.localizedDescription)) ⛔")
                    return
                }
                
                print("Message Sent 📨")
            }
    }
}

extension ChatManager {
    private static func fetchMessagesFromServer(completion: @escaping (ArrayOfTupleStringAny?) -> Void) {
        guard let uEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        let collection = Firestore.firestore().collection(AppConstants.conversations)
        
        collection.addSnapshotListener(includeMetadataChanges: true) { querySnapShot, error in
            guard let querySnapShot = querySnapShot else {
                print("Couldn't fetch snapshot. \(String(describing: error?.localizedDescription)) ⛔")
                return
            }
            
            guard querySnapShot.documents.count != 0 else {
                print(AppConstants.conversations + " collection is empty.")
                return
            }
            
            var messages = ArrayOfTupleStringAny()
            
            querySnapShot.documentChanges.forEach { diff in
                let documentId = diff.document.documentID
                
                if documentId.contains(uEmail) {
                    let data = diff.document.data()
                    let sortedData = data.sorted(by: { $0.key > $1.key })
                    
                    if diff.type == .added {
                        messages.append((documentId, sortedData))
                    }
                    
                    if diff.type == .modified {
                        if let firstTuple = sortedData.first {
                            messages.append((documentId, [firstTuple]))
                        }
                    }
                    
                    print("Completed fetching " + AppConstants.conversations + " ✅")
                    completion(messages)
                } else {
                    print("No new message.")
                }
            }
        }
    }
}
