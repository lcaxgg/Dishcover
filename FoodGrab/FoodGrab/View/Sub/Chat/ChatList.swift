//
//  ChatList.swift
//  FoodGrab
//
//  Created by j8bok on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatList: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    
    //temp
    @State private var nestedData: [String: Any] = [:] // Assuming your nested data structure
    
    let db = Firestore.firestore()
    let topLevelCollectionReference = Firestore.firestore().collection("Conversation")
    @State var listener: ListenerRegistration?
    
    var body: some View {
        HStack(alignment: .center, spacing: 20.0) {
            Group {
                Color(AppConstants.lightGrayTwo)
                    .frame(width: screenSize.width * 0.12, height: screenSize.height * 0.065)
                    .cornerRadius(13.0)
                    .overlay(
                        Group {
                            let firstImageModifier = ImageModifier(contentMode: .fill, color: AppConstants.white)
                            
                            Image(systemName: AppConstants.personXmark)
                                .configure(withModifier: firstImageModifier)
                                .opacity(0.7)
                                .frame(width: screenSize.width * 0.07, height: screenSize.height * 0.032)
                        }
                            .padding(.top, 2.0)
                            .padding(.trailing, 2.0)
                    )
            }
            
            VStack(spacing: 8.0) {
                HStack {
                    Group {
                        let firstTextModifier = [TextModifier(font: .system(size: 16.0, weight: .semibold, design: .rounded), color: AppConstants.black)]
                        
                        Text("Full Name")
                            .configure(withModifier: firstTextModifier)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 5.0) {
                        Group {
                            let secondTextModifier = [TextModifier(font: .system(size: 13.0, weight: .light, design: .rounded), color: AppConstants.black)]
                            
                            Text("12:00")
                                .configure(withModifier: secondTextModifier)
                        }
                        
                        Group {
                            let secondImageModifier = ImageModifier(contentMode: .fill, color: AppConstants.black)
                            
                            Image(systemName: AppConstants.chevronRight)
                                .configure(withModifier: secondImageModifier)
                                .opacity(0.7)
                                .frame(width: screenSize.width * 0.014, height: screenSize.height * 0.014)
                        }
                    }
                }
                
                HStack {
                    Group {
                        let thirdTextModifier = [TextModifier(font: .system(size: 12.0, weight: .light, design: .rounded), color: AppConstants.darkGrayOne)]
                        
                        Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat")
                            .configure(withModifier: thirdTextModifier)
                            .lineLimit(2)
                            .lineSpacing(1.0)
                    }
                    
                    Spacer()
                }
            }
        }//: HStack
        .onTapGesture(perform: {
            ChatDownloadManager.shared.fetchMessagesFromServer()
        })
    }
}

extension ChatList {
    func getAllDocs() {
        topLevelCollectionReference.document("itachi@gmail.com").getDocument { document, error in
            if let document = document, document.exists {
                let nestedCollectionReference = document.reference.collection("received_messages")
                
                nestedCollectionReference.getDocuments { (querySnapshot, error) in
                    if let documents = querySnapshot?.documents {
                        for document in documents {
                            print(document.data())
                        }
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW

#Preview {
    ChatList(screenSize: CGSize())
}
