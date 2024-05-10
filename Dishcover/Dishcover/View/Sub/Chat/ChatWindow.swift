//
//  ChatWindow.swift
//  Dishcover
//
//  Created by j8bok on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatWindow: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    
    private var customBackButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
            
            Image(systemName: "arrow.backward")
                .configure(withModifier: imageModifier)
        }
    }
    }
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        // MARK: - HEADER
        
        // MARK: - BODY
        
        // MARK: - FOOTER
        
        VStack(spacing: 20.0) {
            
        }//: VStack
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: customBackButton.frame(width: screenSize.width * 0.034, height: screenSize.height * 0.034))
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.customWhite)
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                HStack {
                    Group {
                        let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
                        
                        Image(systemName: "person.circle.fill")
                            .configure(withModifier: imageModifier)
                            .clipShape(Circle())
                            .frame(width: screenSize.width * 0.040, height: screenSize.height * 0.040)
                            .padding(.leading, -(screenSize.width / 2) + screenSize.width * 0.135)
                    }
                }
            })
        }
    }
}


// MARK: - PREVIEW

#Preview {
    ChatWindow(screenSize: CGSize())
}
