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
    
    var body: some View {
        
        // MARK: - HEADER
        
        // MARK: - BODY
        
        // MARK: - FOOTER
        
        VStack(spacing: 20) {
            Button(action: {
                ChatManager.sendMessage()
                
            }, label: {
                Text("Send")
            })
            
            Button(action: {
                ChatManager.fetchMessages()
            }, label: {
                Text("Fetch")
            })
        }
        
        
    }
}


// MARK: - PREVIEW

#Preview {
    ChatWindow()
}
