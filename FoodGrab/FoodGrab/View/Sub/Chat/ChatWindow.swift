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
        
        Button(action: {
            //ChatService.sendMessage()
        }, label: {
            Text("Send")
        })
        .onAppear {
        }
    }
}


// MARK: - PREVIEW

#Preview {
    ChatWindow()
}
