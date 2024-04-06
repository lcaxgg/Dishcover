//
//  ChatWindow.swift
//  FoodGrab
//
//  Created by j8bok on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatWindow: View {
    
    // MARK: - PROPERTIES
    
    @State private var nestedData: [String: Any] = [:] // Assuming your nested data structure
    
    let db = Firestore.firestore()
    let topLevelCollectionReference = Firestore.firestore().collection("Conversation")
    @State var listener: ListenerRegistration?
    
    var body: some View {
        
        // MARK: - HEADER
        
        // MARK: - BODY
        
        // MARK: - FOOTER
        
        Button(action: {
            send()
        }, label: {
            Text("Send")
        })
        .onAppear {
//            DispatchQueue.global(qos: .background).async {
//                listener = topLevelCollectionReference.document("itachi@gmail.com").addSnapshotListener { (documentSnapshot, error) in
//                    
//                    guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
//                        print("Top-level document does not exist")
//                        return
//                    }
//                    
//                    let nestedCollectionReference = documentSnapshot.reference.collection("received_messages")
//                    listener = nestedCollectionReference.document("sender_OEhyJNMKKvXDIjpBlpg3lG0ML2z2").addSnapshotListener { (nestedDocumentSnapshot, nestedError) in
//                        guard let nestedDocumentSnapshot = nestedDocumentSnapshot, nestedDocumentSnapshot.exists else {
//                            print("Nested document does not exist")
//                            return
//                        }
//                        
//                        
//                        nestedData = nestedDocumentSnapshot.data() ?? [:]
//                        print(nestedData as Any)
//                    }
//                }
//            }
        }
    }
}

extension ChatWindow {
    mutating func listenForNestedDataChanges() {
    }
    
    func listenForChanges() {
        topLevelCollectionReference.document("itachi@gmail.com").getDocument {  (document, error) in
            // Unwrap weak self
            if let document = document, document.exists {
                let nestedCollectionReference = document.reference.collection("received_messages")
                nestedCollectionReference.document(UserViewModel.getName()).getDocument { (nestedDocument, nestedError) in
                    if let nestedDocument = nestedDocument, nestedDocument.exists {
                        nestedData = nestedDocument.data() ?? [:]
                        print(nestedData as Any)
                    } else {
                        print("Nested document does not exist")
                    }
                }
            } else {
                print("Top-level document does not exist")
            }
        }
    }
    
    func send() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard let userEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        let userData = [
            "email": userEmail,
            "message": "test message",
            "is_read": false
        ] as [String : Any]
        
        let timestamp = Date().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: timestamp)
        let dateString = dateFormatter.string(from: date)
        
        let name = UserViewModel.getName()
        
        let docRef = Firestore.firestore().collection(AppConstants.conversations)
            .document("itachi@gmail.com")
            .collection("received_messages")
            .document(name)
        
        docRef.setData([
            dateString: userData
        ], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document updated successfully!")
            }
        }
    }
}

// MARK: - PREVIEW

#Preview {
    ChatWindow()
}
